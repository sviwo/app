import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgetLibrary/basic/button/lw_button.dart';
import '../../widgetLibrary/basic/colors/lw_colors.dart';
import '../../widgetLibrary/complex/page/lw_empty.dart';
import '../../widgetLibrary/complex/page/lw_refresh.dart';
import '../../widgetLibrary/complex/titleBar/lw_title_bar.dart';
import '../../widgetLibrary/utils/over_scroll_none_behavior.dart';
import '../../widgetLibrary/utils/size_util.dart';
import '../conf/arch_event.dart';
import '../utils/log_util.dart';
import 'base_page.dart';
import 'base_paging_page.dart';
import 'base_view_model.dart';
import '../../archs/utils/extension/ext_string.dart';
import 'event_manager.dart';

/// 页面状态
enum PageState {
  prepare(value: 'prepare'), // 初始态
  loading(value: 'loading'), // 加载中
  empty(value: 'empty'), // 空数据
  error(value: 'error'), // 服务错误
  content(value: 'content'); // 正文

  final String value;

  const PageState({required this.value});

  static PageState valueOf(String? value) {
    switch (value) {
      case 'prepare':
        return PageState.prepare;
      case 'loading':
        return PageState.loading;
      case 'empty':
        return PageState.empty;
      case 'error':
        return PageState.error;
      default:
        return PageState.content;
    }
  }
}

/// 基于MVVM的基类页
///   1. 以下为页面分区示意
///     1）statusBar(状态栏)、safeArea(安全区)为系统自带概念
///     2）titleBar(标题栏)，包含标准标题栏、自定义标题栏登。PS: titleBar组件需要控制statusBar样式
///     3）titleBottom(标题底部区)，包含搜索框、过滤器、TAB组等不会跟随body滑动的组件
///     4）body(正文区)，包含列表、详情等多种内容样式
///     5）bottomBar(底部栏)，包含按钮组、已选择套件等
///
///   |---------------statusBar---------------|
///   |---------------------------------------|
///   |               titleBar                |   通过titleName()、buildTitleBar()、buildTitleActionsXX()构建
///   |---------------------------------------|
///   |               titleBottom             |   通过buildTitleBottom()构建
///   |---------------------------------------|
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |               body                    |   通过buildBody()构建
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |                                       |
///   |---------------------------------------|
///   |               bottomBar               |   通过buildBottomBar()、buildBottomActionsXX()构建
///   |---------------------------------------|
///   |---------------safeArea----------------|
///
///   2. pageState
///     1）配套VM，会影响当前页面state的取值（通过AppEvent.pageStateChanged进行响应）
///     2）empty，只影响body区域
///     3）error，会影响body、bottomBar区域
///     4）通过AppEvent.pageStateChanged响应配套VM的发起的页面变化
///     5）isSupportPageState()，用于决定当前页面是否支持pageState管理
///     6）onPageStateChanged()，响应页面状态的变化
///
///   3. 通用method
///     1）pageRefresh()，支持配套VM调用（通过AppEvent.pageRefresh进行响应）
///     2) pagePush()/pagePop()，支持配套VM调用（通过AppEvent.pagePush&AppEvent.pagePop进行响应）
///     3）dataRefresh()，调用配套VM的loadData（支持配套VM调用，通过事件通知），另外支持自定义实现
///     4）showLoading()/hideLoading()，支持配套VM调用（通过AppEvent.showLoading&AppEvent.hideLoading进行响应）
///
///   4. 数据初始化
///     1）initializeVMBefore()，用于在初始化开始之前进行必要的处理
///     2）initializeVMAfter()，用于在初始化开始之后进行必要的处理
///     3）initializeVM()
///
///   5. 特别说明
///     1）列表页面的「共xx条yy数据」，需要放置在titleBottom，并通过pageState==PageState.content控制展示与隐藏
///     2）MvvmPage与VM设计了一套主数据概念，通过refreshData&loadData进行关联，并通过pageState控制页面状态
///     3）页面按有无背景图分为两大类，通过headerBackgroundImage()传入背景图，页面滑动时，背景图同步滑动（并控制标题栏颜色变化）
///
abstract class BaseMvvmPage<VM extends BaseViewModel> extends BasePage {
  BaseMvvmPage({super.key, super.route, super.args});
}

