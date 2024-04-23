import 'dart:math';

import 'package:atv/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../basic/button/lw_button.dart';
import '../../basic/colors/lw_colors.dart';
import '../../basic/lw_item.dart';
import '../../lw_widget.dart';
import 'lw_sheet.dart';
import 'lw_sheet_title.dart';

enum SheetOptionType {
  normal,
  single,
  multiple,
}

class LWSheetOption extends StatefulWidget {
  /// option 单选(没有选中状态)
  static Future normal(
    BuildContext context, {
    String? title,
    List<LWItem>? options,
    bool? isDismissible,
    Function(LWItem option)? onConfirm,
    Function()? onClose,
  }) {
    return LWSheet.show(
      context,
      child: LWSheetOption(
        context: context,
        title: title,
        type: SheetOptionType.normal,
        options: options,
        onConfirm: (items) {
          if (items.isNotEmpty) {
            onConfirm?.call(items.first);
          }
        },
        onClose: onClose,
      ),
      isDismissible: isDismissible,
    );
  }

  /// option 单选
  static Future single(
    BuildContext context, {
    String? title,
    List<LWItem>? options,
    bool? isDismissible,
    Function(LWItem option)? onConfirm,
    Function()? onClose,
  }) {
    return LWSheet.show(
      context,
      child: LWSheetOption(
        context: context,
        title: title,
        type: SheetOptionType.single,
        options: options,
        onConfirm: (items) {
          if (items.isNotEmpty) {
            onConfirm?.call(items.first);
          }
        },
        onClose: onClose,
      ),
      isDismissible: isDismissible,
    );
  }

  /// option 多选
  static Future multiple(
    BuildContext context, {
    String? title,
    List<LWItem>? options,
    bool? isDismissible,
    Function(List<LWItem> items)? onConfirm,
    Function()? onClose,
  }) {
    return LWSheet.show(
      context,
      child: LWSheetOption(
        context: context,
        title: title,
        type: SheetOptionType.multiple,
        options: options,
        onConfirm: onConfirm,
        onClose: onClose,
      ),
      isDismissible: isDismissible,
    );
  }

  //// sheet显示的上下文
  final BuildContext context;

  /// 标题
  final String? title;

  late SheetOptionType type;

  List<LWItem>? options;

  Widget? child;

  Function(List<LWItem> options)? onConfirm;
  Function()? onClose;

  LWSheetOption({
    Key? key,
    required this.context,
    required this.type,
    this.title = "",
    this.options,
    this.child,
    this.onConfirm,
    this.onClose,
  }) : super(key: key);

  @override
  State<LWSheetOption> createState() => _LWSheetOptionState();
}

class _LWSheetOptionState extends State<LWSheetOption> {
  late final LWSheetTitle titleWidget;
  List<LWItem> options = [];

  double itemHeight = 46;

  @override
  void initState() {
    super.initState();
    initData();
    titleWidget = _buildTitleWidget();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight(),
      child: Column(
        children: [
          Visibility(
            child: titleWidget,
            visible: willShowTitle(),
          ),
          Expanded(
            child: _buildContentWidget(),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  LWSheetTitle _buildTitleWidget() {
    return LWSheetTitle(
      key: ValueKey(widget.title),
      title: widget.title,
      titleAlign: TextAlign.center,
      showDivider: true,
      onClose: () {
        if (widget.onClose != null) {
          widget.onClose!();
        }
      },
      items: const [
        LWSheetTitleItem.title,
        LWSheetTitleItem.close,
      ],
    );
  }

  Widget _buildContentWidget() {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: ListView.separated(
        itemBuilder: (context, index) {
          var item = options[index];
          return GestureDetector(
            child: _buildListItem(item, index),
            onTap: () {
              if (item.enable != true) {
                return;
              }
              if (widget.type == SheetOptionType.normal) {
                Navigator.of(context).pop();
                if (widget.onConfirm != null) {
                  widget.onConfirm!([item]);
                }
              } else if (widget.type == SheetOptionType.single) {
                setState(() {
                  resetData();
                  item.select = true;
                  try {
                    widget.options
                        ?.firstWhere((element) => element.code == item.code)
                        .select = true;
                  } catch (e) {
                    // not found
                  }
                });
                Navigator.of(context).pop();
                if (widget.onConfirm != null) {
                  widget.onConfirm!([item]);
                }
              } else if (widget.type == SheetOptionType.multiple) {
                setState(() {
                  item.select = !item.select;
                });
              }
            },
            behavior: HitTestBehavior.translucent,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(color: LWColors.gray6, height: 1);
        },
        itemCount: options.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _buildListItem(LWItem? item, int index) {
    bool selected =
        widget.type != SheetOptionType.normal && item?.select == true;
    bool enabled = item?.enable == true;
    return SizedBox(
      height: itemHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selected
              ? LWWidget.assetSvg("ic_item_selected.svg",
                  height: 12.w, width: 12.w, color: LWColors.theme)
              : SizedBox(height: 12.w, width: 12.w),
          SizedBox(width: 5.w),
          Text(
            item?.displayName ?? item?.name ?? '',
            style: TextStyle(
              color: selected
                  ? LWColors.theme
                  : (enabled ? LWColors.gray1 : LWColors.gray5),
              fontSize: 14.sp,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(width: 17.w),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    if (willShowBottomButton()) {
      return Container(
        height: 62.w,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
        child: Row(
          children: [
            Expanded(
              child: LWButton.primary(
                text: LocaleKeys.confirm.tr(),
                onPressed: () {
                  try {
                    var selectedCodes = selectedOptions().map((e) => e.code);
                    widget.options?.forEach((element) {
                      element.select = selectedCodes.contains(element.code);
                    });
                  } catch (e) {
                    // not found
                  }
                  Navigator.pop(context);
                  if (widget.onConfirm != null) {
                    widget.onConfirm!(selectedOptions());
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      height: 54.w,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(color: LWColors.gray6, height: 10.w),
          Expanded(
            child: LWButton.custom(
              minHeight: 44.w,
              backgroundColor: Colors.white,
              text: LocaleKeys.cancel.tr(),
              textSize: 14.sp,
              textColor: LWColors.gray4,
              onPressed: () {
                Navigator.pop(context);
                if (widget.onClose != null) {
                  widget.onClose!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool willShowTitle() {
    return widget.type == SheetOptionType.multiple ||
        (widget.type == SheetOptionType.single &&
            widget.title?.isNotEmpty == true);
  }

  bool willShowBottomButton() {
    return widget.type == SheetOptionType.multiple;
  }

  double boxHeight() {
    double height = 0;
    if (willShowTitle()) {
      height += titleWidget.height;
      height += 62.w;
    } else {
      height += 54.w;
    }
    height += options.length * itemHeight + (max(options.length, 1) - 1 * 1);
    return height;
  }

  List<LWItem> selectedOptions() {
    return options.where((element) => element.select == true).toList();
  }

  initData() {
    options = (widget.options ?? []).map((e) => e.copy()).toList();
  }

  resetData() {
    for (var item in options) {
      item.select = false;
    }
    // 注意：这里的 widget.items 不要改成 _items
    for (var item in widget.options ?? []) {
      item.select = false;
    }
  }
}
