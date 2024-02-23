import 'dart:async';

import 'basic/button/lw_button.dart';
import 'utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LWWidget {
  LWWidget._internal();

  static const MethodChannel channel = MethodChannel('flutter_book_study');
  static Color themeColor = const Color(0xFFE60044);
  static bool isStyleCircle= false;
  static String packageName = 'flutter_book_study';

  static String eventImageChooser = 'event/imageChooser';
  static String eventPlatformVersion = 'event/platformVersion';

  /// 初始化
  ///   - designWidth 设计稿宽度
  ///   - designHeight 设计稿高度
  ///   - themeColor 主题色
  static init(BuildContext context,
      {double designWidth = 375, double designHeight = 812, double? designScaleFactor, Color? themeColor, bool isStyleCircle = false}) {
    SizeUtil.init(context, designWidth, designHeight, scaleFactor: designScaleFactor);
    LWWidget.themeColor = themeColor ?? LWWidget.themeColor;
    LWWidget.isStyleCircle = isStyleCircle;
  }

  static Future<String?> get platformVersion async {
    try {
      return await channel.invokeMethod(eventPlatformVersion);
    } catch (e) {
      return null;
    }
  }

  ///======================= 图片加载 =======================
  static String assetImgPath(String imageName) => 'packages/$packageName/assets/images/$imageName';

  static String assetSvgPath(String svgName) => 'packages/$packageName/assets/images/svg/$svgName';

  static Widget assetImg(
    String imagePath, {
    double? height,
    double? width,
    double? scale,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(assetImgPath(imagePath), width: width, height: height, fit: fit, scale: scale, color: color);
  }

  static Widget assetSvg(
    String svgName, {
    double? height,
    double? width,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(assetSvgPath(svgName), width: width, height: height, fit: fit, color: color);
  }

  static Size boundingTextSize(
    String text,
    TextStyle style, {
    int? maxLines,
    double maxWidth = double.infinity,
  }) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
    )..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
