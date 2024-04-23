import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_location_define.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoLocationDefine {
  /// 纬度
  @JsonKey(fromJson: LWObject.dynamicToDouble)
  double? latitude;

  /// 经度
  @JsonKey(fromJson: LWObject.dynamicToDouble)
  double? longitude;

  GeoLocationDefine({
    this.latitude,
    this.longitude,
  });

  factory GeoLocationDefine.fromJson(Map<String, dynamic> srcJson) =>
      _$GeoLocationDefineFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$GeoLocationDefineToJson(this);
  }
}
