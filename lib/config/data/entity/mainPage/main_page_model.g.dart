// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageModel _$HomePageModelFromJson(Map<String, dynamic> json) =>
    HomePageModel(
      nickname: json['nickname'] as String?,
      remainMile: json['remainMile'] as int? ?? 0,
      electricity: json['electricity'] as int? ?? 0,
      batteryStatus: json['batteryStatus'] == null
          ? false
          : LWObject.dynamicToBool(json['batteryStatus']),
      lockedStatus: json['lockedStatus'] == null
          ? false
          : LWObject.dynamicToBool(json['lockedStatus']),
      geoLocation: json['geoLocation'] == null
          ? null
          : GeoLocationDefine.fromJson(
              json['geoLocation'] as Map<String, dynamic>),
      isHavingCar: json['isHavingCar'] == null
          ? false
          : LWObject.dynamicToBool(json['isHavingCar']),
      userDeviceType: json['userDeviceType'] as int?,
      authStatus: json['authStatus'] as int?,
      mobileKey: LWObject.dynamicToBool(json['mobileKey']),
      speedLimit: LWObject.dynamicToBool(json['speedLimit']),
      drivingMode: json['drivingMode'] as int?,
      energyRecovery: json['energyRecovery'] as int?,
      version: (json['version'] as List<dynamic>?)
              ?.map((e) => HomePageVersion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$HomePageModelToJson(HomePageModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'remainMile': instance.remainMile,
      'electricity': instance.electricity,
      'batteryStatus': instance.batteryStatus,
      'lockedStatus': instance.lockedStatus,
      'geoLocation': instance.geoLocation?.toJson(),
      'isHavingCar': instance.isHavingCar,
      'userDeviceType': instance.userDeviceType,
      'authStatus': instance.authStatus,
      'mobileKey': instance.mobileKey,
      'speedLimit': instance.speedLimit,
      'drivingMode': instance.drivingMode,
      'energyRecovery': instance.energyRecovery,
      'version': instance.version.map((e) => e.toJson()).toList(),
    };

HomePageVersion _$HomePageVersionFromJson(Map<String, dynamic> json) =>
    HomePageVersion(
      versionId: json['versionId'] as String?,
      versionCode: json['versionCode'] as String?,
      versionType: json['versionType'] as int?,
      versionUpdateType: json['versionUpdateType'] as int?,
      versionUrl: json['versionUrl'] as String?,
      versionDesc: json['versionDesc'] as String?,
    );

Map<String, dynamic> _$HomePageVersionToJson(HomePageVersion instance) =>
    <String, dynamic>{
      'versionId': instance.versionId,
      'versionCode': instance.versionCode,
      'versionType': instance.versionType,
      'versionUpdateType': instance.versionUpdateType,
      'versionUrl': instance.versionUrl,
      'versionDesc': instance.versionDesc,
    };
