import 'dart:async';

import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/bluetooth/blue_test.dart';
import 'package:atv/archs/utils/bluetooth/blue_tooth_util.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/data/entity/vehicle/device_regist_param.dart';
import 'package:atv/config/net/api_device_.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:atv/widgetLibrary/complex/loading/lw_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class NearByBluetoothDevicesPageViewModel extends BaseViewModel {
  /// 车架号
  String deviceName = '';

  Stream<List<ScanResult>> get bluetoothDeviceList =>
      BlueToothUtil.getInstance().bluetoothDeviceList;

  String? currentDevice;

  bool isCurrent(ScanResult device) =>
      currentDevice == device.device.id.toString();

  /// 手机蓝牙是否打开的订阅
  StreamSubscription<bool>? connectSubscription;

  String bluetoothName(ScanResult device) {
    // device.platformName 蓝牙名称
    // device.remoteId.str 蓝牙mac
    return device.device.name + device.device.id.toString();
  }

  chooseDevice(ScanResult device) async {
    currentDevice = device.device.id.toString();
    pageRefresh();
    await Future.delayed(Duration.zero, () {
      // 连接蓝牙.
      LWLoading.showLoading2(text: LocaleKeys.is_loading.tr());
      BlueToothUtil.getInstance().connectBluetooth(device.device);
    });
    // BlueToothUtil.getInstance().readChart;
  }

  /// 获取注册设备到指定产品下所需要的证书
  getDeviceCertificate({Function(DeviceRegistParam)? callback}) {
    loadApiData<DeviceRegistParam>(
      ApiDevice.getDeviceCertificate(deviceName),
      handlePageState: false,
      showLoading: true,
      dataSuccess: (data) {
        BlueToothUtil.getInstance().setDeviceRegistParam(data);

        ///得到蓝牙从后台获取的证书
        if (callback != null) {
          callback(data);
        }
      },
    );
  }

  /// 通知服务器车辆注册成功
  // notifyDeviceRegistSuccess({VoidCallback? callback}) {
  //   loadApiData(
  //     ApiDevice.vehicleRegisterSuccess(
  //         deviceName,
  //         BlueToothUtil.getInstance().currBlueName!,
  //         BlueToothUtil.getInstance().keyString!,
  //         BlueToothUtil.getInstance().simID!),
  //     handlePageState: false,
  //     showLoading: true,
  //     voidSuccess: () {
  //       EventManager.post(AppEvent.vehicleRegistSuccess);
  //       if (callback != null) {
  //         callback();
  //       }
  //     },
  //   );
  // }

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args != null && args is Map<String, dynamic>) {
      deviceName = args['deviceName'];
      BlueToothUtil.getInstance().setDeviceName(deviceName);
    }
    BlueToothUtil.getInstance().startScanBlueTooth();
    connectSubscription =
        BlueToothUtil.getInstance().connectDataStream.listen((event) {
      LWLoading.dismiss(animation: true);
    });
    // deviceName = 'sviwo-asdas546a4s6d5';
    // BlueToothUtil.getInstance().getDeviceCertificate();
  }

  @override
  void release() {
    // TODO: implement release
    connectSubscription?.cancel();
    BlueToothUtil.getInstance().stopScanBlueTooth();
  }
}
