// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_baby_link_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqBabyLinkAccount _$ReqBabyLinkAccountFromJson(Map<String, dynamic> json) =>
    ReqBabyLinkAccount(
      accountCode: json['accountCode'] as String?,
      accountCodeList: (json['accountCodeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReqBabyLinkAccountToJson(ReqBabyLinkAccount instance) =>
    <String, dynamic>{
      'accountCode': instance.accountCode,
      'accountCodeList': instance.accountCodeList,
    };
