import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:flutter/material.dart';

class WebListConfigTool {
  WebListConfigTool._();
  static Widget iconImage({String name = ''}) {
    Widget img = const SizedBox.shrink();
    if (name == 'vehicle_cannot_start') {
      img = Image.asset(
        AppIcons.imgHelpAlertIcon,
        width: 17.3.dp,
        height: 15.3.dp,
      );
    } else if (name == 'way_to_contact_us') {
      img = Image.asset(
        AppIcons.imgHelpDialogIcon,
        height: 14.3.dp,
        width: 16.3.dp,
      );
    } else if (name == 'way_to_maintain_vehicle') {
      img = Image.asset(
        AppIcons.imgHelpMaintainIcon,
        width: 14.3.dp,
        height: 14.3.dp,
      );
    } else if (name == 'video_tutorial') {
      img = Image.asset(
        AppIcons.imgServicePlayIcon,
        width: 17.7.dp,
        height: 17.7.dp,
      );
    } else if (name == 'technical_support') {
      img = Image.asset(
        AppIcons.imgServiceSettingIcon,
        width: 17.7.dp,
        height: 17.7.dp,
      );
    }
    return img;
  }

  static Widget iconSpace({String name = ''}) {
    Widget space = const SizedBox.shrink();

    if (name == 'vehicle_cannot_start') {
      space = SizedBox(
        width: 15.dp,
      );
    } else if (name == 'way_to_contact_us') {
      space = SizedBox(
        width: 16.dp,
      );
    } else if (name == 'way_to_maintain_vehicle') {
      space = SizedBox(
        width: 18.dp,
      );
    } else if (name == 'video_tutorial') {
      space = SizedBox(
        width: 18.dp,
      );
    } else if (name == 'technical_support') {
      space = SizedBox(
        width: 18.dp,
      );
    }
    return space;
  }
}
