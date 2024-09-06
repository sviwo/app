// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleListModel _$VehicleListModelFromJson(Map<String, dynamic> json) =>
    VehicleListModel(
      deviceId: json['deviceId'] as String?,
      nickname: json['nickname'] as String?,
      mileage: LWObject.dynamicToString(json['mileage']),
      deviceName: json['deviceName'] as String?,
      isSelect: LWObject.dynamicToBool(json['isSelect']),
      userDeviceType: LWObject.dynamicToInt(json['userDeviceType']),
    );

Map<String, dynamic> _$VehicleListModelToJson(VehicleListModel instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'nickname': instance.nickname,
      'mileage': instance.mileage,
      'deviceName': instance.deviceName,
      'isSelect': instance.isSelect,
      'userDeviceType': instance.userDeviceType,
    };
