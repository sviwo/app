
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic/lw_click.dart';
import 'lw_form.dart';
import '../utils/size_util.dart';

import '../basic/colors/lw_colors.dart';

/// 表单-输入框
///   - 布局vertical，value最大支持2行
///   - 布局horizontal，value区最大支持1行
class LWFormInput extends LWForm {
  LWFormInput._() : super(title: '');

  LWFormInput.vertical({
    ///必传：左上角标题
    required String title,

    ///不必传：文字字号
    double? titleSize,
    double? valueSize,

    ///不必传：默认值回显
    this.value,

    ///不必传：请输入的提示语 默认：请输入
    this.hint,

    ///不必传：键盘类型输入的类型
    this.keyboardType,

    ///不必传：设置允许的输入格式
    this.inputFormatters,

    ///不必传：控制正在编辑的文本
    this.controller,

    ///不必传：是否具有键盘焦点
    this.focusNode,

    ///不必传：文本变化回调方法
    this.onChanged,

    ///不必传：最右部件  替换箭头（地图选择/带单位 等）
    this.prefixWidget,

    ///不必传：最左部件  暂未考虑到使用场景
    this.suffixWidget,

    ///不必传：输入框是否可编辑
    this.enabled = true,

    ///不必传：是否必选 *
    bool? required,

    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,

    ///不必传：有回调表示显示图标
    Function()? onTapTips,

    ///不必传：是否动态分割title与value的空间比例
    bool dynamicSeparate = true,
  }) : super(
          title: title,
          titleSize: titleSize,
          valueSize: valueSize,
          required: required,
          onTapTips: onTapTips,
          padding: padding,
          direction: Axis.vertical,
          dynamicSeparate: dynamicSeparate,
        );

  LWFormInput.horizontal({
    ///必传：左上角标题
    required String title,

    ///不必传：文字字号
    double? titleSize,
    double? valueSize,

    ///不必传：默认值回显
    this.value,

    ///不必传：请输入的提示语 默认：请输入
    this.hint,

    ///不必传：键盘类型输入的类型
    this.keyboardType,

    ///不必传：设置允许的输入格式
    this.inputFormatters,

    ///不必传：控制正在编辑的文本
    this.controller,

    ///不必传：是否具有键盘焦点
    this.focusNode,

    ///不必传：文本变化回调方法
    this.onChanged,

    ///不必传：最右部件  替换箭头（地图选择/带单位 等）
    this.prefixWidget,

    ///不必传：最左部件  暂未考虑到使用场景
    this.suffixWidget,

    ///不必传：输入框是否可编辑
    this.enabled = true,

    ///不必传：是否必选 *
    bool? required,

    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,

    ///不必传：有回调表示显示图标
    Function()? onTapTips,

    ///不必传：是否动态分割title与value的空间比例
    bool dynamicSeparate = true,
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

  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  TextEditingController? controller;
  FocusNode? focusNode;
  ValueChanged<String>? onChanged;
  bool enabled = true;

  //最右部件（地图定位/带单位 等）
  Widget? suffixWidget;

  //最左部件  暂未考虑到使用场景
  Widget? prefixWidget;

  @override
  State<StatefulWidget> createState() {
    return _LWFormInputState();
  }
}

class _LWFormInputState extends LWFormState<LWFormInput> {
  FocusNode? _focusNode;

  late final TextEditingController _controller;

  late String _value;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    //设置默认值
    _value = widget.value ?? '';
    widget.controller?.text = _value;
    _controller = widget.controller ??
        TextEditingController.fromValue(
            TextEditingValue(text: _value, selection: TextSelection.fromPosition(TextPosition(offset: _value.length))));
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget? buildPrefix() {
    return widget.prefixWidget;
  }

  @override
  Widget? buildSuffix() {
    return widget.suffixWidget;
  }

  @override
  Widget buildChildRight() {
    return widget.direction == Axis.vertical
        ? LWClick.onClick(
            onTap: () {
              _focusNode?.requestFocus();
            },
            child: Container(
              width: double.maxFinite,
              child: Text(
                '',
                style: TextStyle(fontSize: widget.valueSize ?? 14.sp, color: LWColors.gray2, height: 1.43),
              ),
            ),
          )
        : Container(
            width: double.maxFinite,
            alignment: Alignment.centerRight,
            child: _buildValue(),
          );
  }

  @override
  Widget? buildChildBottom() {
    return widget.direction == Axis.vertical
        ? Container(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.dp),
                _buildValue(),
              ],
            ),
          )
        : null;
  }

  /// child内容区
  Widget _buildValue() {
    return TextField(
      controller: _controller,
      textAlign: widget.direction == Axis.vertical ? TextAlign.start : TextAlign.end,
      maxLines: widget.direction == Axis.vertical ? 1 : 2,
      minLines: 1,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      focusNode: _focusNode,
      enabled: widget.enabled,
      enableSuggestions: true,
      enableIMEPersonalizedLearning: true,
      enableInteractiveSelection: true,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: widget.enabled ? (widget.hint ?? '请输入') : "",
        hintStyle: TextStyle(fontSize: widget.valueSize ?? 14.sp, color: LWColors.gray4, height: 1.43),
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: TextStyle(fontSize: widget.valueSize ?? 14.sp, color: widget.enabled == true ? LWColors.gray1 : LWColors.gray3, height: 1.43),
    );
  }
}
