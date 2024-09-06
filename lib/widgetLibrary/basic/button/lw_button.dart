import '../../lw_widget.dart';
import '../colors/lw_colors.dart';
import '../lw_click.dart';
import '../../utils/size_util.dart';
import 'package:flutter/material.dart';

/// 图标位置
enum IconDirection {
  top,
  bottom,
  left,
  right,
}

/// 按钮
class LWButton extends StatefulWidget {
  LWButton._({Key? key, this.enabled = true, this.onPressed}) : super(key: key);

  LWButton.custom({
    Key? key,
    this.text,
    this.textSize,
    this.textColor,
    this.backgroundColor,
    this.highlightColor = Colors.transparent,
    this.minWidth,
    this.minHeight,
    this.iconWidget,
    this.iconSpacing,
    this.iconDirection,
    this.padding,
    this.shape,
    this.borderRadius,
    this.interval,
    this.onPressed,
    this.enabled = true,
    this.child,
  }) : super(key: key);

  LWButton.primary({
    Key? key,
    required String? text,
    double? textSize,
    Color? textColor,
    double? minWidth,
    double? minHeight,
    Widget? iconWidget,
    double? iconSpacing,
    IconDirection? iconDirection,
    EdgeInsets? padding,
    double? borderRadius,
    bool stroke = false,
    double strokeWidth = 0.5,
    VoidCallback? onPressed,
    bool enabled = true,
  }) : this.custom(
          key: key,
          text: text,
          textSize: textSize ?? 14.sp,
          textColor: textColor ?? (stroke ? LWColors.theme : Colors.white),
          backgroundColor: stroke ? Colors.transparent : LWColors.theme,
          minWidth: minWidth,
          minHeight: minHeight ?? 38.dp,
          iconWidget: iconWidget,
          iconSpacing: iconSpacing,
          iconDirection: iconDirection,
          padding: padding,
          shape: RoundedRectangleBorder(
            side: !stroke
                ? BorderSide.none
                : BorderSide(
                    color: LWColors.theme,
                    width: strokeWidth,
                    style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius ?? (LWWidget.isStyleCircle ? 100.dp : 6.dp))),
          ),
          onPressed: onPressed,
          enabled: enabled,
        );

  LWButton.secondary({
    Key? key,
    required String? text,
    double? textSize,
    Color? textColor,
    double? minWidth,
    double? minHeight,
    Widget? iconWidget,
    double? iconSpacing,
    IconDirection? iconDirection,
    EdgeInsets? padding,
    double? borderRadius,
    bool stroke = true,
    double strokeWidth = 0.5,
    VoidCallback? onPressed,
    bool enabled = true,
  }) : this.custom(
          key: key,
          text: text,
          textSize: textSize ?? 14.sp,
          textColor: textColor ?? LWColors.gray1,
          backgroundColor: stroke ? Colors.transparent : LWColors.gray6,
          minWidth: minWidth,
          minHeight: minHeight ?? 38.dp,
          iconWidget: iconWidget,
          iconSpacing: iconSpacing,
          iconDirection: iconDirection,
          padding: padding,
          shape: RoundedRectangleBorder(
            side: !stroke
                ? BorderSide.none
                : BorderSide(
                    color: LWColors.gray5,
                    width: strokeWidth,
                    style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius ?? (LWWidget.isStyleCircle ? 100.dp : 6.dp))),
          ),
          onPressed: onPressed,
          enabled: enabled,
        );

  LWButton.text({
    Key? key,
    this.text,
    this.textSize,
    this.textColor,
    this.backgroundColor,
    this.highlightColor = Colors.transparent,
    this.minWidth,
    this.minHeight,
    this.iconWidget,
    this.iconSpacing,
    this.iconDirection,
    this.padding,
    this.shape,
    this.interval,
    this.onPressed,
    this.enabled = true,
    this.isOnlyText = true,
  }) : super(key: key);

  /// 按钮文本
  String? text;

  /// 文本字号，默认14.sp
  double? textSize;

  /// 文本颜色，默认白色
  Color? textColor;

  /// 按钮背景颜色，会影响icon颜色，默认为null
  Color? backgroundColor;

  /// 按钮高亮颜色（点击后），默认Colors.transparent
  Color? highlightColor;

  /// 最小宽度，默认0
  double? minWidth;

  /// 最小高度，有子widget时，最小高度为子组件+padding, 默认38.dp
  double? minHeight;

  /// 图标
  Widget? iconWidget;

  /// 图文间距，默认4.dp
  double? iconSpacing;

  /// icon方向，默认IconDirection.left
  IconDirection? iconDirection;

  /// 常规类，默认EdgeInsets.symmetric(horizontal: 16.dp)
  /// 文本类&自定义child，默认EdgeInsets.zero()
  EdgeInsetsGeometry? padding;

  /// 按钮形状
  ShapeBorder? shape;

  /// 圆角，默认6.dp
  double? borderRadius;

  /// 点击时间间隔, null间隔2秒
  Duration? interval;

  /// 点击事件
  final VoidCallback? onPressed;

  /// 按钮是否可用
  bool enabled;

  /// 自定义文本区
  Widget? child;

  /// 是否为纯文本模式
  bool isOnlyText = false;

  @override
  State<LWButton> createState() => _LWButtonState();
}

class _LWButtonState extends State<LWButton> {
  _buildChild() {
    Widget _child = widget.child ??
        Text(
          widget.text ?? "",
          style: TextStyle(
              fontSize: widget.textSize ?? 14.sp,
              color: (!widget.enabled && widget.isOnlyText)
                  ? widget.textColor?.withOpacity(0.6)
                  : widget.textColor),
        );

    if (widget.iconWidget != null) {
      var _iconSpacing = widget.iconSpacing ?? 4.dp;
      widget.iconDirection ??= IconDirection.left;
      switch (widget.iconDirection) {
        case IconDirection.left:
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            widget.iconWidget!,
            SizedBox(width: _iconSpacing),
            _child
          ]);
        case IconDirection.right:
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _child,
            SizedBox(width: _iconSpacing),
            widget.iconWidget!
          ]);
        case IconDirection.bottom:
          return Column(children: [
            widget.iconWidget!,
            SizedBox(height: _iconSpacing),
            _child
          ]);
        case IconDirection.top:
          return Column(children: [
            _child,
            SizedBox(height: _iconSpacing),
            widget.iconWidget!
          ]);
        default:
          return _child;
      }
    }

    return _child;
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          Colors.white.opacity60,
          (!widget.enabled && !widget.isOnlyText)
              ? BlendMode.srcOver
              : BlendMode.dst),
      child: MaterialButton(
        child: _buildChild(),
        onPressed: LWClick.onClickAnti(onTap: () {
          if (!widget.enabled) return;
          widget.onPressed?.call();
        }),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusElevation: 0,
        elevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        padding: widget.padding ??
            (widget.minWidth != null ||
                    widget.isOnlyText ||
                    widget.child != null
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(horizontal: 16.dp)),
        shape: widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius ??
                      (LWWidget.isStyleCircle ? 100.dp : 6.dp))),
            ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: widget.minWidth ??
            ((widget.padding != null || widget.isOnlyText)
                ? 0
                : double.infinity),
        height: widget.minHeight ?? 38.dp,
        color: widget.backgroundColor,
        textColor: widget.textColor ?? LWColors.gray1,
        highlightColor: widget.highlightColor,
        disabledColor: widget.backgroundColor,
        disabledTextColor: widget.textColor ?? LWColors.gray1,
      ),
    );
  }
}
