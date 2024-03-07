// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Industry _$IndustryFromJson(Map<String, dynamic> json) => Industry(
      delFlg: json['delFlg'] as String?,
      industryCode: json['industryCode'] as String?,
      industryName: json['industryName'] as String?,
      industryLevel: json['industryLevel'] as String?,
      parentCode: json['parentCode'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Industry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'delFlg': instance.delFlg,
      'industryCode': instance.industryCode,
      'industryName': instance.industryName,
      'industryLevel': instance.industryLevel,
      'parentCode': instance.parentCode,
      'children': instance.children?.map((e) => e.toJson()).toList(),
    };
