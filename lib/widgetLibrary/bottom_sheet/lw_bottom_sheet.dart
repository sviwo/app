import 'package:flutter/material.dart';

// 底部弹窗容器，无内容
class LWBottomSheet {
  static double maxHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.8;

  static double get minHeight => 100;

  static Future<T?> show<T>(
    BuildContext context, {
    Widget? child,

    /// 点击背景是否关闭，默认true
    bool? isDismissible,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible = true,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: minHeight,
            maxHeight: maxHeight(context),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: Colors.white,
          ),
          child: IntrinsicHeight(
            child: child ?? Container(),
          ),
        );
      },
    );
  }
}
