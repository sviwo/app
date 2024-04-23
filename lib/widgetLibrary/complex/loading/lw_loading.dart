import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../basic/colors/lw_colors.dart';

class LWLoading {
  static int _counter = 0;

  static init({Widget Function(BuildContext, Widget?)? builder}) {
    return EasyLoading.init(builder: builder);
  }

  static Future showLoading(
      {String? status,
      EasyLoadingMaskType? maskType,
      bool? dismissOnTap,
      int? duration,
      String? text}) async {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.transparent
      ..textColor = Colors.black
      ..contentPadding = EdgeInsets.zero
      ..radius = 10
      ..displayDuration = Duration(seconds: duration ?? 3);
    _counter += 1;
    if (EasyLoading.isShow) return;
    return EasyLoading.show(
      status: status,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static Future showLoading2(
      {String? status,
      EasyLoadingMaskType? maskType,
      bool? dismissOnTap,
      int? duration,
      String? text}) async {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white.opacity80
      ..indicatorColor = Colors.black.opacity60
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..maskColor = Colors.transparent
      ..textColor = LWColors.theme
      ..contentPadding = EdgeInsets.zero
      ..textPadding = const EdgeInsets.symmetric(horizontal: 40)
      ..radius = 12
      ..indicatorSize = 88
      ..userInteractions = false
      ..displayDuration = Duration(seconds: duration ?? 3);
    // 使用引用计数，使show与hide成对出现
    _counter += 1;
    if (EasyLoading.isShow) return;
    return EasyLoading.show(
      status: status,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static Future dismiss({bool animation = true}) async {
    _counter -= 1;
    return EasyLoading.dismiss(animation: animation);
    // todo:
    // if (_counter <= 0) {
    //   _counter = 0;
    //   EasyLoading.dismiss();
    // }
  }
}
