
import 'package:flutter/material.dart';
import '../../basic/colors/lw_colors.dart';

import 'lw_pop_over/lw_pop_item.dart';
import 'lw_pop_over/lw_pop_theme.dart';
import 'lw_pop_over/popover.dart';
import 'lw_pop_over/popover_direction.dart';
import 'lw_pop_over/popover_item.dart';
import '../../utils/size_util.dart';

import '../../basic/font/lw_font_weight.dart';
import '../../lw_widget.dart';


///浮层气泡
class LWTipsPop {
  ///显示文本
  static showText(
      {required BuildContext context,
      required String text,
      //显示位置
      required PopoverDirection direction,
      //主题颜色
      LWPopTheme theme = LWPopTheme.dark,
      double arrowDxOffset = 0,
      double arrowDyOffset = 0,
      //圆角宽度
      double? radius}) {
    showPopover(
        context: context,
        direction: direction,
        backgroundColor: theme == LWPopTheme.dark ? Colors.black.opacity60 : Colors.white.opacity60,
        arrowHeight: 8.dp,
        arrowWidth: 12.dp,
        radius: radius ?? 4.dp,
        barrierColor: Colors.transparent,
        arrowDxOffset: arrowDxOffset,
        arrowDyOffset: arrowDyOffset,
        bodyBuilder: (context) {
          return Container(
              padding: EdgeInsets.all(12.dp),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: LWFontWeight.normal,
                    color: theme == LWPopTheme.dark ? Colors.white : LWColors.gray1),
              ));
        });
  }

  ///显示按钮
  static showButton(
      {required BuildContext context,
      //显示位置
      required PopoverDirection direction,
      //需要显示的列表
      required List<LWPopItem> buttons,
      double arrowDxOffset = 0,
      double arrowDyOffset = 0,
      //圆角宽度
      double? radius}) {
    showPopover(
        context: context,
        direction: direction,
        backgroundColor: Colors.black.opacity60,
        arrowHeight: 8.dp,
        arrowWidth: 12.dp,
        radius: radius ?? 4.dp,
        barrierColor: Colors.transparent,
        arrowDxOffset: arrowDxOffset,
        arrowDyOffset: arrowDyOffset,
        bodyBuilder: (context) {
          return Row(mainAxisSize: MainAxisSize.min, children: _buttonItems(context, buttons));
        });
  }

  static List<Widget> _buttonItems(BuildContext context, List<LWPopItem> buttons) {
    List<Widget> list = [];

    for (var i = 0; i < buttons.length; i++) {
      list.add(_button(context, buttons[i]));

      //不是最后一个添加分割线
      if (i < buttons.length - 1) {
        list.add(Container(color: Colors.black, height: 18.dp, width: 1.dp));
      }
    }

    return list;
  }

  static Widget _button(BuildContext context, LWPopItem button) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 8.dp),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          button.svgIcon == null
              ? const SizedBox()
              : LWWidget.assetSvg(button.svgIcon!, color: Colors.white, height: 14.dp, width: 16.dp),
          SizedBox(
            width: 4.dp,
          ),
          Text(button.text ?? "",
              style: TextStyle(fontSize: 14.sp, fontWeight: LWFontWeight.normal, color: Colors.white))
        ]),
      ),
      onTap: () {
        Navigator.pop(context);
        button.onTap?.call();
      },
    );
  }
}
