import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../utils/size_util.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({
    super.key,
    this.titleName,
    this.route,
    this.args,
  });
  String? titleName;
  dynamic route;
  dynamic args;
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  dynamic route;
  dynamic args;
  bool get isFullPage => (route is String) && (route as String).isNotEmpty;

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
    return SizeUtil.dp(62);
  }

  // 底部栏阴影
  double get bottomBarElevation {
    return 0;
  }

  // 页面背景色
  Color get backgroundColor {
    return const Color(0xFFF4F4F4);
  }

  /// 页面安全刷新，用于替换setState方法
  @protected
  void pageRefresh(VoidCallback fn, {dynamic args}) {
    _updateState(fn);
  }

  @protected
  void _updateState(VoidCallback fn) {
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    if (schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(fn);
      });
    } else {
      setState(fn);
    }
  }

  Widget pageBuilder(
    String? titleName, {
    bool? resizeToAvoidBottomInset,
    Widget? body,
    Color? backgroundColor,
  }) {
    var _titleWidget = Text(
      titleName ?? widget.runtimeType.toString(),
      style: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
    );
    var _backIcon = IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.backspace));
    var appbar = AppBar(
      backgroundColor: Colors.red,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light, // iOS
        statusBarIconBrightness: Brightness.dark, // Android
      ),
      elevation: 0,
      centerTitle: true,
      title: _titleWidget,
      toolbarHeight: 44.dp,
      leading: Navigator.of(context).canPop() ? _backIcon : null,
      leadingWidth: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: true,
    );

    return Scaffold(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appbar,
      body: body,
    );
  }

  @protected
  Widget buildBody(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return pageBuilder(widget.titleName,body: buildBody(context));
  }
}
