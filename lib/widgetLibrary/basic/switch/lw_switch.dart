
import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../colors/lw_colors.dart';
import '../../utils/size_util.dart';

// 使用iOS风格Switch
class LWSwitch extends FlutterSwitch {
  LWSwitch({
    Key? key,
    bool disabled = false,
    required bool isOn,
    required ValueChanged<bool> onToggle,
  }) : super(
          key: key,
          width: 43.dp,
          height: 27.dp,
          toggleSize: 23.dp,
          activeColor: LWColors.theme,
          inactiveColor: LWColors.gray5,
          padding: 2.dp,
          value: isOn,
          disabled: disabled,
          onToggle: onToggle,
        );
}
