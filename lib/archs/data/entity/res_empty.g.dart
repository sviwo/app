// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_empty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResEmpty _$ResEmptyFromJson(Map<String, dynamic> json) => ResEmpty(
      code: json['code'],
      msg: json['msg'] ?? '',
    )
      ..data = json['data']
      ..originalData = json['originalData'];

Map<String, dynamic> _$ResEmptyToJson(ResEmpty instance) => <String, dynamic>{
      'data': instance.data,
      'originalData': instance.originalData,
      'code': instance.code,
      'msg': instance.msg,
    };
