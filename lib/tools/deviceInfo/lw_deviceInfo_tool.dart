import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class LWDeviceInfos {
  // Sit("sit", "http://t-ser-cloud.xinchao.com/"),
  // Prod("prod", "http://ser-cloud.xinchao.com/")
  //"/portal/xc-statistics/statistics/page"
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 获取唯一标识  iOS可能取不到
  static Future<String> getDeviceIdentifier() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.androidId.isNotEmpty) {
        return androidInfo.androidId;
      } else if (androidInfo.fingerprint.isNotEmpty) {
        return androidInfo.fingerprint;
      } else {
        return androidInfo.device;
      }
    } else if (Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      return "";
    }
  }

  /// 获取是那种设备
  static String getPlatform() {
    if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isAndroid) {
      return "Android";
    } else {
      return "";
    }
  }

  static Future<PackageInfo> getAppInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
