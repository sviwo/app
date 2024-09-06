import 'package:flutter/material.dart';
import '../../basic/colors/lw_colors.dart';
import '../../utils/size_util.dart';

import '../../basic/font/lw_font_weight.dart';
import '../../lw_widget.dart';
import '../tips/lw_pop_over/lw_pop_item.dart';
import '../tips/lw_pop_over/lw_pop_theme.dart';
import '../tips/lw_pop_over/popover.dart';
import '../tips/lw_pop_over/popover_direction.dart';

///浮层菜单
class LWMenuPop {
  static show(
      {required BuildContext context,
      required List<LWPopItem> items,
      //显示位置
      required PopoverDirection direction,
      //主题颜色
      LWPopTheme? theme,
      double arrowDxOffset = 0,
      double arrowDyOffset = 0,
      //间距
      EdgeInsetsGeometry? padding,
      //item间距
      EdgeInsetsGeometry? itemPadding,
      //圆角宽度
      double? radius}) {
    showPopover(
        context: context,
        direction: direction,
        backgroundColor: theme == LWPopTheme.light
            ? Colors.white.opacity80
            : Colors.black.opacity80,
        arrowHeight: 8.dp,
        arrowWidth: 12.dp,
        radius: radius ?? 4.dp,
        barrierColor: Colors.transparent,
        arrowDxOffset: arrowDxOffset,
        arrowDyOffset: arrowDyOffset,
        bodyBuilder: (context) {
          return IntrinsicWidth(
            child: Container(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 12.dp),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        _itemWidgets(context, items, theme, itemPadding))),
          );
        });
  }
}

List<Widget> _itemWidgets(BuildContext context, List<LWPopItem> items,
    LWPopTheme? theme, EdgeInsetsGeometry? itemPadding) {
  List<Widget> list = [];

  for (var i = 0; i < items.length; i++) {
    LWPopItem value = items[i];
    list.add(GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        value.onTap?.call();
      },
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: itemPadding ?? EdgeInsets.symmetric(vertical: 12.dp),
          child: Row(
            children: [
              value.svgIcon == null
                  ? const SizedBox()
                  : Row(children: [
                      LWWidget.assetSvg(value.svgIcon!,
                          height: 20.dp, width: 20.dp),
                      SizedBox(width: 10.dp)
                    ]),
              Text(
                value.text ?? "",
                strutStyle:
                    const StrutStyle(forceStrutHeight: true, leading: 0),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: LWFontWeight.normal,
                    color: theme == LWPopTheme.light
                        ? LWColors.gray1
                        : Colors.white),
              )
            ],
          ),
        ),
        i == items.length - 1
            ? const SizedBox()
            : Container(
                height: 1.dp,
                width: double.infinity,
                color: LWColors.gray6,
              )
      ]),
    ));
  }

  return list;
}