abstract class BaseMvvmPageState<T extends BaseMvvmPage,
    VM extends BaseViewModel> extends BasePageState<T> {
  @protected
  late VM viewModel;
  bool _isFirstBuild = true;
  @protected
  String? stateMsg;
  @protected
  bool dataReady = false;

  /// 业务逻辑慎重调用
  @protected
  var pageState = PageState.prepare;

  /// 用于控制页面下拉刷新
  RefreshController? _refreshController;

  /// 用于监听全页面滑动
  ScrollController? _headerScrollController;

  /// 顶部图片背景
  ///   - 默认全页面可以滑动
  @protected
  String? headerBackgroundImage() => null;

  /// 背景Widget
  ///   - 默认全页面可以滑动
  @protected
  Widget? headerBackgroundWidget() => null;

  /// tips: 覆写该方法需要调用super.initState()
  @override
  void initState() {
    super.initState();
    if ((!headerBackgroundImage().isNullOrEmpty() ||
            headerBackgroundWidget() != null) &&
        isSupportSmoothTitleBar()) {
      _headerScrollController = ScrollController();
      _headerScrollController!.addListener(() {
        pageRefresh(() {});
      });
    }
    if (isSupportPageState()) {
      EventManager.register(context, ArchEvent.pageStateChanged, (args) {
        if (mounted) {
          LogUtil.d(
              '$args, $hashCode, $this, ${viewModel.hashCode}, $viewModel');
          if (args['hashCode'] == null || args['pageState'] == null) {
            throw Exception(
                'AppEvent.pageStateChanged cannot invoke in logic!');
          }
          if (args['hashCode'] == hashCode) {
            stateMsg = args['stateMsg'];
            pageState = PageState.valueOf(args['pageState']);
            dataReady = args['dataReady'] ?? dataReady;
            onPageStateChanged();
            pageRefresh(() {});
          }
        }
      });
      //dataRefreshFinished
    }
    EventManager.register(context, ArchEvent.dataRefresh, (arg) {
      if (arg['hashCode'] == hashCode) {
        dataRefresh();
      }
    });
    EventManager.register(context, ArchEvent.dataRefreshFinished, (arg) {
      if (arg['hashCode'] == hashCode) {
        dataRefreshFinish();
      }
    });
  }

  @override
  void pageRefresh(VoidCallback fn, {dynamic args}) {
    if (args != null) {
      if (args['hashCode'] != 0 && args['hashCode'] != hashCode) {
        return;
      } else {
        dataReady = args['dataReady'] ?? dataReady;
      }
    }
    updateState(fn);
  }

  /// 初始化之前（在ViewModel初始化执行之前调用）
  @protected
  void initializeVMBefore() {}

  /// 初始化之后（在ViewModel初始化执行之后调用）
  ///   - VM真正的初始化放置这里，当该方法重写后，部分特殊逻辑就不会自动触发VM初始化
  ///     故重写该方法后，需手动调用VM的initialize(args)，或者调用super.initializeVMAfter()
  @protected
  void initializeVMAfter() {
    viewModel.initialize(args);
  }

  @protected
  void initializeVM() {
    viewModel = viewModelProvider();
    viewModel.pageHashCode = hashCode;
    initializeVMBefore();
    initializeVMAfter();
  }

  @protected
  VM viewModelProvider();

  /// tips: 覆写该方法需要调用super.dispose()
  @override
  void dispose() {
    _headerScrollController?.dispose();
    _refreshController?.dispose();
    releaseVM();
    // if (!isFullPage) {
    //   // fullPage=true，onBackPressed自动调用releaseVm
    //   // fullPage=false，需要手动调用releaseVM
    //   releaseVM();
    // }
    super.dispose();
  }

  /// tips: 覆写该方法需要调用super.releaseVM()
  @override
  void releaseVM() {
    if (isSupportPageState()) {
      EventManager.unregister(context, ArchEvent.pageStateChanged);
    }
    EventManager.unregister(context, ArchEvent.dataRefresh);
    EventManager.unregister(context, ArchEvent.dataRefreshFinished);

    stateMsg = null;
    pageState = PageState.content;
    // LogUtil.d("============$runtimeType");
    viewModel.release();
  }

  /// 是否响应页面状态变化
  ///   - 多子页面时，主页面如果没有接口调用，需重写该方法并返回false
  @protected
  bool isSupportPageState() => true;

  /// 是否支持页面下拉刷新
  @protected
  bool isSupportPullRefresh() => false;

  /// 是否支持添加页面滚动组件
  ///   - 若自身存在ScrollView，值需要设为false
  ///   - 若需要父类添加滚动组件，值需要设为true
  @protected
  bool isSupportScrollView() => false;

  /// 是否支持平滑滚动（标题栏颜色动态变化）
  @protected
  bool isSupportSmoothTitleBar() => true;

  /// 响应页面状态变化
  @protected
  void onPageStateChanged() {
    dataRefreshFinish();
  }

  @protected
  void dataRefresh() {
    if (!isSupportPullRefresh() || pageState != PageState.content) {
      viewModel.loadData(showLoading: true);
    } else {
      _refreshController?.requestRefresh(
          duration: const Duration(milliseconds: 100));
    }
  }

  @protected
  void dataRefreshFinish() {
    if (pageState != PageState.loading) {
      _refreshController?.refreshCompleted();
      _refreshController?.loadComplete();
    }
  }

  @protected
  void dataLoadMore() {}

  /// 页面标题（仅限fullPage）
  @protected
  String? titleName() => null;

  /// 页面标题栏（仅限fullPage）
  ///   - tips: 该方法优先级比titleName()高
  @protected
  LWTitleBar? buildTitleBar() => null;

  /// 标题栏操作按钮组（仅限fullPage）
  ///   - 标题栏按钮数不能超过2个
  ///   - 传入的MapList为按钮组（使用默认样式）
  @protected
  List<MapEntry<String, Function>>? buildTitleActions() => null;

  /// 标题栏操作按钮组（仅限fullPage）
  ///   - 标题栏按钮数不能超过2个
  ///   - 传入的List为按钮组（可以自定义样式）
  @protected
  List<Widget>? buildTitleActions2() => null;

  /// 过滤器等布局
  ///   - 一般传入一个Column，含搜索框、过滤器、TAB组等不跟随body滑动的页面要素
  @protected
  Widget? buildTitleBottom() => null;

  /// 正文区布局
  @protected
  Widget buildBody(BuildContext context);

  /// 底部栏操作按钮组（仅限fullPage）
  ///   - 需自行控制底部栏高度（注意safeArea）
  @protected
  Widget? buildBottomBar() => null;

  /// 底部栏操作按钮组（仅限fullPage）
  ///   - 操作区按钮数不能超过3个
  ///   - 传入的MapList为按钮组（使用默认样式）
  @protected
  List<MapEntry<String, Function>>? buildBottomActions() => null;

  /// 底部栏操作按钮组（仅限fullPage）
  ///   - 操作区按钮数不能超过3个
  ///   - 传入的List为按钮组（可以自定义样式）
  @protected
  List<Widget>? buildBottomActions2() => null;

  @override
  Widget build(BuildContext context) {
    //
    if (_isFirstBuild) {
      initializeVM();
      _isFirstBuild = false;
    }

    Widget body = bodyBuilder();
    var filter = buildTitleBottom();
    if (filter != null) {
      body = Column(children: [
        filter,
        Expanded(child: Container(color: super.backgroundColor, child: body))
      ]);
    }

    Widget page;
    if (!isFullPage) {
      page = body;
    } else {
      var headerImage = headerBackgroundImage();
      var headerWidget = headerBackgroundWidget();
      var smoothTitleBar = isSupportSmoothTitleBar();
      var isPageError = pageState == PageState.error;
      if (isPageError ||
          (headerImage.isNullOrEmpty() && headerWidget == null) ||
          !smoothTitleBar) {
        page = _bodyBuilderNormal(body);
      } else {
        if (filter != null) {
          body = Column(children: [filter, Expanded(child: bodyBuilder())]);
        }
        page = _bodyBuilderWithHeaderImage(body);
      }
    }
    return page;
  }

  /// 正文区构建器
  /// tips: 业务逻辑页面原则上不允许重写该方法，这里仅开放给子基类页（如：BasePagingPage）
  @protected
  Widget bodyBuilder() {
    Widget body;
    switch (pageState) {
      case PageState.empty:
        body = LWEmpty(
          emptyType: LWEmptyType.notData,
          emptyTips: stateMsg ?? LocaleKeys.no_data_tips.tr(),
          onTapAction: () => dataRefresh(),
        );
        break;
      case PageState.error:
        body = LWEmpty(
          emptyType: LWEmptyType.loadFailed,
          emptyTips: stateMsg ?? LocaleKeys.server_exception.tr(),
          actionText: LocaleKeys.click_retry.tr(),
          onTapAction: () => dataRefresh(),
        );
        break;
      case PageState.loading:
      case PageState.content:
      default:
        if (isSupportPullRefresh() && this is! BasePagingPageState) {
          body = LWRefresh(
            onRefresh: () =>
                viewModel.loadData(isRefresh: true, showLoading: false),
            enablePullUp: false,
            enablePullDown: true,
            onControllerCallback: (controller) =>
                _refreshController = controller,
            scrollController: _headerScrollController,
            child: buildBody(context),
          );
        } else {
          body = buildBody(context);
        }
    }
    return body;
  }

  /// 正文区构建器-常规页面布局（含异常处理）
  Widget _bodyBuilderNormal(Widget body) {
    var isPageError = pageState == PageState.error;
    var titleBar = buildTitleBar();
    if (titleBar != null) {
      if (titleBar.actions?.isNotEmpty != true) {
        titleBar.actions = _titleActionsBuilder();
      }
    }
    var headerImage = headerBackgroundImage() ?? '';
    var headerWidget = headerBackgroundWidget();
    if (headerImage.isNullOrEmpty() && headerWidget == null) {
      return pageBuilder(
        titleName(),
        backgroundColor: super.backgroundColor,
        titleBar: titleBar ??
            LWTitleBar(titleName: titleName(), actions: _titleActionsBuilder()),
        body: body,
        bottomBar: isPageError ? null : bottomBarBuilder(),
      );
    } else {
      return Container(
        color: super.backgroundColor,
        child: Stack(
          children: [
            Visibility(
              visible: headerImage.isNotEmpty,
              child: Positioned(
                top: 0,
                width: SizeUtil.screenWidth,
                child: Image.asset(headerImage, width: SizeUtil.screenWidth),
              ),
            ),
            Visibility(
              visible: headerWidget != null,
              child: Positioned(
                top: 0,
                width: SizeUtil.screenWidth,
                child: SizedBox(
                  width: SizeUtil.screenWidth,
                  child: headerWidget,
                ),
              ),
            ),
            pageBuilder(
              titleName(),
              backgroundColor: Colors.transparent,
              titleBar: titleBar ??
                  LWTitleBar(
                      titleName: titleName(), actions: _titleActionsBuilder()),
              body: body,
              bottomBar: isPageError ? null : bottomBarBuilder(),
            )
          ],
        ),
      );
    }
  }

  /// 正文区构建器-全页面滑动布局
  Widget _bodyBuilderWithHeaderImage(Widget body) {
    // LogUtil.d('---------------------${runtimeType.toString()}');
    var headerImage = headerBackgroundImage() ?? '';
    var headerWidget = headerBackgroundWidget();
    var scrollOffset = _headerScrollController!.hasClients
        ? _headerScrollController!.offset
        : 0.0;

    var image = Image.asset(headerImage, width: SizeUtil.screenWidth);
    double ratio = 0;
    if (headerImage.isNullOrEmpty() == false) {
      image.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((ImageInfo info, bool _) {
        // 计算标题栏背景渐变
        var w1 = info.image.width;
        var h1 = info.image.height;
        var h2 = h1 / (w1 / SizeUtil.screenWidth);
        ratio = scrollOffset / h2;
        if (ratio > 1) ratio = 1;
      }));
    }

    var titleBar = buildTitleBar();
    if (titleBar != null) {
      titleBar.backgroundAlpha = ratio;
      if (titleBar.actions?.isNotEmpty != true) {
        titleBar.actions = _titleActionsBuilder();
      }
    }
    return Container(
      color: super.backgroundColor,
      child: Stack(
        children: [
          Visibility(
              visible: headerImage.isNullOrEmpty() == false,
              child: Positioned(
                top: ratio < 0 ? null : -scrollOffset,
                width: SizeUtil.screenWidth,
                child: image,
              )),
          Visibility(
            visible: headerWidget != null,
            child: Positioned(
              top: 0,
              width: SizeUtil.screenWidth,
              child: SizedBox(
                width: SizeUtil.screenWidth,
                child: headerWidget,
              ),
            ),
          ),
          // page,
          pageBuilder(
            titleName(),
            titleBar: titleBar ??
                LWTitleBar(
                    titleName: titleName(),
                    backgroundAlpha: ratio,
                    actions: _titleActionsBuilder()),
            backgroundColor: Colors.transparent,
            body: isSupportPullRefresh() ||
                    !isSupportScrollView() ||
                    this is BasePagingPageState
                ? body
                : ScrollConfiguration(
                    behavior: OverScrollNoneBehavior(),
                    child: SingleChildScrollView(
                      controller: _headerScrollController,
                      child: body,
                    ),
                  ),
            bottomBar: bottomBarBuilder(),
          )
        ],
      ),
    );
  }

  /// 标题栏按钮区构建器
  List<Widget>? _titleActionsBuilder() {
    //
    var actions1 = buildTitleActions2();
    if (actions1?.isNotEmpty == true) {
      if (actions1!.length > 2) throw Exception('标题栏按钮数不能超过2个');
      return actions1;
    }

    //
    var actions2 = buildTitleActions();
    if (actions2 == null) return null;
    if (actions2.length > 2) throw Exception('标题栏按钮数不能超过2个');
    List<Widget> newActions = [];
    for (var index = 0; index < actions2.length; index++) {
      newActions.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => actions2[index].value.call(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.dp),
          alignment: Alignment.center,
          child: Text(
            actions2[index].key,
            style: TextStyle(
                fontSize: 16,
                color: const Color(0xff36BCB3),
                fontWeight: LWFontWeight.bold),
          ),
        ),
      ));
    }
    newActions.add(SizedBox(
      width: 20.dp,
    ));
    return newActions;
  }

  /// 底部按钮区构建器
  /// tips: 业务逻辑页面原则上不允许重写该方法，这里仅开放给子基类页（如：BaseCollapsiblePage）
  @protected
  Widget? bottomBarBuilder() {
    //
    var actions0 = buildBottomBar();
    if (actions0 != null) {
      // 传入的bottomBar为完全尺寸，bottomBarHeight = 62
      return Material(
        elevation: bottomBarElevation,
        child: Container(
          color: Colors.white,
          height: bottomBarHeight + screenBottom,
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: bottomBarHeight,
            child: Center(child: actions0),
          ),
        ),
      );
    }

    //
    List<Widget> newActions = [];
    var actions1 = buildBottomActions2();
    var actions2 = buildBottomActions();
    if (actions1?.isNotEmpty == true) {
      if (actions1!.length > 3) throw Exception('操作区按钮数不能超过3个');
      for (var index = actions1.length - 1; index >= 0; index--) {
        var isFirst = index == 0;
        var item = actions1[index];
        if (item is Expanded)
          newActions.insert(0, item);
        else
          newActions.insert(0, Expanded(flex: 1, child: item));
        if (!isFirst) {
          newActions.insert(0, const SizedBox(width: 12));
        }
      }
    } else if (actions2?.isNotEmpty == true) {
      if (actions2!.length > 3) throw Exception('操作区按钮数不能超过3个');
      for (var index = actions2.length - 1; index >= 0; index--) {
        var isLast = index == actions2.length - 1;
        var isFirst = index == 0;
        newActions.insert(
          0,
          Expanded(
            flex: 1,
            child: LWButton.primary(
              stroke: !isLast,
              text: actions2[index].key,
              onPressed: () {
                actions2[index].value.call();
              },
            ),
          ),
        );
        if (!isFirst) {
          newActions.insert(0, const SizedBox(width: 12));
        }
      }
    }

    return newActions.isEmpty
        ? null
        : Material(
            elevation: bottomBarElevation,
            child: Container(
              color: Colors.white,
              height: bottomBarHeight + screenBottom,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: SizedBox(
                height: bottomBarHeight,
                child: Center(child: Row(children: newActions)),
              ),
            ),
          );
  }
}
