
import '../../lw_widget.dart';
import '../colors/lw_colors.dart';
import '../lw_click.dart';
import '../../utils/size_util.dart';
import '../font/lw_font_weight.dart';
import '../lw_item.dart';
import '../../utils/over_scroll_none_behavior.dart';
import '../../utils/size_util.dart';
import 'package:flutter/material.dart';

/// 选项组，可以独立使用，也可以与LWForm组合
abstract class _LWOptionAbstract extends StatefulWidget {
  const _LWOptionAbstract({
    Key? key,
    required this.data,
    required this.model,
    this.onSelectedSingle,
    this.onSelectedMultiple,
    this.softWrap = false,
    this.gridView = false,
    this.scrollable = true,
    this.equalScale = false,
    this.minWidth,
    this.minHeight,
    this.fontSize,
    this.unselectBorderStyle,
    this.selectedBorderStyle,
    this.unselectTextStyle,
    this.selectedTextStyle,
  }) : super(key: key);

  final List<LWItem> data;
  final String model;
  final Function(LWItem selected)? onSelectedSingle;
  final Function(List<LWItem> selected)? onSelectedMultiple;
  final bool softWrap; // 是否支持换行
  final bool gridView;
  final bool scrollable;

  /// 等宽排列，仅在scrollable=false时生效
  final bool equalScale;
  final double? minWidth;
  final double? minHeight;
  final double? fontSize;
  final BoxDecoration? unselectBorderStyle;
  final BoxDecoration? selectedBorderStyle;
  final TextStyle? unselectTextStyle;
  final TextStyle? selectedTextStyle;
}

class LWOption extends _LWOptionAbstract {
  LWOption._({Key? key}) : super(key: key, data: [], model: 'single', softWrap: false);

  const LWOption.single({
    Key? key,
    required List<LWItem> data,
    required Function(LWItem) onSelected,
    bool softWrap = false,
    bool gridView = false,
    bool scrollable = true,
    bool equalScale = false,
    double? minWidth,
    double? minHeight,
    double? fontSize,
    BoxDecoration? unselectBorderStyle,
    BoxDecoration? selectedBorderStyle,
    TextStyle? unselectTextStyle,
    TextStyle? selectedTextStyle,
  }) : super(
            key: key,
            data: data,
            onSelectedSingle: onSelected,
            model: 'single',
            softWrap: softWrap,
            gridView: gridView,
            scrollable: scrollable,
            equalScale: equalScale,
            minWidth: minWidth,
            minHeight: minHeight,
            fontSize: fontSize,
            unselectBorderStyle: unselectBorderStyle,
            selectedBorderStyle: selectedBorderStyle,
            unselectTextStyle: unselectTextStyle,
            selectedTextStyle: selectedTextStyle);

  const LWOption.multiple({
    Key? key,
    required List<LWItem> data,
    required Function(List<LWItem>) onSelected,
    bool softWrap = false,
    bool gridView = false,
    bool scrollable = true,
    bool equalScale = false,
    double? minWidth,
    double? minHeight,
    double? fontSize,
    BoxDecoration? unselectBorderStyle,
    BoxDecoration? selectedBorderStyle,
    TextStyle? unselectTextStyle,
    TextStyle? selectedTextStyle,
  }) : super(
            key: key,
            data: data,
            onSelectedMultiple: onSelected,
            model: 'multiple',
            softWrap: softWrap,
            gridView: gridView,
            scrollable: scrollable,
            equalScale: equalScale,
            minWidth: minWidth,
            minHeight: minHeight,
            fontSize: fontSize,
            unselectBorderStyle: unselectBorderStyle,
            selectedBorderStyle: selectedBorderStyle,
            unselectTextStyle: unselectTextStyle,
            selectedTextStyle: selectedTextStyle);

  @override
  State<StatefulWidget> createState() => _LWOptionState();
}

class _LWOptionState extends State<LWOption> {
  List<LWItem> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.data.map((e) => e.copy()).toList();
  }

  @override
  void didUpdateWidget(covariant LWOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    _items = widget.data.map((e) => e.copy()).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemWidgets = _items.map((e) => buildItem(e)).toList();
    if (widget.gridView) {
      return GridView.builder(
        itemCount: itemWidgets.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 14, mainAxisExtent: 32),
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => itemWidgets[index],
      );
    } else if (widget.softWrap) {
      return Wrap(spacing: 12.dp, runSpacing: 12.dp, children: itemWidgets);
    } else {
      List<Widget> newItemWidgets = [];
      for (var index = itemWidgets.length - 1; index >= 0; index--) {
        var isFirst = index == 0;
        if (!widget.scrollable && widget.equalScale) {
          newItemWidgets.insert(0, Expanded(child: itemWidgets[index]));
        } else {
          newItemWidgets.insert(0, itemWidgets[index]);
        }
        if (!isFirst) {
          newItemWidgets.insert(0, SizedBox(width: 12.dp));
        }
      }
      if (!widget.scrollable) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.dp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: newItemWidgets,
          ),
        );
      } else {
        return ScrollConfiguration(
          behavior: OverScrollNoneBehavior(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.dp),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: newItemWidgets,
            ),
          ),
        );
      }
    }
  }

  Widget buildItem(LWItem item) {
    var paddingLR = widget.minWidth != null || (!widget.scrollable && widget.equalScale) ? 0.dp : 12.dp;
    var paddingTB = widget.minHeight != null ? 0.dp : 6.dp;
    return StatefulBuilder(builder: (context, state) {
      BoxDecoration borderStyle = BoxDecoration(
        color: item.select ? LWColors.theme.opacity6 : LWColors.gray8,
        borderRadius: BorderRadius.circular(6.dp),
      );
      if (item.select && widget.selectedBorderStyle != null) {
        borderStyle = widget.selectedBorderStyle!;
      }
      if (!item.select && widget.unselectBorderStyle != null) {
        borderStyle = widget.unselectBorderStyle!;
      }

      TextStyle textStyle = TextStyle(
        fontSize: widget.fontSize ?? 13.sp,
        fontWeight: item.select ? LWFontWeight.bold : LWFontWeight.normal,
        color: item.select ? LWColors.theme : LWColors.gray1,
      );
      if (item.select && widget.selectedTextStyle != null) {
        textStyle = widget.selectedTextStyle!;
      }
      if (!item.select && widget.unselectTextStyle != null) {
        textStyle = widget.unselectTextStyle!;
      }

      return LWClick.onClick(
        onTap: () {
          if (widget.model != 'single') {
            item.select = !item.select;
            widget.onSelectedMultiple?.call(_items.where((element) => element.select).toList());
            state(() {});
          } else {
            _items.forEach((e) => e.select = e == item);
            setState(() {});
            widget.onSelectedSingle?.call(item);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: paddingTB, horizontal: paddingLR),
          decoration: borderStyle,
          constraints: BoxConstraints(minWidth: widget.minWidth ?? 0.dp, minHeight: widget.minHeight ?? 0.dp),
          alignment: Alignment.center,
          child: Text(
            item.displayName?.isNotEmpty == true ? item.displayName! : item.name,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      );
    });
  }
}
