// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_regist_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRegistParam _$DeviceRegistParamFromJson(Map<String, dynamic> json) =>
    DeviceRegistParam(
      productKey: json['productKey'] as String?,
      deviceName: json['deviceName'] as String?,
      deviceSecret: json['deviceSecret'] as String?,
      mqttHostUrl: json['mqttHostUrl'] as String?,
    );

Map<String, dynamic> _$DeviceRegistParamToJson(DeviceRegistParam instance) =>
    <String, dynamic>{
      'productKey': instance.productKey,
      'deviceName': instance.deviceName,
      'deviceSecret': instance.deviceSecret,
      'mqttHostUrl': instance.mqttHostUrl,
    };
