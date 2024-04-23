// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_recorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripRecorder _$TripRecorderFromJson(Map<String, dynamic> json) => TripRecorder(
      travelRecordId: LWObject.dynamicToString(json['travelRecordId']),
      deviceId: LWObject.dynamicToString(json['deviceId']),
      startPoint: json['startPoint'] == null
          ? null
          : GeoLocationDefine.fromJson(
              json['startPoint'] as Map<String, dynamic>),
      endPoint: json['endPoint'] == null
          ? null
          : GeoLocationDefine.fromJson(
              json['endPoint'] as Map<String, dynamic>),
      mileageDriven: json['mileageDriven'] == null
          ? '0'
          : LWObject.dynamicToString(json['mileageDriven']),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      avgSpeed: json['avgSpeed'] as String?,
      consumption: json['consumption'] == null
          ? '0'
          : LWObject.dynamicToString(json['consumption']),
    );

Map<String, dynamic> _$TripRecorderToJson(TripRecorder instance) =>
    <String, dynamic>{
      'travelRecordId': instance.travelRecordId,
      'deviceId': instance.deviceId,
      'startPoint': instance.startPoint,
      'endPoint': instance.endPoint,
      'mileageDriven': instance.mileageDriven,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'avgSpeed': instance.avgSpeed,
      'consumption': instance.consumption,
    };
