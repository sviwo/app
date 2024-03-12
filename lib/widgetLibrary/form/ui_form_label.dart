import 'package:basic_utils/basic_utils.dart';

import '../basic/colors/lw_colors.dart';
import '../utils/size_util.dart';
import 'package:flutter/widgets.dart';

Widget UIFormLabel(String key, String? value,
    {double? fontSize,
    Color? labelColor,
    Color? valueColor,
    double? bottomMargin,
    double? paddingLeft,
    double? paddingRight,
    double? paddingHorizontal,
    bool? singleLine}) {
  bottomMargin ??= 8.dp;
  return Container(
    margin: EdgeInsets.only(bottom: bottomMargin),
    padding: EdgeInsets.only(
        left: paddingHorizontal ?? paddingLeft ?? 0,
        right: paddingHorizontal ?? paddingRight ?? 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$key：',
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          style: TextStyle(
              fontSize: fontSize ?? 14.sp, color: labelColor ?? LWColors.gray4),
        ),
        Expanded(
          child: Text(
            StringUtils.isNullOrEmpty(value) ? '-' : value!,
            softWrap: true,
            maxLines: singleLine == true ? 1 : null,
            overflow: singleLine == true ? TextOverflow.ellipsis : null,
            strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
            style: TextStyle(
                fontSize: fontSize ?? 14.sp,
                color: valueColor ?? LWColors.gray1),
          ),
        ),
      ],
    ),
  );
}
