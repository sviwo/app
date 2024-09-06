import 'package:flutter/material.dart';
import '../basic/colors/lw_colors.dart';
import '../basic/lw_click.dart';
import '../lw_widget.dart';
import 'lw_form.dart';
import '../utils/size_util.dart';

/// 表单-选择框
///   - 布局vertical，value最大支持2行
///   - 布局horizontal，value区最大支持1行
class LWFormSelect extends LWForm {
  LWFormSelect._({required this.onTap}) : super(title: '');

  LWFormSelect.vertical({
    ///必传：左上角标题
    required String title,
    ///不必传：文字字号
    double? titleSize,
    double? valueSize,
    ///不必传：默认值回显
    this.value,
    ///不必传：请选择的提示语 默认：请选择
    this.hint,
    ///不必传：最右部件  替换箭头（地图选择/带单位 等）
    this.suffixWidget,
    ///不必传：最左部件  暂未考虑到使用场景
    this.prefixWidget,
    ///必传：文本域点击事件
    required this.onTap,
    ///不必传：是否必选 *
    bool? required,
    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,
    ///不必传：有回调表示显示图标
    Function()? onTapTips,
    ///不必传：是否动态分割title与value的空间比例
    bool dynamicSeparate = true,
    ///不必传：是否可点击  默认true
    this.enable = true,
    this.showNext = true,
  }) : super(
      title: title,
      titleSize: titleSize,
      valueSize: valueSize,
      required: required,
      onTapTips: onTapTips,
      padding: padding,
      direction: Axis.vertical,
      dynamicSeparate: dynamicSeparate);

  LWFormSelect.horizontal({
    ///必传：左上角标题
    required String title,
    ///不必传：文字字号
    double? titleSize,
    double? valueSize,
    ///不必传：默认值回显
    this.value,
    ///不必传：请选择的提示语 默认：请选择
    this.hint,
    ///不必传：最右部件  替换箭头（地图选择/带单位 等）
    this.suffixWidget,
    ///不必传：最左部件  暂未考虑到使用场景
    this.prefixWidget,
    ///必传：文本域点击事件
    required this.onTap,
    ///不必传：是否必选 *
    bool? required,
    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,
    ///不必传：有回调表示显示图标
    Function()? onTapTips,
    ///不必传：是否动态分割title与value的空间比例
    bool dynamicSeparate = true,
    ///不必传：是否可点击  默认true
    this.enable = true,
    this.showNext = true,
  }) : super(
      title: title,
      titleSize: titleSize,
      valueSize: valueSize,
      required: required,
      onTapTips: onTapTips,
      padding: padding,
      direction: Axis.horizontal,
      dynamicSeparate: dynamicSeparate);

  String? value;
  String? hint;
  Function() onTap;

  //是否可编辑
  bool enable = true;
  bool showNext = true;

  //最右部件  替换箭头（地图选择/带单位 等）
  Widget? suffixWidget;

  //最左部件  暂未考虑到使用场景
  Widget? prefixWidget;

  @override
  State<StatefulWidget> createState() {
    return _LWFormSelectState();
  }
}

class _LWFormSelectState extends LWFormState<LWFormSelect> {
  @override
  Widget? buildPrefix() {
    return widget.prefixWidget;
  }

  @override
  Widget? buildSuffix() {
    return widget.suffixWidget ??
        (!widget.showNext ? null : LWClick.onClick(
          onTap: widget.onTap,
          child: Row(
            children: [
              SizedBox(width: 12.dp),
              LWWidget.assetSvg('ic_form_next.svg', width: 12.dp, height: 12.dp),
            ],
          ),
        ));
  }

  @override
  Widget buildChildRight() {
    return LWClick.onClick(
      onTap: widget.enable ? widget.onTap : null,
      child: widget.direction == Axis.vertical
          ? Container(
        width: double.maxFinite,
        child: Text(
          '',
          style: TextStyle(fontSize: widget.valueSize ?? 14.sp, color: LWColors.gray2, height: 1.43),
        ),
      )
          : Container(
        width: double.maxFinite,
        alignment: Alignment.centerRight,
        child: _buildValue(),
      ),
    );
  }

  @override
  Widget? buildChildBottom() {
    return widget.direction == Axis.vertical
        ? LWClick.onClick(
      onTap: widget.enable ? widget.onTap : null,
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.dp),
            _buildValue(),
          ],
        ),
      ),
    )
        : null;
  }

  /// child内容区
  Widget _buildValue() {
    var hasValue = widget.value?.isNotEmpty == true;
    return Text(
      widget.enable ? (hasValue ? (widget.value ?? '') : (widget.hint ?? '请选择')) : (widget.value ?? ""),
      textAlign: widget.direction == Axis.vertical ? TextAlign.start : TextAlign.end,
      maxLines: widget.direction == Axis.vertical ? 1 : 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: widget.valueSize ?? 14.sp,
        color: hasValue ? LWColors.gray1 : LWColors.gray4,
        height: 1.43,
      ),
    );
  }
}
