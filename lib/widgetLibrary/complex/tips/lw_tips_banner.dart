
import 'package:flutter/material.dart';
import '../../utils/size_util.dart';

import '../../basic/colors/lw_colors.dart';
import '../../basic/lw_click.dart';
import '../../lw_widget.dart';

/// 横幅提示
/// 样式结构
///   |prefix|-----------content-----------|suffix|
///
///   该布局从左到右分为，prefix区、content区、suffix区
///   1）content区，可以用于放置提示文本
///   2）prefix区，可以用于放置图标等Widget
///   3）suffix区，可以用于放置图标、按钮等Widget
///
class LWTipsBanner extends StatefulWidget {
  LWTipsBanner.custom({
    Key? key,
    required this.message,
    this.textColor,
    this.backgroundColor,
    this.backgroundDecoration,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  LWTipsBanner.warning({
    Key? key,
    required this.message,
    this.textColor = const Color(0xFFFFA033),
    this.backgroundColor = const Color(0xFFFEF7E8),
    this.withIcon = false,
    this.closable = false,
    this.model = 'warning',
  }) : super(key: key);

  LWTipsBanner.success({
    Key? key,
    required this.message,
    this.textColor,
    this.backgroundColor = const Color(0xFFF1F9ED),
    this.withIcon = false,
    this.closable = false,
    this.model = 'success',
  }) : super(key: key);

  LWTipsBanner.failed({
    Key? key,
    required this.message,
    this.textColor,
    this.backgroundColor = const Color(0xFFFDEDED),
    this.withIcon = false,
    this.closable = false,
    this.model = 'failed',
  }) : super(key: key);

  String message;
  Widget? prefix;
  Widget? suffix;
  Color? textColor;
  Color? backgroundColor;
  Decoration? backgroundDecoration;
  String model = 'custom';
  bool closable = false; // not for custom
  bool withIcon = false; // not for custom

  @override
  State<StatefulWidget> createState() => _LWTipsBannerState();
}

class _LWTipsBannerState extends State<LWTipsBanner> {
  bool removed = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowList = [];
    if (widget.prefix != null) {
      rowList.add(widget.prefix!);
    } else if (widget.model != 'custom' && widget.withIcon) {
      String iconName = '';
      if (widget.model == 'warning') {
        iconName = 'ic_tips_banner_warning.svg';
      } else if (widget.model == 'success') {
        iconName = 'ic_tips_banner_success.svg';
      } else if (widget.model == 'failed') {
        iconName = 'ic_tips_banner_failed.svg';
      }
      rowList.add(Padding(
        padding: EdgeInsets.only(left: 12.dp, top: 11.dp, bottom: 11.dp),
        child: LWWidget.assetSvg(iconName),
      ));
    }
    rowList.add(Expanded(
      flex: 1,
      child: Container(
        constraints: BoxConstraints(minHeight: 38.dp),
        padding: EdgeInsets.only(left: 12.dp, top: 10.dp, right: 12.dp, bottom: 10.dp),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.message,
          softWrap: true,
          style: TextStyle(color: widget.textColor ?? LWColors.gray1, fontSize: 13.sp),
        ),
      ),
    ));
    if (widget.suffix != null) {
      rowList.add(widget.suffix!);
    } else if (widget.model != 'custom' && widget.closable) {
      rowList.add(LWClick.onClick(
        onTap: () {
          setState(() {
            removed = !removed;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(right: 12.dp, top: 14.5.dp, bottom: 14.5.dp),
          child: LWWidget.assetSvg('ic_tips_banner_close.svg'),
        ),
      ));
    }

    return removed
        ? Container()
        : Container(
            decoration: widget.backgroundDecoration ??
                BoxDecoration(
                  color: widget.backgroundColor ?? Colors.transparent,
                ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rowList,
            ),
          );
  }
}
