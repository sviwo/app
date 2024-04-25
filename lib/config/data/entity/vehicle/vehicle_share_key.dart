import 'package:json_annotation/json_annotation.dart';

part 'vehicle_share_key.g.dart';

@JsonSerializable()
class VehicleShareKey {
  /// 车钥匙（有效期一小时）
  String? carKey;

  VehicleShareKey({this.carKey});

  factory VehicleShareKey.fromJson(Map<String, dynamic> srcJson) =>
      _$VehicleShareKeyFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$VehicleShareKeyToJson(this);
  }
}
