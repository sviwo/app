
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lw_sheet_title.dart';

// 底部弹窗容器，无内容
class LWSheet {
  static Future<T?> showWithTitle<T>(
    String title,
    BuildContext context, {
    Widget? child,
    double? minHeight,
    double? maxHeight,
    bool? isDismissible = true,
  }) {
    return LWSheet.show(
      context,
      minHeight: minHeight,
      maxHeight: maxHeight,
      isDismissible: isDismissible,
      child: Column(
        children: [
          LWSheetTitle(
            key: ValueKey(title),
            title: title,
            titleAlign: TextAlign.center,
            showDivider: true,
            onClose: () {},
            items: const [
              LWSheetTitleItem.title,
              LWSheetTitleItem.close,
            ],
          ),
          child ?? Container(height: 100.w),
        ],
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    Widget? child,
    double? minHeight,
    double? maxHeight,
    bool? isDismissible = true,
  }) {
    // isDismissible: 点击背景是否关闭，默认true
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible = true,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: minHeight ?? 100.w,
            maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
            color: Colors.white,
          ),
          child: IntrinsicHeight(
            child: SafeArea(child: child ?? Container()),
          ),
        );
      },
    );
  }
}
