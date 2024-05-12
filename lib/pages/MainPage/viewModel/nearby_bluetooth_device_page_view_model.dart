import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/bluetooth/blue_tooth_util.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NearByBluetoothDevicesPageViewModel extends BaseViewModel {
  List<String> deviceNames = [
    "ddddd",
    "你的老师卡菲纳萨勒芬妮扩散法三开发卢萨卡放哪",
    "dsndfdklsdnfksanslfnk",
    "ddddd",
    "你的老师卡菲纳萨勒芬妮扩散法三开发卢萨卡放哪",
    "dsndfdklsdnfksanslfnk",
    "ddddd",
    "你的老师卡菲纳萨勒芬妮扩散法三开发卢萨卡放哪",
    "dsndfdklsdnfksanslfnk",
    "ddddd",
    "你的老师卡菲纳萨勒芬妮扩散法三开发卢萨卡放哪",
    "dsndfdklsdnfksanslfnk",
    "ddddd",
    "你的老师卡菲纳萨勒芬妮扩散法三开发卢萨卡放哪",
    "dsndfdklsdnfksanslfnk",
    "ddddd",
    "你的老师卡菲纳萨勒芬妮扩散法三开发卢萨卡放哪",
    "dsndfdklsdnfksanslfnk"
  ];

  String? currentDevice;

  bool isCurrent(String code) => currentDevice == code;

  chooseDevice(String code) async {
    currentDevice = code;
    pageRefresh();

    BlueToothUtil.getInstance().readChart;
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
  }

  @override
  void release() {
    // TODO: implement release
  }
}
