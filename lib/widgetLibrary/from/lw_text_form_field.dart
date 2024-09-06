
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../basic/colors/lw_colors.dart';
import '../basic/lw_click.dart';
import '../lw_widget.dart';

enum LWTextFormFieldType {
  edit,
  choose,
}

class LWTextFormField extends StatefulWidget {
  LWTextFormField({
    Key? key,
    this.title,
    this.titleStyle,
    this.fontSize = 14,
    this.subTitle,
    this.subTitleStyle,
    this.hintText,
    this.hintTextStyle,
    this.controller,
    this.spacing,
    this.titleWidth,
    this.subTitleWidth,
    this.showStar = false,
    this.maxLines = 1,
    this.subTitleMaxLines = 1,
    this.subTitleMaxLength,
    this.enabled = true,
    this.prefixWidget,
    this.suffixWidget,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTapTips,
    this.keyboardType,
    this.showCleanButton = false,
    this.inputFormatters,
    this.subTitleTextAlign = TextAlign.right,
    this.type = LWTextFormFieldType.edit,
    this.direction = Axis.horizontal,
    this.chooseModeIcon,
  }) : super(key: key);

  final TextEditingController? controller;

  /// 标题文字，左或上
  final String? title;
  final TextStyle? titleStyle;

  ///
  final double fontSize;

  /// 子标题文字（内容），右或下
  String? subTitle;
  final TextStyle? subTitleStyle;

  ///提示文字
  final String? hintText;
  final TextStyle? hintTextStyle;

  /// 显示星号
  final bool showStar;

  /// title和subTitle间距，默认水平24，垂直4
  final double? spacing;

  /// title宽度，默认titleWidth==subTitleWidth
  final double? titleWidth;

  /// subTitle宽度，默认titleWidth==subTitleWidth
  final double? subTitleWidth;

  /// 输入框类型
  final LWTextFormFieldType type;
  final int? maxLines;
  final int? subTitleMaxLines;

  final int? subTitleMaxLength;
  final FocusNode? focusNode;

  /// type == LWTextFormFieldType.choose，输入框始终不能输入，enabled无效
  final bool? enabled;
  final bool showCleanButton;
  final Axis direction;
  final TextAlign subTitleTextAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  /// onTapTips != null，显示tips图标
  final GestureTapCallback? onTapTips;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;

  final Widget? chooseModeIcon;

  @override
  State<LWTextFormField> createState() => _LWTextFormFieldState();
}

class _LWTextFormFieldState extends State<LWTextFormField> {
  bool _showCleanButton = false;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late final TextEditingController _controller = TextEditingController();

  TextEditingController get _getController => widget.controller ?? _controller;
  FocusNode get _getFocusNode => widget.focusNode ?? _focusNode;

  @override
  void initState() {
    super.initState();
    _getController.text = widget.subTitle ?? "";
    _getFocusNode.addListener(() {
      if (_getFocusNode.hasFocus == false) {
        _scrollController.jumpTo(0);
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete!();
        }
      }
    });
    _getController.addListener(
      () {
        String newValue = _getController.text;
        if (newValue.isNotEmpty && _showCleanButton == false) {
          setState(() {
            _showCleanButton = true;
          });
        } else if (newValue.isEmpty && _showCleanButton == true) {
          setState(() {
            _showCleanButton = false;
          });
        }
        widget.subTitle = newValue;
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
    );
  }

