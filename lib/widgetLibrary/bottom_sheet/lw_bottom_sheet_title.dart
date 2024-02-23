
import 'package:flutter/material.dart';

import '../basic/button/lw_button.dart';
import '../basic/colors/lw_colors.dart';
import '../lw_widget.dart';

enum LWBottomSheetTitleItem { title, cancel, confirm, close }

/// 组件内部使用
class LWBottomSheetTitle extends StatelessWidget {
  const LWBottomSheetTitle({
    Key? key,
    this.title,
    this.titleAlign,
    this.onClose,
    this.onCancel,
    this.onConfirm,
    this.items,
  }) : super(key: key);

  double get height => items?.isNotEmpty == true ? 62 : 0;

  /// 显示标题栏时，点击关闭回调
  final Function()? onClose;

  /// 显示标题栏时，点击取消回调
  final Function()? onCancel;

  /// 显示标题栏时，点击确定回调
  final Function()? onConfirm;

  /// title 标题
  final String? title;
  final TextAlign? titleAlign;
  final List<LWBottomSheetTitleItem>? items;

  List<Widget> _getChildren(BuildContext context) {
    List<Widget> children = [];
    items?.forEach(
      (e) {
        if (e == LWBottomSheetTitleItem.title) {
          children.add(
            Expanded(
              child: Text(
                title ?? "",
                textAlign: titleAlign,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: LWColors.gray1,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        } else if (e == LWBottomSheetTitleItem.confirm) {
          children.add(
            LWButton.text(
              text: "确定",
              textSize: 14,
              textColor: LWColors.gray1,
              onPressed: () {
                Navigator.pop(context);
                if (onConfirm != null) {
                  onConfirm!();
                }
              },
            ),
          );
        } else if (e == LWBottomSheetTitleItem.cancel) {
          children.add(
            LWButton.text(
              text: "取消",
              textSize: 14,
              textColor: LWColors.gray4,
              onPressed: () {
                Navigator.pop(context);
                if (onCancel != null) {
                  onCancel!();
                }
              },
            ),
          );
        } else if (e == LWBottomSheetTitleItem.close) {
          children.add(
            LWButton.custom(
              onPressed: () {
                Navigator.pop(context);
                if (onClose != null) {
                  onClose!();
                }
              },
              child: LWWidget.assetSvg('ic_dialog_close.svg', width: 20, height: 20),
            ),
          );
        }
        children.add(const SizedBox(width: 5));
      },
    );
    children.removeLast();
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getChildren(context),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: LWColors.gray6,
          )
        ],
      ),
    );
  }
}
