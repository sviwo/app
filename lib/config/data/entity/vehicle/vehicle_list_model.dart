import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_list_model.g.dart';

@JsonSerializable()
class VehicleListModel {
  String? deviceId;

  /// 产品昵称（目前只有ATV，则等同于车辆昵称）
  String? nickname;

  /// 行驶里程（km）
  @JsonKey(fromJson: LWObject.dynamicToString)
  String? mileage;

  /// 设备名称（同于车架号）
  String? deviceName;

  /// 是否选定：false=未选定，true=已选定
  @JsonKey(fromJson: LWObject.dynamicToBool)
  bool? isSelect;

  /// 设备用户类型：0=车主，1=从用户
  @JsonKey(fromJson: LWObject.dynamicToInt)
  int? userDeviceType;

  VehicleListModel(
      {this.deviceId,
      this.nickname,
      this.mileage,
      this.deviceName,
      this.isSelect,
      this.userDeviceType});

  factory VehicleListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VehicleListModelFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$VehicleListModelToJson(this);
  }
}
