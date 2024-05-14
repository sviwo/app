import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/bluetooth/blue_tooth_util.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/data/entity/vehicle/device_regist_param.dart';
import 'package:atv/config/net/api_device_.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NearByBluetoothDevicesPageViewModel extends BaseViewModel {
  /// 车架号
  String deviceName = '';
  List<String> peripherals = [
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

  //YGTODO: 扫描附近蓝牙外设 扫描到的数据保存到外设数组数组 并在界面上配置显示数据
  scanNearbyBluetoothPeripheral() {}

  /// 获取注册设备到指定产品下所需要的证书
  getDeviceCertificate({Function(DeviceRegistParam)? callback}) {
    loadApiData<DeviceRegistParam>(
      ApiDevice.getDeviceCertificate(deviceName),
      handlePageState: false,
      showLoading: true,
      dataSuccess: (data) {
        ///得到蓝牙从后台获取的证书
        if (callback != null) {
          callback(data);
        }
      },
    );
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args != null && args is Map<String, dynamic>) {
      deviceName = args['deviceName'];
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
