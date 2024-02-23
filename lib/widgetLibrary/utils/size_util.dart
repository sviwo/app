import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeUtil {
  SizeUtil._internal();

  static late Size _uiSize;
  static double? _scaleFactor;

  static init(BuildContext context, double width, double height, {double? scaleFactor}) {
    _uiSize = Size(width, height);
    _scaleFactor = scaleFactor;
    ScreenUtil.init(
      context,
      designSize: Size(width, height),
      minTextAdapt: true,
    );
  }

  /// 组件大小缩放（device independent pixels - 设备独立像素）
  static dp(double value) {
    var scale = _scaleFactor ?? _scaleWidth;
    return (value * scale);
  }

  /// 文本大小缩放（scale-independent pixels - 缩放独立像素）
  static sp(double value) {
    var scale = _scaleFactor ?? _scaleWidth; // _scaleText
    return (value * scale);
  }

  static double get screenWidth => ScreenUtil().screenWidth;

  static double get screenHeight => ScreenUtil().screenHeight;

  /// 宽度比例
  static double get _scaleWidth => _screenMinWidth / _uiSize.width;

  /// 高度比例
  static double get _scaleHeight => _screenMaxHeight / _uiSize.height;

  /// 字体的大小比例
  static double get _scaleText => min(_scaleWidth, _scaleHeight);

  /// 宽高的较小者
  static double get _screenMinWidth => min(screenWidth, screenHeight);

  /// 宽高的较大者
  static double get _screenMaxHeight => max(screenWidth, screenHeight);
}

extension SizeUtilExtension on num {
  double get dp => SizeUtil.dp(toDouble());

  double get sp => SizeUtil.sp(toDouble());
}