  @override
  void dispose() {
    _getController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  double _spacing() => widget.spacing ?? (widget.direction == Axis.horizontal ? 24 : 4);

  double get _fontSize => widget.fontSize;
  final double _cleanButtonSize = 16;
  final double _cleanButtonSpacing = 5;

  OutlineInputBorder _getBorder() {
    return const OutlineInputBorder(borderSide: BorderSide(width: 0, style: BorderStyle.none));
  }

  TextFormField _getTextFormField() {
    bool enabled = widget.enabled == true && widget.type == LWTextFormFieldType.edit;
    _showCleanButton = _getController.text.isNotEmpty && enabled == true;

    return TextFormField(
      controller: _getController,
      scrollController: _scrollController,
      cursorColor: LWColors.gray1,
      maxLines: widget.subTitleMaxLines,
      minLines: 1,
      maxLength: widget.subTitleMaxLength,
      enabled: enabled,
      focusNode: _getFocusNode,
      textAlign: widget.subTitleTextAlign,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      style: _getSubTitleTextStyle(),
      scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: widget.hintText,
        border: _getBorder(),
        focusedBorder: _getBorder(),
        enabledBorder: _getBorder(),
        disabledBorder: _getBorder(),
        counterText: "",
        hintStyle: _getHintTextStyle(),
        contentPadding: EdgeInsets.zero,
        suffixIconConstraints:
            BoxConstraints(maxWidth: _cleanButtonSize + _cleanButtonSpacing * 2, maxHeight: _cleanButtonSize),
        suffixIcon: _showCleanButton & widget.showCleanButton == false
            ? null
            : IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _getController.clear();
                    _showCleanButton = false;
                  });
                },
                icon: const Icon(Icons.cancel, color: LWColors.gray4),
                iconSize: _cleanButtonSize,
              ),
      ),
      onSaved: widget.onSaved,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }

  Widget _getTitleWidget() {
    return SizedBox(
      width: widget.titleWidth,
      child: Align(
        widthFactor: 1.0,
        heightFactor: 1.0,
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: widget.title,
            style: _getTitleTextStyle(),
            children: [
              TextSpan(
                text: widget.showStar ? ' *' : "",
                style: TextStyle(fontSize: _fontSize, color: LWColors.brand),
                children: [
                  widget.onTapTips == null
                      ? const TextSpan()
                      : WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SizedBox(
                            width: _fontSize + _cleanButtonSpacing * 2,
                            child: Container(
                              color: Colors.transparent,
                              child: LWClick.onClick(
                                onTap: widget.onTapTips,
                                child: LWWidget.assetImg(
                                  'ic_tips.png',
                                  width: _fontSize,
                                  height: _fontSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: widget.maxLines,
        ),
      ),
    );
  }

  Widget _getSubTitleWidget() {
    return SizedBox(
      width: widget.subTitleWidth,
      child: widget.type == LWTextFormFieldType.choose || widget.enabled == false
          ? Text(
              (widget.subTitle ?? widget.hintText) ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: widget.subTitleMaxLines,
              textAlign: widget.subTitleTextAlign,
              style: widget.subTitle != null ? _getSubTitleTextStyle() : _getHintTextStyle(),
            )
          : _getTextFormField(),
    );
  }

  _getTitleTextStyle() {
    return widget.titleStyle ?? TextStyle(fontSize: _fontSize, color: LWColors.gray2);
  }

  _getSubTitleTextStyle() {
    return widget.subTitleStyle ??
        TextStyle(
          fontSize: _fontSize,
          color: widget.type == LWTextFormFieldType.choose
              ? LWColors.gray1
              : (widget.enabled == true ? LWColors.gray1 : LWColors.gray3),
        );
  }

  _getHintTextStyle() {
    return widget.hintTextStyle ??
        TextStyle(
          fontSize: _fontSize,
          color: LWColors.gray5,
          textBaseline: TextBaseline.alphabetic,
          overflow: TextOverflow.ellipsis,
        );
  }

  Widget _getSelectArrow() {
    if (widget.type == LWTextFormFieldType.choose) {
      return widget.chooseModeIcon ??
          Container(
            margin: EdgeInsets.only(
              left: _cleanButtonSpacing,
            ),
            child: LWWidget.assetImg('ic_arrow_right.png', width: 10, height: 10),
          );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LWClick.onClick(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (widget.type == LWTextFormFieldType.choose && widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: widget.direction == Axis.horizontal
          ? Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.prefixWidget ?? Container(),
                Expanded(
                  flex: widget.titleWidth == null ? 1 : 0,
                  child: _getTitleWidget(),
                ),
                SizedBox(
                  width: _spacing(),
                ),
                Expanded(
                  flex: widget.subTitleWidth == null ? 1 : 0,
                  child: _getSubTitleWidget(),
                ),
                widget.suffixWidget ?? Container(),
                _getSelectArrow(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.prefixWidget ?? Container(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getTitleWidget(),
                      SizedBox(
                        height: _spacing(),
                      ),
                      _getSubTitleWidget(),
                    ],
                  ),
                ),
                widget.suffixWidget ?? Container(),
                _getSelectArrow(),
              ],
            ),
    );
  }
}
