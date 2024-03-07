
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../basic/button/lw_button.dart';
import '../../basic/colors/lw_colors.dart';
import '../../basic/lw_click.dart';
import '../../lw_widget.dart';

/// 搜索栏
/// 样式结构
///   |prefix|-----------content-----------|suffix|
///
///   该布局从左到右分为，prefix区、content区、suffix区
///   1）content区，可以用于放置搜索框和删除按钮
///   2）prefix区，可以用于放置搜索图标等自定义Widget
///   3）suffix区，可以用于放置图标、按钮等Widget
///
class LWSearchBar extends StatefulWidget {
  LWSearchBar({
    Key? key,
    this.text,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.controller,
    this.showInputClear = true,
    this.showSearchAction = false,
    this.inputRadius,
    this.inputBackgroundColor,
    this.inputDecoration,
    this.keyboardType,
    this.prefixWidget,
    this.suffixWidget,
    this.searchWidget,
    this.backgroundColor = Colors.white,
    this.onChanged,
    // this.onCancel,
    this.onSearch,
    this.autoFocus = false,
    this.padding,
  }) : super(key: key);

  /// 搜索框文字
  String? text;
  final TextStyle? textStyle;

  ///提示文字
  final String? hintText;
  final TextStyle? hintTextStyle;
  final int? maxLength;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  /// 输入框圆角, 默认6
  final bool showInputClear;
  final bool showSearchAction;
  final double? inputRadius;
  final Color? inputBackgroundColor;
  final Decoration? inputDecoration;
  final TextInputType? keyboardType;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? searchWidget;
  final Color? backgroundColor;

  /// 内容变化
  final ValueChanged<String>? onChanged;

  /// 点击搜索按钮或者点击键盘（搜索）
  final ValueChanged<String>? onSearch;

  /// 自动获取焦点
  final bool autoFocus;

  EdgeInsets? padding;

  @override
  State<LWSearchBar> createState() => _LWSearchBarState();
}

class _LWSearchBarState extends State<LWSearchBar> {
  bool _showClear = false;
  TextEditingController? _controller;

  TextEditingController get _getController => widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    widget.padding ??= EdgeInsets.fromLTRB(12.dp, 8.dp, 12.dp, 8.dp);
    if (widget.controller == null) {
      _controller = TextEditingController();
    }
    _getController.text = widget.text ?? "";
    _getController.addListener(
      () {
        String newValue = _getController.text;
        if (newValue.isNotEmpty && _showClear == false) {
          setState(() {
            _showClear = true;
          });
        } else if (newValue.isEmpty && _showClear == true) {
          setState(() {
            _showClear = false;
          });
        }
        widget.text = newValue;
        widget.onChanged?.call(newValue);
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _getController.dispose();
    }
    super.dispose();
  }

  TextField _buildTextFormField() {
    _showClear = _getController.text.isNotEmpty;

    return TextField(
      controller: _getController,
      cursorColor: LWColors.theme,
      maxLines: 1,
      minLines: 1,
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      textInputAction: TextInputAction.search,
      keyboardType: widget.keyboardType,
      style: widget.textStyle ?? TextStyle(fontSize: 13.sp, color: LWColors.gray1, height: 1.4),
      scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: _buildBorder(),
        focusedBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        counterText: "",
        hintStyle: widget.hintTextStyle ??
            TextStyle(
              fontSize: 13.sp,
              color: LWColors.gray4,
              textBaseline: TextBaseline.alphabetic,
              overflow: TextOverflow.ellipsis,
            ),
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: BoxConstraints(minWidth: LWWidget.isStyleCircle ? 40.dp : 32.dp),
        prefixIcon: IntrinsicWidth(
          child: widget.searchWidget ?? UnconstrainedBox(child: LWWidget.assetSvg('ic_search.svg', width: 16.dp, height: 16.dp)),
        ),
        suffixIconConstraints: BoxConstraints(minWidth: LWWidget.isStyleCircle ? 24.dp : 20.dp),
        suffixIcon: _showClear & widget.showInputClear
            ? LWClick.onClick(
                onTap: () {
                  setState(() {
                    _getController.clear();
                    _showClear = false;
                    _onSearch('');
                  });
                },
                child: UnconstrainedBox(child: LWWidget.assetSvg('ic_search_clear.svg', width: 16.dp, height: 16.dp)),
              )
            : null,
      ),
      onSubmitted: _onSearch,
    );
  }

  _onSearch(String? text) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (widget.onSearch != null) {
      widget.onSearch?.call(text ?? "");
    }
  }

  OutlineInputBorder _buildBorder() {
    return const OutlineInputBorder(borderSide: BorderSide(width: 0, style: BorderStyle.none));
  }

  _buildPrefix() {
    if (widget.prefixWidget != null) {
      return widget.prefixWidget;
    }
    return SizedBox(width: widget.padding?.left ?? 12.dp);
  }

  _buildSuffix() {
    if (widget.suffixWidget != null) {
      return widget.suffixWidget;
    } else if (widget.showSearchAction) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.dp),
        child: LWButton.primary(
          text: '搜索',
          minWidth: 60.dp,
          onPressed: LWClick.onClickAnti(onTap: () => _onSearch(widget.text)),
        ),
      );
    } else {
      return SizedBox(width: widget.padding?.left ?? 12.dp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      height: 30.dp + (widget.padding?.top ?? 7.dp) + (widget.padding?.bottom ?? 7.dp),
      padding: EdgeInsets.only(top: widget.padding?.top ?? 7.dp, bottom: widget.padding?.bottom ?? 7.dp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildPrefix(),
          Expanded(
            child: Container(
              decoration: widget.inputDecoration ??
                  BoxDecoration(
                    color: widget.inputBackgroundColor ?? LWColors.gray8,
                    borderRadius: BorderRadius.circular(widget.inputRadius ?? (LWWidget.isStyleCircle ? 100.dp : 6.dp)),
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _buildTextFormField()),
                  SizedBox(width: 8.dp),
                ],
              ),
            ),
          ),
          _buildSuffix(),
        ],
      ),
    );
  }
}
