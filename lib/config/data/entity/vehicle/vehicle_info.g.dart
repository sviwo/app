// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleInfo _$VehicleInfoFromJson(Map<String, dynamic> json) => VehicleInfo(
      deviceId: json['deviceId'] as String?,
      nickname: json['nickname'] as String?,
      deviceName: json['deviceName'] as String?,
      mobileKey: LWObject.dynamicToBool(json['mobileKey']),
      speedLimit: LWObject.dynamicToBool(json['speedLimit']),
      drivingMode: json['drivingMode'] as int?,
      energyRecovery: json['energyRecovery'] as int?,
      userDeviceType: json['userDeviceType'] as int?,
      activateTime: json['activateTime'] as String?,
      warrantyTime: json['warrantyTime'] as String?,
      mileage: LWObject.dynamicToString(json['mileage']),
      topSpeedHour: json['topSpeedHour'] as int?,
      userCarKeyList: (json['userCarKeyList'] as List<dynamic>?)
          ?.map((e) => VehicleInfoKeyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VehicleInfoToJson(VehicleInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'nickname': instance.nickname,
      'deviceName': instance.deviceName,
      'mobileKey': instance.mobileKey,
      'speedLimit': instance.speedLimit,
      'drivingMode': instance.drivingMode,
      'energyRecovery': instance.energyRecovery,
      'userDeviceType': instance.userDeviceType,
      'activateTime': instance.activateTime,
      'warrantyTime': instance.warrantyTime,
      'mileage': instance.mileage,
      'topSpeedHour': instance.topSpeedHour,
      'userCarKeyList':
          instance.userCarKeyList?.map((e) => e.toJson()).toList(),
    };

VehicleInfoKeyInfo _$VehicleInfoKeyInfoFromJson(Map<String, dynamic> json) =>
    VehicleInfoKeyInfo(
      userDeviceId: json['userDeviceId'] as String?,
      name: json['name'] as String?,
      headImg: json['headImg'] as String?,
    );

Map<String, dynamic> _$VehicleInfoKeyInfoToJson(VehicleInfoKeyInfo instance) =>
    <String, dynamic>{
      'userDeviceId': instance.userDeviceId,
      'name': instance.name,
      'headImg': instance.headImg,
    };
