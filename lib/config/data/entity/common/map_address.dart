import 'package:json_annotation/json_annotation.dart';

part 'map_address.g.dart';

@JsonSerializable()
class MapAddress {
  String? name;
  String? address;
  String? provinceName;
  String? cityName;
  String? areaName;
  num? longitude;
  num? latitude;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;

  MapAddress({
    this.name,
    this.address,
    this.provinceName,
    this.cityName,
    this.areaName,
    this.longitude,
    this.latitude,
  });

  factory MapAddress.fromJson(Map<String, dynamic> json) {
    return _$MapAddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MapAddressToJson(this);
  }
}
