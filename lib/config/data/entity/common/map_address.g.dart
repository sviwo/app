// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapAddress _$MapAddressFromJson(Map<String, dynamic> json) => MapAddress(
      name: json['name'] as String?,
      address: json['address'] as String?,
      provinceName: json['provinceName'] as String?,
      cityName: json['cityName'] as String?,
      areaName: json['areaName'] as String?,
      longitude: json['longitude'] as num?,
      latitude: json['latitude'] as num?,
    );

Map<String, dynamic> _$MapAddressToJson(MapAddress instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'provinceName': instance.provinceName,
      'cityName': instance.cityName,
      'areaName': instance.areaName,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
