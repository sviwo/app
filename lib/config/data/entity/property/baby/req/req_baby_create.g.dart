// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_baby_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqBabyCreate _$ReqBabyCreateFromJson(Map<String, dynamic> json) =>
    ReqBabyCreate(
      rentCode: json['rentCode'] as String?,
      accountName: json['accountName'] as String?,
      parentAccountCode: json['parentAccountCode'] as String?,
      userName: json['userName'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      percentage: json['percentage'] as String?,
      buildingUuidList: (json['buildingUuidList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReqBabyCreateToJson(ReqBabyCreate instance) =>
    <String, dynamic>{
      'rentCode': instance.rentCode,
      'accountName': instance.accountName,
      'parentAccountCode': instance.parentAccountCode,
      'userName': instance.userName,
      'phone': instance.phone,
      'password': instance.password,
      'percentage': instance.percentage,
      'buildingUuidList': instance.buildingUuidList,
    };
