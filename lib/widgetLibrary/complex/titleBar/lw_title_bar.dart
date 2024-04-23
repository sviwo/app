import 'package:atv/config/conf/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../basic/colors/lw_colors.dart';
import '../../utils/size_util.dart';

import '../../basic/font/lw_font_weight.dart';
import '../../lw_widget.dart';

/// 标题栏构建器（含statusBar）
typedef void OnBackPressed(
    {Map<String, dynamic>? resultParams, List<String>? untilRoutes});

class LWTitleBar {
  bool onlyStatusBar = false;

  // 标题
  Widget? titleWidget; // 自定义标题
  String? titleName; // 标题文本
  Color? titleColor; // 标题颜色
  double? titleFontSize; // 标题大小
  bool titleCenter; // 标题是否居中
  double? titleHeight;

  // 左侧按钮区
  bool hasBackIcon; // 是否有返回图标
  Widget? backIcon; // 返回图标资源
  OnBackPressed? onBackPressed; // 返回操作方法
  double? leadingWidth;
  Widget? leadingWidget;

  // 右侧按钮区
  List<Widget>? actions;

  // 背景&样式
  bool brightnessLight; // 状态栏是否浅色
  Color backgroundColor; // 标题栏背景
  double? backgroundAlpha; // 标题栏透明度

  LWTitleBar({
    this.titleWidget,
    this.titleName,
    this.titleColor,
    this.titleFontSize,
    this.titleCenter = true,
    this.titleHeight,
    this.hasBackIcon = true,
    this.backIcon,
    this.onBackPressed,
    this.leadingWidth,
    this.leadingWidget,
    this.actions,
    this.brightnessLight = false,
    this.backgroundColor = Colors.transparent,
    this.backgroundAlpha = 0,
    this.onlyStatusBar = false,
  });

  AppBar? build({bool isSliver = false}) {
    if (titleWidget == null &&
        titleName?.isNotEmpty != true &&
        !onlyStatusBar) {
      if (actions?.isNotEmpty != true) {
        return null;
      } else {
        hasBackIcon = false;
      }
    }

    // 通过透明度参数计算背景与文本颜色
    if (backgroundAlpha != null) {
      if (backgroundAlpha! < 0) backgroundAlpha = 0;
      if (backgroundAlpha! > 1) backgroundAlpha = 1;
    }
    Color textColor =
        titleColor ?? (backgroundAlpha == 0 ? Colors.white : LWColors.gray1);
    Color appbarColor =
        backgroundAlpha == 0 ? Colors.transparent : backgroundColor;
    bool isLight = backgroundAlpha == 0;
    if (backgroundAlpha != null && backgroundAlpha! > 0) {
      appbarColor = Colors.white.withOpacity(backgroundAlpha!);
      isLight = backgroundAlpha! < 0.5;
      textColor = Color.alphaBlend(
          LWColors.gray1.withOpacity(backgroundAlpha!), Colors.white);
    }

    if (onlyStatusBar) {
      return AppBar(
        backgroundColor: appbarColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarBrightness:
              brightnessLight ? Brightness.dark : Brightness.light, // iOS
          statusBarIconBrightness:
              brightnessLight ? Brightness.light : Brightness.dark, // Android
          // tips-230531: iOS和Android的状态栏图标的Brightness是相反的
        ),
        elevation: 0,
        toolbarHeight: 0.dp,
      );
    } else {
      var _titleWidget = _buildTitleWidget(textColor);
      var _leftWidget = _buildLeftWidget(textColor);

      return AppBar(
        backgroundColor: appbarColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarBrightness:
              brightnessLight ? Brightness.dark : Brightness.light, // iOS
          statusBarIconBrightness:
              brightnessLight ? Brightness.light : Brightness.dark, // Android
          // tips-230531: iOS和Android的状态栏图标的Brightness是相反的
        ),
        elevation: 0,
        centerTitle: titleCenter,
        title: _titleWidget,
        toolbarHeight: titleHeight ?? 40.dp,
        leading: _leftWidget,
        leadingWidth: leadingWidth ??
            (_leftWidget == null && titleWidget != null ? 0 : null),
        titleSpacing: _leftWidget == null && titleWidget != null ? 0 : null,
        automaticallyImplyLeading: _leftWidget != null,
        actions: actions,
      );
    }
  }

  SliverAppBar buildToSliver(
      {required double expandedHeight, Widget? expandedWidget}) {
    if (titleWidget == null &&
        titleName?.isNotEmpty != true &&
        actions?.isNotEmpty == true) {
      hasBackIcon = false;
    }

    // 通过透明度参数计算背景与文本颜色
    if (backgroundAlpha != null) {
      if (backgroundAlpha! < 0) backgroundAlpha = 0;
      if (backgroundAlpha! > 1) backgroundAlpha = 1;
    }
    Color textColor =
        backgroundAlpha == 0 ? Colors.white : (titleColor ?? LWColors.gray1);
    Color appbarColor =
        backgroundAlpha == 0 ? Colors.transparent : backgroundColor;
    bool isLight = backgroundAlpha == 0;
    if (backgroundAlpha != null && backgroundAlpha! > 0) {
      appbarColor = Colors.white.withOpacity(backgroundAlpha!);
      isLight = backgroundAlpha! < 0.5;
      textColor = Color.alphaBlend(
          LWColors.gray1.withOpacity(backgroundAlpha!), Colors.white);
    }

    var _titleWidget = _buildTitleWidget(textColor);
    var _leftWidget = _buildLeftWidget(textColor);

    return SliverAppBar(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            brightnessLight ? Brightness.dark : Brightness.light, // iOS
        statusBarIconBrightness:
            brightnessLight ? Brightness.light : Brightness.dark, // Android
      ),
      elevation: 0,
      centerTitle: titleCenter,
      title: _titleWidget,
      toolbarHeight: 40.dp,
      leading: _leftWidget,
      leadingWidth: leadingWidth ??
          (_leftWidget == null && titleWidget != null ? 0 : null),
      titleSpacing: _leftWidget == null && titleWidget != null ? 0 : null,
      automaticallyImplyLeading: _leftWidget != null,
      actions: actions,
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      snap: false,
      stretch: false,
      flexibleSpace: expandedWidget == null
          ? null
          : FlexibleSpaceBar(background: expandedWidget),
    );
  }

  // 构建标题
  Widget? _buildTitleWidget(Color textColor) {
    Widget? _titleWidget;
    if (titleWidget != null) {
      _titleWidget = titleWidget;
    } else if (titleName?.isNotEmpty == true) {
      _titleWidget = Text(
        titleName!,
        style: TextStyle(
            fontSize: titleFontSize ?? 16.sp,
            fontWeight: LWFontWeight.bold,
            color: textColor),
      );
    }
    return _titleWidget;
  }

  // 左侧按钮区
  Widget? _buildLeftWidget(Color textColor) {
    Widget? _leftWidget;
    if (leadingWidget != null) {
      _leftWidget = leadingWidget;
    } else if (titleWidget != null && !titleCenter) {
      _leftWidget = null;
    } else if (hasBackIcon) {
      _leftWidget = IconButton(
          onPressed: () => onBackPressed?.call(),
          icon: backIcon ??
              Image.asset(
                AppIcons.imgCommonBackIcon,
                width: 7.33.dp,
                height: 12.67.dp,
                color: textColor,
              ));
    }
    return _leftWidget;
  }
}
