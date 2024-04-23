// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_location_define.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocationDefine _$GeoLocationDefineFromJson(Map<String, dynamic> json) =>
    GeoLocationDefine(
      latitude: LWObject.dynamicToDouble(json['latitude']),
      longitude: LWObject.dynamicToDouble(json['longitude']),
    );

Map<String, dynamic> _$GeoLocationDefineToJson(GeoLocationDefine instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
