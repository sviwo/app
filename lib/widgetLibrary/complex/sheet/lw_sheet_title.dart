import 'package:atv/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../basic/button/lw_button.dart';
import '../../basic/colors/lw_colors.dart';
import '../../lw_widget.dart';

enum LWSheetTitleItem {
  title,
  cancel,
  confirm,
  close,
}

/// 组件内部使用
class LWSheetTitle extends StatelessWidget {
  const LWSheetTitle({
    Key? key,
    this.title,
    this.titleAlign,
    this.onClose,
    this.onCancel,
    this.onConfirm,
    this.items,
    this.showDivider = true,
  }) : super(key: key);

  double get height => items?.isNotEmpty == true ? 48.w : 0;

  /// 显示标题栏时，点击关闭回调
  final Function()? onClose;

  /// 显示标题栏时，点击取消回调
  final Function()? onCancel;

  /// 显示标题栏时，点击确定回调
  final Function()? onConfirm;

  /// title 标题
  final String? title;
  final TextAlign? titleAlign;
  final List<LWSheetTitleItem>? items;

  final bool? showDivider;

  List<Widget> _getChildren(BuildContext context) {
    List<Widget> children = [];

    if (items?.contains(LWSheetTitleItem.cancel) == true) {
      children.add(
        Container(
          width: 44.w,
          alignment: Alignment.centerLeft,
          child: LWButton.custom(
            onPressed: () {
              Navigator.pop(context);
              if (onCancel != null) {
                onCancel!();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.cancel.tr(),
                  style: TextStyle(fontSize: 14.sp, color: LWColors.gray4),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      children.add(Container(width: 44.w));
    }

    if (items?.contains(LWSheetTitleItem.title) == true) {
      children.add(
        Expanded(
          child: Text(
            title ?? "",
            textAlign: titleAlign,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: LWColors.gray1,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    if (items?.contains(LWSheetTitleItem.confirm) == true) {
      children.add(
        SizedBox(
          width: 44.w,
          child: LWButton.custom(
            onPressed: () {
              Navigator.pop(context);
              if (onConfirm != null) {
                onConfirm!();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.confirm.tr(),
                  style: TextStyle(fontSize: 14.sp, color: LWColors.gray1),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (items?.contains(LWSheetTitleItem.close) == true) {
      children.add(
        SizedBox(
          width: 44.w,
          child: LWButton.custom(
            onPressed: () {
              Navigator.pop(context);
              if (onClose != null) {
                onClose!();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LWWidget.assetSvg('ic_dialog_close.svg', width: 20.w, height: 20.w),
              ],
            ),
          ),
        ),
      );
    } else {
      children.add(Container(width: 44.w));
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      height: height,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _getChildren(context),
            ),
          ),
          Visibility(
            child: const Divider(
              height: 1,
              color: LWColors.gray6,
            ),
            visible: showDivider == true,
          ),
        ],
      ),
    );
  }
}
