import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../widgetLibrary/basic/button/lw_button.dart';
import '../../widgetLibrary/basic/colors/lw_colors.dart';
import '../../widgetLibrary/complex/titleBar/lw_title_bar.dart';
import '../../widgetLibrary/complex/toast/lw_toast.dart';
import '../../widgetLibrary/utils/size_util.dart';
import '../conf/arch_conf.dart';
import '../conf/arch_event.dart';
import '../conf/channel/arch_channel.dart';
import '../conf/channel/arch_channel_msg_send.dart';
import '../conf/channel/arch_channel_msg_take.dart';
import '../data/entity/page_router.dart';
import '../lw_arch.dart';
import '../utils/log_util.dart';
import 'event_bus.dart';
import 'event_manager.dart';
import 'route_manager.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key? key, this.route, this.args}) : super(key: key);
  dynamic route;
  dynamic args; // 页面传参
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  dynamic route;
  dynamic args; // 页面传参
  bool isFullPage = false;

  // _contextXXX，用于响应退出栈顶页面的消息。
  static final List<BuildContext> _contextStack = [];
  static BuildContext? _contextLast;

  // 安全区的底部margin
  double get screenBottom {
    return MediaQuery.of(context).padding.bottom;
  }

  // statusBar高度
  double get statusBarHeight {
    return MediaQuery.of(context).padding.top;
  }

  // 标题栏高度
  double get titleBarHeight {
    return AppBar().preferredSize.height;
  }

  // 标题栏高度（含statusBar）
  double get appBarHeight {
    return statusBarHeight + titleBarHeight;
  }

  // 底部栏高度
  double get bottomBarHeight {
    return SizeUtil.dp(LWArch.pageBottomBarHeight);
  }

  // 底部栏阴影
  double get bottomBarElevation {
    return LWArch.pageBottomBarElevation;
  }

  // 页面背景色
  Color get backgroundColor {
    return LWArch.pageBackgroundColor;
  }

  /// 页面安全刷新，用于替换setState方法
  @protected
  void pageRefresh(VoidCallback fn, {dynamic args}) {
    updateState(fn);
  }

  @protected
  void updateState(VoidCallback fn) {
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    if (schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(fn);
      });
    } else {
      setState(fn);
    }
  }

  /// 关闭当前页
  void pagePop(
      {Map<String, dynamic>? resultParams, List<String>? untilRoutes}) {
    LogUtil.d('pagePop:: will pop');
    // 若是入口页面，dispose不会调用，故需要主动释放viewModel
    releaseVM();
    _releasePage();
    if (Navigator.of(context).canPop()) {
      // widget.route != BaseApp.rootRoot &&
      // 若不是入口页面，直接退回上一个flutter页
      LogUtil.d('pagePop: pop, ${toString()}');
      if (untilRoutes?.isNotEmpty == true) {
        Navigator.of(context).popUntil((e) =>
            untilRoutes!.contains(e.settings.name) || e.settings.name == '/');
      } else {
        Navigator.of(context).pop(resultParams);
      }
    } else {
      // 若是入口页面，关闭时需通知native
      // Navigator.of(context).pop();
      // Navigator.of(context).popUntil((route) => route.settings.name == '/');

      LogUtil.d('pagePop: sendNative, ${toString()}');
      ArchChannel.sendNative(ArchChannelMsgSend.commonNativePop,
          params: resultParams);
    }
  }

  /// 页面跳转
  ///   - 兼容flutter与本地容器跳转
  ///   - jumpNative模式不支持replace
  void pagePush(String route,
      {BasePage? page,
      Map<String, dynamic>? params,
      Function? callback,
      bool jumpNative = false,
      bool needReplace = false,
      bool fullscreenDialog = false}) {
    loseFocus();
    if (!LWArch.mixDevelop) jumpNative = false;
    if (jumpNative) {
      ArchChannel.nativePush(PageRouter(route, params: params))
          .then((value) => callback?.call(value));
    } else {
      LogUtil.d('pagePush, ${context}');
      var newPage = RouteManager.instance.getPage(route);
      if (page == null && newPage is PageNotFound) {
        LWToast.show('未找到指定页面，请联系技术支持');
      } else {
        if (needReplace) {
          _releasePage();
          Navigator.of(context)
              .pushReplacement(_pageRoute(route,
                  page: page,
                  params: params,
                  fullscreenDialog: fullscreenDialog))
              .then((value) => callback?.call(value));
        } else {
          Navigator.of(context)
              .push(_pageRoute(route,
                  page: page,
                  params: params,
                  fullscreenDialog: fullscreenDialog))
              .then((value) => callback?.call(value));
        }
      }
    }
  }

  /// 页面跳转(跳转的页面替换当前页面)
  void pagePushReplace(String route,
      {Map<String, dynamic>? params,
      Function? callback,
      bool fullscreenDialog = false}) {
    loseFocus();
    Navigator.of(context)
        .pushReplacement(_pageRoute(route,
            params: params, fullscreenDialog: fullscreenDialog))
        .then((value) => callback?.call(value));
  }

  MaterialPageRoute _pageRoute(String route,
      {BasePage? page,
      Map<String, dynamic>? params,
      bool fullscreenDialog = false}) {
    return MaterialPageRoute(
        builder: (BuildContext context) {
          var newPage = page ?? RouteManager.instance.getPage(route);
          newPage.route = route;
          if (params != null) {
            newPage.args = params;
          }
          return newPage;
        },
        settings: RouteSettings(name: route),
        fullscreenDialog: fullscreenDialog);
  }

  /// 实例名称
  String uniqueKey() {
    String uniqueKey = toString();
    int lastIndex = uniqueKey.indexOf("(");
    if (lastIndex == -1) {
      return uniqueKey;
    } else {
      return uniqueKey.substring(0, lastIndex);
    }
  }

  @override
  void dispose() {
    _releasePage();
    super.dispose();
  }

  /// 用于解决子类dispose时出现异常，导致基类dispose无响应问题（故重要操作不在dispose中处理）
  bool _hasRelease = false;

  void _releasePage() {
    if (_hasRelease) return;
    _hasRelease = true;
    EventManager.unregister(context, ArchEvent.pageRefresh);
    // EventBus.instance().unregister(context, ArchEvent.showLoading);
    // EventBus.instance().unregister(context, ArchEvent.hideLoading);
    EventBus.instance().unregister(context, ArchEvent.httpConfigChanged);
    if (isFullPage) {
      EventBus.instance().unregister(context, ArchEvent.pagePush);
      EventBus.instance().unregister(context, ArchEvent.pagePop);
      ArchChannel.removeTakeNatives(
          ArchChannelMsgTake.commonNativeWillPop, uniqueKey());
    }

    if (isFullPage) {
      _contextStack.remove(context);
      if (_contextStack.isNotEmpty) {
        _contextLast = _contextStack.last;
      }
    }
  }

  /// 入口页面必须实现
  @protected
  void releaseVM();

  void showLoading() {
    // 仅限当前页及其子页面show
    if (mounted && (_contextLast == context || !isFullPage)) {
      // await LWLoading.showLoading2(text: '加载中...');
      EventBus.instance().post(ArchEvent.showLoading);
    }
  }

  void hideLoading() {
    if (mounted && (_contextLast == context || !isFullPage)) {
      // await LWLoading.dismiss();
      EventBus.instance().post(ArchEvent.hideLoading);
    }
  }

  void loseFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    super.initState();
    route = widget.route;
    args = widget.args;
    isFullPage = (route is String) && (route as String).isNotEmpty;
    if (isFullPage) {
      _contextLast = context;
      _contextStack.add(context);
      // if (!LWArch.statExcludeRoutes.contains(route)) {
      //   LWStat.onPageView(context, route);
      // }
    }

    // 页面build完成后的回调
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 展示HttpLog入口
      _handleHttpLogDialog();
    });

    EventManager.register(context, ArchEvent.pageRefresh, (args) {
      pageRefresh(() {}, args: args);
    });

    // // 加载中展示隐藏事件
    // EventBus.instance().register(context, ArchEvent.showLoading, (arg) async {
    //   await showLoading();
    // });
    // EventBus.instance().register(context, ArchEvent.hideLoading, (arg) async {
    //   await hideLoading();
    // });
    EventBus.instance().register(context, ArchEvent.httpConfigChanged, (arg) {
      _handleHttpLogDialog(enable: arg['httpLogEnable']);
    });

    if (isFullPage) {
      // flutter打开指定页面
      EventBus.instance().register(context, ArchEvent.pagePush, (arg) {
        if (mounted && _contextLast == context) {
          LogUtil.d('event:: flutter will push');
          var paramsCarry = arg as Map<String, dynamic>;
          String route = paramsCarry.remove('carry_route');
          Function? callback = paramsCarry.remove('carry_callback');
          bool jumpNative = paramsCarry.remove('carry_jumpNative');
          bool needReplace = paramsCarry.remove('carry_needReplace');
          pagePush(route,
              params: paramsCarry,
              callback: callback,
              jumpNative: jumpNative,
              needReplace: needReplace);
        }
      });
      // flutter退出指定页面
      EventBus.instance().register(context, ArchEvent.pagePop, (arg) {
        if (mounted && _contextLast == context) {
          LogUtil.d('event:: flutter will pop');
          var paramsCarry = arg as Map<String, dynamic>;
          List<String>? untilRoutes = paramsCarry.remove('carry_untilRoutes');
          bool forceQuick = paramsCarry.remove('carry_forceQuick');
          var onBackPressed = _titleBarBuilder?.onBackPressed;
          if (onBackPressed == null || forceQuick) {
            pagePop(resultParams: paramsCarry, untilRoutes: untilRoutes);
          } else {
            onBackPressed(resultParams: paramsCarry, untilRoutes: untilRoutes);
          }
        }
      });
      // native退出指定页面
      ArchChannel.takeNatives(
          ArchChannelMsgTake.commonNativeWillPop, uniqueKey(), (call) async {
        if (mounted && _contextLast == context && !Platform.isIOS) {
          LogUtil.d('event:: native will pop, isIOS=${Platform.isIOS}');

          Map<String, dynamic>? paramsCarry;
          try {
            paramsCarry = jsonDecode(call.arguments);
          } catch (e) {}
          String? untilRoute = paramsCarry?.remove('carry_route');
          bool? forceQuick = paramsCarry?.remove('carry_forceQuick');
          var onBackPressed = _titleBarBuilder?.onBackPressed;
          if (onBackPressed == null || forceQuick == true) {
            pagePop(
                resultParams: paramsCarry,
                untilRoutes:
                    untilRoute?.isNotEmpty != true ? null : [untilRoute!]);
          } else {
            onBackPressed(
                resultParams: paramsCarry,
                untilRoutes:
                    untilRoute?.isNotEmpty != true ? null : [untilRoute!]);
          }
        }
      });
    }
  }

  /// ========================= 二级页面模版（返回+标题+更多+底部按钮区） =========================
  LWTitleBar? _titleBarBuilder;

  void _handleHttpLogDialog({bool? enable}) async {
    var httpLogEnable = enable ?? await ArchConf.getHttpLogEnable();
    if (httpLogEnable) {
      showDebugBtn(context, btnColor: LWColors.theme);
    } else {
      dismissDebugBtn();
    }
  }

  Widget pageBuilder(
    String? titleName, {
    LWTitleBar? titleBar,
    bool? resizeToAvoidBottomInset,
    Widget? body,
    Color? backgroundColor,
    bool onlyStatusBar = false,

    // bottomBar
    Widget? bottomBar,
    String? positiveButtonText,
    Function? positiveButtonCallback,
    bool? negativeButtonVisibleDefault,
    String? negativeButtonText,
    Function? negativeButtonCallback,
    bool? middleButtonVisibleDefault,
    String? middleButtonText,
    Function? middleButtonCallback,
  }) {
    if (titleBar != null) {
      titleBar.titleName ??= titleName;
      if (titleBar.onlyStatusBar != true) {
        titleBar.onBackPressed ??= ({resultParams, untilRoutes}) =>
            pagePop(resultParams: resultParams, untilRoutes: untilRoutes);
      }
      _titleBarBuilder = titleBar;
    } else if (!StringUtils.isNullOrEmpty(titleName)) {
      _titleBarBuilder = LWTitleBar(
          titleName: titleName,
          onlyStatusBar: onlyStatusBar,
          onBackPressed: ({resultParams, untilRoutes}) =>
              pagePop(resultParams: resultParams, untilRoutes: untilRoutes));
    } else if (onlyStatusBar) {
      _titleBarBuilder = LWTitleBar(onlyStatusBar: true);
    }

    bool isFullPage = (route is String) && (route as String).isNotEmpty;
    var newBody = body;

    // if (body != null && isFullPage) {}
    return isFullPage
        ? WillPopScope(
            onWillPop: null,
            // onWillPop: () async {
            //   LogUtil.d('onWillPop, isIOS=${Platform.isIOS}');
            //   return !Platform.isIOS;
            // },
            child: Scaffold(
              backgroundColor: backgroundColor ?? this.backgroundColor,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              appBar: _titleBarBuilder?.build(),
              body: newBody,
              bottomNavigationBar: bottomBar ??
                  _bottomBarBuilder(
                    positiveButtonText: positiveButtonText,
                    positiveButtonCallback: positiveButtonCallback,
                    negativeButtonVisibleDefault: negativeButtonVisibleDefault,
                    negativeButtonText: negativeButtonText,
                    negativeButtonCallback: negativeButtonCallback,
                    middleButtonVisibleDefault: middleButtonVisibleDefault,
                    middleButtonText: middleButtonText,
                    middleButtonCallback: middleButtonCallback,
                  ),
            ),
          )
        : body ?? Container();
  }

  bool _positionButtonVisible = true;
  String? _positionButtonText;
  bool? _negativeButtonVisible;
  String? _negativeButtonText;
  bool? _middleButtonVisible;
  String? _middleButtonText;

  /// 更换底部按钮状态
  void changeBottomBar({
    bool? positiveButtonVisible,
    String? positiveButtonText,
    bool? negativeButtonVisible,
    String? negativeButtonText,
    bool? middleButtonVisible,
    String? middleButtonText,
  }) {
    if (positiveButtonVisible != null) {
      _positionButtonVisible = positiveButtonVisible;
    }
    if (positiveButtonText?.isNotEmpty == true) {
      _positionButtonText = positiveButtonText;
    }
    if (negativeButtonVisible != null) {
      _negativeButtonVisible = negativeButtonVisible;
    }
    if (negativeButtonText?.isNotEmpty == true) {
      _negativeButtonText = negativeButtonText;
    }
    if (middleButtonVisible != null) {
      _middleButtonVisible = middleButtonVisible;
    }
    if (middleButtonText?.isNotEmpty == true) {
      _middleButtonText = middleButtonText;
    }
    setState(() {});
  }

  /// 若需展示按钮时，positiveButton为必要Widget
  Widget _bottomBarBuilder({
    String? positiveButtonText,
    Function? positiveButtonCallback,
    bool? negativeButtonVisibleDefault,
    String? negativeButtonText,
    Function? negativeButtonCallback,
    bool? middleButtonVisibleDefault,
    String? middleButtonText,
    Function? middleButtonCallback,
  }) {
    return Visibility(
      visible: positiveButtonText != null && _positionButtonVisible,
      child: Container(
        color: Colors.white,
        height: 62 + screenBottom,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Row(
          children: [
            Visibility(
              visible: negativeButtonText != null &&
                  (_negativeButtonVisible ??
                      negativeButtonVisibleDefault ??
                      true),
              child: Expanded(
                flex: 1,
                child: LWButton.primary(
                  text: _negativeButtonText ?? negativeButtonText ?? '',
                  stroke: true,
                  onPressed: () {
                    negativeButtonCallback?.call();
                  },
                ),
              ),
            ),
            Visibility(
              visible: negativeButtonText != null &&
                  (_negativeButtonVisible ??
                      negativeButtonVisibleDefault ??
                      true),
              child: const SizedBox(width: 12),
            ),
            Visibility(
              visible: middleButtonText != null &&
                  (_middleButtonVisible ?? middleButtonVisibleDefault ?? false),
              child: Expanded(
                flex: 1,
                child: LWButton.primary(
                  text: _middleButtonText ?? middleButtonText ?? '',
                  stroke: true,
                  onPressed: () {
                    middleButtonCallback?.call();
                  },
                ),
              ),
            ),
            Visibility(
              visible: middleButtonText != null &&
                  (_middleButtonVisible ?? middleButtonVisibleDefault ?? false),
              child: const SizedBox(width: 12),
            ),
            Expanded(
              flex: 1,
              child: LWButton.primary(
                text: _positionButtonText ?? positiveButtonText ?? '',
                onPressed: () {
                  positiveButtonCallback?.call();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
