// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_baby_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqBabyList _$ReqBabyListFromJson(Map<String, dynamic> json) => ReqBabyList(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      rentCode: json['rentCode'] as String?,
      cityCode: json['cityCode'] as String?,
      accountName: json['accountName'] as String?,
      currentChargeUserId: json['currentChargeUserId'] as String?,
    );

Map<String, dynamic> _$ReqBabyListToJson(ReqBabyList instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'rentCode': instance.rentCode,
      'cityCode': instance.cityCode,
      'accountName': instance.accountName,
      'currentChargeUserId': instance.currentChargeUserId,
    };
