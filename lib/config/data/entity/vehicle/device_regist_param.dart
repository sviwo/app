import 'package:json_annotation/json_annotation.dart';

part 'device_regist_param.g.dart';

@JsonSerializable()
class DeviceRegistParam {

  DeviceRegistParam({
    this.productKey,
    this.deviceName,
    this.deviceSecret,
    this.mqttHostUrl
  });
  /// 对应物联网平台产品的ProductKey
  String? productKey;
  /// 对应物联网平台颁发的设备证书的DeviceName
  String? deviceName;
  /// 对应物联网平台颁发的设备证书的DeviceSecret
  String? deviceSecret;
  /// mqtt连接url
  String? mqttHostUrl;

  factory DeviceRegistParam.fromJson(Map<String, dynamic> srcJson) =>
      _$DeviceRegistParamFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$DeviceRegistParamToJson(this);
  }
}