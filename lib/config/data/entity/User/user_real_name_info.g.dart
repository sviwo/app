// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_real_name_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRealNameInfo _$UserRealNameInfoFromJson(Map<String, dynamic> json) =>
    UserRealNameInfo(
      authFirstName: json['authFirstName'] as String?,
      authLastName: json['authLastName'] as String?,
      certificateFrontImg: json['certificateFrontImg'] as String?,
      certificateBackImg: json['certificateBackImg'] as String?,
      authStatus: json['authStatus'] as int? ?? 0,
      authFailReason: json['authFailReason'] as String?,
      authTime: json['authTime'] as String?,
      verifyTime: json['verifyTime'] as String?,
    );

Map<String, dynamic> _$UserRealNameInfoToJson(UserRealNameInfo instance) =>
    <String, dynamic>{
      'authFirstName': instance.authFirstName,
      'authLastName': instance.authLastName,
      'certificateFrontImg': instance.certificateFrontImg,
      'certificateBackImg': instance.certificateBackImg,
      'authStatus': instance.authStatus,
      'authFailReason': instance.authFailReason,
      'authTime': instance.authTime,
      'verifyTime': instance.verifyTime,
    };
