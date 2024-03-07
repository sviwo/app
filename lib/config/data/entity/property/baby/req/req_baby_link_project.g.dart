// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_baby_link_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqBabyLinkProject _$ReqBabyLinkProjectFromJson(Map<String, dynamic> json) =>
    ReqBabyLinkProject(
      accountCode: json['accountCode'] as String?,
      buildingUuidList: (json['buildingUuidList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReqBabyLinkProjectToJson(ReqBabyLinkProject instance) =>
    <String, dynamic>{
      'accountCode': instance.accountCode,
      'buildingUuidList': instance.buildingUuidList,
    };
