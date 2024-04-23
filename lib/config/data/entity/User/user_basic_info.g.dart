// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_basic_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBasicInfo _$UserBasicInfoFromJson(Map<String, dynamic> json) =>
    UserBasicInfo(
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      mobilePhone: json['mobilePhone'] as String?,
      userAddress: json['userAddress'] as String?,
      headImg: json['headImg'] as String?,
      nickname: json['nickname'] as String?,
      deviceName: json['deviceName'] as String?,
      mileage: json['mileage'] as int? ?? 0,
      authStatus: json['authStatus'] as int? ?? 0,
    );

Map<String, dynamic> _$UserBasicInfoToJson(UserBasicInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobilePhone': instance.mobilePhone,
      'userAddress': instance.userAddress,
      'headImg': instance.headImg,
      'nickname': instance.nickname,
      'deviceName': instance.deviceName,
      'mileage': instance.mileage,
      'authStatus': instance.authStatus,
    };
