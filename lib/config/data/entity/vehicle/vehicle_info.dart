import 'dart:convert';

import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_info.g.dart';

/// 车辆信息
@JsonSerializable(explicitToJson: true)
class VehicleInfo {
  VehicleInfo(
      {this.deviceId,
      this.nickname,
      this.deviceName,
      this.mobileKey,
      this.speedLimit,
      this.drivingMode,
      this.energyRecovery,
      this.userDeviceType,
      this.activateTime,
      this.warrantyTime,
      this.mileage,
      this.topSpeedHour,
      this.userCarKeyList});

  String? deviceId;

  /// 产品昵称（目前只有ATV，则等同于车辆昵称）
  String? nickname;

  /// 设备名称（同于车架号）
  String? deviceName;

  /// 手机钥匙开关：0=关，1=开
  @JsonKey(fromJson: LWObject.dynamicToBool)
  bool? mobileKey;

  /// 速度限制开关：0=关，1=开
  @JsonKey(fromJson: LWObject.dynamicToBool)
  bool? speedLimit;

  /// 驾驶模式：0=ECO模式，1=运动模式，2=狂暴模式
  int? drivingMode;

  /// 动能回收类型：0=无，1=中，2=强
  int? energyRecovery;

  /// 设备用户类型：0=主用户，1=从用户
  int? userDeviceType;

  /// 激活时间
  String? activateTime;

  /// 保修日期
  String? warrantyTime;

  /// 行驶里程（km）
  @JsonKey(fromJson: LWObject.dynamicToString)
  String? mileage;

  /// 最高时速
  int? topSpeedHour;

  /// 车辆钥匙组
  List<VehicleInfoKeyInfo>? userCarKeyList;

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return _$VehicleInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehicleInfoToJson(this);
  }
}

@JsonSerializable()
class VehicleInfoKeyInfo {
  VehicleInfoKeyInfo({
    this.userDeviceId,
    this.name,
    this.headImg,
  });
  String? userDeviceId;
  String? name;
  String? headImg;
  factory VehicleInfoKeyInfo.fromJson(Map<String, dynamic> json) {
    return _$VehicleInfoKeyInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehicleInfoKeyInfoToJson(this);
  }
}
