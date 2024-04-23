import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_recorder.g.dart';

/// 删除行程
@JsonSerializable()
class TripRecorder {
  TripRecorder(
      {this.travelRecordId,
      this.deviceId,
      this.startPoint,
      this.endPoint,
      this.mileageDriven = '0',
      this.startTime,
      this.endTime,
      this.avgSpeed,
      this.consumption = '0'});

  /// 里程id
  @JsonKey(fromJson: LWObject.dynamicToString)
  String? travelRecordId;

  /// 车id
  @JsonKey(fromJson: LWObject.dynamicToString)
  String? deviceId;

  /// 起点
  GeoLocationDefine? startPoint;

  String startPointString = '';

  String endPointString = '';

  /// 终点
  GeoLocationDefine? endPoint;

  /// 行驶里程，单位（m）
  @JsonKey(fromJson: LWObject.dynamicToString)
  String? mileageDriven;

  /// 行程开始时间
  String? startTime;

  /// 行程结束时间
  String? endTime;

  /// 平均时速，单位（m）
  String? avgSpeed;

  /// 使用电量
  @JsonKey(fromJson: LWObject.dynamicToString)
  String? consumption;
  factory TripRecorder.fromJson(Map<String, dynamic> json) {
    return _$TripRecorderFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TripRecorderToJson(this);
  }
}
