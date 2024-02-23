import 'dart:math';

import 'package:flutter/material.dart';

import '../../basic/colors/lw_colors.dart';
import '../../lw_widget.dart';
import 'flutter_svg_provider.dart';

class LWImageLoader {
  LWImageLoader._();

  /// 占位图名称
  static const String _placeholderSvgName = 'ic_image_loader_placeholder.svg';

  /// 失败图名称
  static const String _failureSvgName = 'ic_image_loader_fail.svg';

  /// 加载的占位图
  /// params:
  ///   - width: 宽度
  ///   - height: 高度
  static Widget placeholder({double width = 100, double height = 100}) {
    return LWWidget.assetSvg(
      _placeholderSvgName,
      width: width,
      height: height,
    );
  }

  /// 加载错误的图
  /// params:
  ///   - width: 宽度
  ///   - height: 高度
  static Widget failure({double width = 100, double height = 100}) {
    return LWWidget.assetSvg(
      _failureSvgName,
      width: width,
      height: height,
    );
  }

  /// 从网络加载图片
  /// params:
  ///   - imageUrl: 图片地址，必选参数
  ///   - fit: BoxFit类型，默认为BoxFit.cover
  ///   - width: 宽度
  ///   - height: 高度
  static Widget network({
    required String imageUrl,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    return LayoutBuilder(
      builder: (p0, p1) {
        var maxWidth = p1.maxWidth;
        var maxHeight = p1.maxHeight;
        if (width != null && width > 0) {
          maxWidth = min(maxWidth, width);
        }
        if (height != null && height > 0) {
          maxHeight = min(maxHeight, height);
        }
        var limitLength = min(maxWidth, maxHeight);
        var scale = 0.4;
        var resultWH = limitLength * scale;

        Uri? url = Uri.tryParse(imageUrl);
        if (url == null || url.host.isEmpty) {
          return Container(
            color: LWColors.gray7,
            width: width,
            height: height,
            alignment: Alignment.center,
            child: failure(width: resultWH, height: resultWH),
          );
        }

        return Container(
            color: LWColors.gray7,
            width: width,
            height: height,
            alignment: Alignment.center,
            child: FadeInImage(
              image: NetworkImage(imageUrl),
              placeholder: SvgProvider(
                LWWidget.assetSvgPath(_placeholderSvgName),
                size: Size(resultWH.toDouble(), resultWH.toDouble()),
              ),
              placeholderFit: BoxFit.none,
              fit: fit,
              width: width,
              height: height,
              placeholderErrorBuilder: (context, error, stackTrace) {
                return placeholder(width: resultWH, height: resultWH);
              },
              imageErrorBuilder: (context, error, stackTrace) {
                return failure(width: resultWH, height: resultWH);
              },
            ));
      },
    );
  }
}
