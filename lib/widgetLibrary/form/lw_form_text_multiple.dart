import 'package:flutter/material.dart';
import '../basic/colors/lw_colors.dart';
import 'lw_form.dart';
import '../utils/size_util.dart';

///  表单-文本域  多行文本输入的组件
///
///  样式：
///  |—————————————————————————————————|
///  |- 标题 *图标                      -|
///  |- 请输入内容                      -|
///  |-                               -|
///  |-                               -|
///  |-                               -|
///  |-                         0/300 -|
///  |—————————————————————————————————|
///
class LWFormTextMultiple extends LWForm {
  LWFormTextMultiple({
    ///必传：左上角标题
    required String title,
    ///必传: 文本输入的最大长度
    required this.maxLength,
    ///不必传：文字字号
    double? titleSize,
    double? valueSize,
    ///不必传：文本域默认内容
    this.value = "",
    ///不必传：未输入内容时的提示内容 默认：请填写内容
    this.hintText = "请填写内容",
    ///不必传：输入内容回调
    this.onChanged,
    ///不必传：是否必填 *
    bool? required,
    ///不必传：有回调表示显示图标
    Function()? onTapTips,
    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,
    ///不必传：设置背景圆角等
    BoxConstraints? constraints,
    ///不必传：组件背景色
    Color? backgroundColor,
    ///不必传：文本域内容控制器
    this.controller,
  })  : assert(maxLength > 0, "文本限制长度必须大于0"),
        super(
            title: title,
            required: required,
            titleSize: titleSize,
            valueSize: valueSize,
            onTapTips: onTapTips,
            padding: padding,
            constraints: constraints,
            backgroundColor: backgroundColor,
            direction: Axis.vertical) {
    //默认内容回显问题
    if (value.length > maxLength) {
      value = value.substring(0, maxLength);
    }
  }

  /// 默认值/输入值
  String value;

  /// 输入值返回
  final ValueChanged<String>? onChanged;

  /// 可输入的最大值
  final int maxLength;

  /// 未输入内容的提示语
  final String? hintText;

  /// 无特殊监听场景无须传入 使用默认值就好
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() {
    return _LWFormTextMultipleState();
  }
}

class _LWFormTextMultipleState extends LWFormState<LWFormTextMultiple> {
  //固定行数
  final int _line = 4;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    //设置默认值
    widget.controller?.text = widget.value;
    //设置控制器
    _controller = widget.controller ??
        TextEditingController.fromValue(TextEditingValue(
            text: widget.value, selection: TextSelection.fromPosition(TextPosition(offset: widget.value.length))));
  }

  @override
  Widget? buildChildRight() {
    return Container();
  }

  @override
  Widget? buildChildBottom() {
    return Container(
      margin: EdgeInsets.only(top: 12.dp),
      padding: EdgeInsets.all(12.dp),
      decoration: BoxDecoration(color: LWColors.gray9, borderRadius: BorderRadius.circular(4)),
      child: RawScrollbar(
        thumbColor: LWColors.gray4,
        radius: Radius.circular(10.dp),
        thickness: 3.dp,
        child: TextFormField(
            controller: _controller,
            onChanged: widget.onChanged,
            textAlign: TextAlign.left,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: _line,
            maxLines: _line,
            style: TextStyle(fontSize: widget.valueSize ?? 14.sp, color: LWColors.gray1, height: 1.5),
            strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
            maxLength: widget.maxLength,
            cursorColor: LWColors.theme,
            decoration: InputDecoration(
              hintText: widget.hintText,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              hintStyle: TextStyle(fontSize: widget.valueSize ?? 14.sp, color: LWColors.gray4),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterStyle: TextStyle(fontSize: widget.valueSize ?? 13.sp, color: LWColors.gray4),
            )),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
