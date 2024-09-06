import '../../lw_widget.dart';
import '../colors/lw_colors.dart';
import '../lw_click.dart';
import '../../utils/size_util.dart';
import '../lw_item.dart';
import '../../utils/over_scroll_none_behavior.dart';
import 'package:flutter/widgets.dart';

/// 单选/多选选择组
abstract class _LWRadioGroupAbstract extends StatefulWidget {
  const _LWRadioGroupAbstract({
    Key? key,
    required this.data,
    required this.model,
    this.onSelectedSingle,
    this.onSelectedMultiple,
    this.softWrap = false,
    this.enabled = true,
    this.fontSize,
  }) : super(key: key);

  final List<LWItem> data;
  final String model;
  final Function(LWItem selected)? onSelectedSingle;
  final Function(List<LWItem> selected)? onSelectedMultiple;
  final bool softWrap; // 是否支持换行
  final bool enabled;
  final double? fontSize;
}

class LWRadioGroup extends _LWRadioGroupAbstract {
  LWRadioGroup._({Key? key}) : super(key: key, data: [], model: 'single', softWrap: false);

  const LWRadioGroup.single({
    Key? key,
    required List<LWItem> data,
    required Function(LWItem) onSelected,
    bool softWrap = false,
    bool enabled = true,
    double? fontSize,
  }) : super(
            key: key,
            data: data,
            model: 'single',
            onSelectedSingle: onSelected,
            softWrap: softWrap,
            enabled: enabled,
            fontSize: fontSize);

  const LWRadioGroup.multiple({
    Key? key,
    required List<LWItem> data,
    required Function(List<LWItem>) onSelected,
    bool softWrap = false,
    bool enabled = true,
    double? fontSize,
  }) : super(
            key: key,
            data: data,
            model: 'multiple',
            onSelectedMultiple: onSelected,
            softWrap: softWrap,
            enabled: enabled,
            fontSize: fontSize);

  @override
  State<StatefulWidget> createState() => _LWRadioGroupState();
}

class _LWRadioGroupState extends State<_LWRadioGroupAbstract> {
  List<LWItem> _data = [];

  @override
  void initState() {
    super.initState();
    _data = widget.data.map((e) => e.copy()).toList();
  }

  @override
  void didUpdateWidget(covariant LWRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    _data = widget.data.map((e) => e.copy()).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemWidgets = _data.map((e) => _buildItem(e)).toList();
    if (widget.softWrap) {
      return Wrap(
        direction: Axis.horizontal,
        spacing: 12.dp,
        runSpacing: 12.dp,
        children: itemWidgets,
      );
    } else {
      List<Widget> newItemWidgets = [];
      for (var index = itemWidgets.length - 1; index >= 0; index--) {
        var isFirst = index == 0;
        newItemWidgets.insert(0, itemWidgets[index]);
        if (!isFirst) {
          newItemWidgets.insert(0, SizedBox(width: 24.dp));
        }
      }

      return ScrollConfiguration(
        behavior: OverScrollNoneBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: newItemWidgets,
          ),
        ),
      );
    }
  }

  Widget _buildItem(LWItem item) {
    return StatefulBuilder(builder: (context, state) {
      var iconName = '';
      if (widget.enabled) {
        iconName = 'ic_radio_unselect.svg';
        if (item.select) {
          iconName = widget.model == 'single'
              ? 'ic_radio_selected_single_stroked.svg'
              : 'ic_radio_selected_multiple_stroked.svg';
        }
      } else {
        iconName = 'ic_radio_unselect_disabled.svg';
        if (item.select) {
          iconName = widget.model == 'single'
              ? 'ic_radio_selected_single_disabled.svg'
              : 'ic_radio_selected_multiple_disabled.svg';
        }
      }
      return LWClick.onClick(
        onTap: () {
          if (widget.model != 'single') {
            item.select = !item.select;
            widget.onSelectedMultiple?.call(_data.where((element) => element.select).toList());
            state(() {});
          } else {
            _data.forEach((e) => e.select = e == item);
            setState(() {});
            widget.onSelectedSingle?.call(item);
          }
        },
        child: UnconstrainedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.enabled && item.select
                  ? LWWidget.assetSvg(iconName, color: LWColors.theme)
                  : LWWidget.assetSvg(iconName),
              SizedBox(width: 10.dp),
              Text(
                item.displayName?.isNotEmpty == true ? item.displayName! : item.name,
                style: TextStyle(
                  fontSize: widget.fontSize ?? 14.sp,
                  color: widget.enabled ? LWColors.gray1 : LWColors.gray5,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
