import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../basic/colors/lw_colors.dart';
import '../../lw_widget.dart';

class LWToast {
  /// 普通提示文字
  static show(String text, {int? duration, VoidCallback? whenComplete}) {
    // if (EasyLoading.isShow) return;
    _initStyle(duration: duration);
    EasyLoading.showToast(text);

    if (whenComplete != null) {
      Future.delayed(Duration(milliseconds: (duration ?? 2000) + 100), (() {
        whenComplete.call();
      }));
    }
  }

  static hide() {
    EasyLoading.dismiss();
  }

  /// 成功提示文字
  static success(String text, {int? duration}) {
    Widget icon = LWWidget.assetSvg(
      'ic_toast_success.svg',
      width: EasyLoading.instance.indicatorSize,
      height: EasyLoading.instance.indicatorSize,
      color: EasyLoading.instance.indicatorColor,
    );

    LWToast.icon(text, icon, duration: duration);
  }

  /// 失败提示文字
  static failed(String text, {int? duration}) {
    Widget icon = LWWidget.assetSvg(
      'ic_toast_failed.svg',
      width: EasyLoading.instance.indicatorSize,
      height: EasyLoading.instance.indicatorSize,
      color: EasyLoading.instance.indicatorColor,
    );

    LWToast.icon(text, icon, duration: duration);
  }

  /// 警示提示文字
  static warning(String text, {int? duration}) {
    Widget icon = LWWidget.assetSvg(
      'ic_toast_warning.svg',
      width: EasyLoading.instance.indicatorSize,
      height: EasyLoading.instance.indicatorSize,
      color: EasyLoading.instance.indicatorColor,
    );

    LWToast.icon(text, icon, duration: duration);
  }

  /// 自定义图标提示文字
  static icon(String text, Widget icon, {int? duration}) {
    _initStyle(duration: duration);

    EasyLoading.show(status: _resetText(text), indicator: icon);

    // 2秒后关闭
    Future.delayed(EasyLoading.instance.displayDuration, (() {
      EasyLoading.dismiss();
    }));
  }

  static _initStyle({int? duration}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = LWColors.gray1.opacity80
      ..indicatorColor = Colors.white
      ..indicatorSize = 38.w
      ..textColor = Colors.white
      ..fontSize = 14.sp
      ..contentPadding = EdgeInsets.symmetric(
        vertical: 16.w,
        horizontal: 20.w,
      )
      ..displayDuration = Duration(milliseconds: duration ?? 2000)
      ..radius = 10.w;
  }

  static String _resetText(String text) {
    // 每行最多7个字符
    List<String> texts = [];
    String _text = text;
    while (_text.isNotEmpty) {
      int index = min(7, _text.length);
      texts.add(_text.substring(0, index));
      _text = _text.substring(index, _text.length);
    }
    return texts.join('\n');
  }
}
