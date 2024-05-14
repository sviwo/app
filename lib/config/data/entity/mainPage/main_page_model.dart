import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:json_annotation/json_annotation.dart';

import 'geo_location_define.dart';

part 'main_page_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomePageModel {
  /// 车辆昵称
  String? nickname;

  /// 剩余里程
  int remainMile;

  /// 电池电量（%）
  int electricity;

  /// 电池状态：0=放电，1=充电
  @JsonKey(fromJson: LWObject.dynamicToBool, defaultValue: false)
  bool? batteryStatus;

  /// 锁车状态：0=关机，1=开机
  @JsonKey(fromJson: LWObject.dynamicToBool, defaultValue: false)
  bool? lockedStatus;

  /// 地理位置
  GeoLocationDefine? geoLocation;

  /// 是否有车：false=没有，true=有
  @JsonKey(fromJson: LWObject.dynamicToBool, defaultValue: false)
  bool? isHavingCar;

  /// 设备用户类型：0=车主，1=从用户
  int? userDeviceType;

  /// 认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
  int? authStatus;

  /// 手机钥匙开关：0=关，1=开
  @JsonKey(fromJson: LWObject.dynamicToBool)
  bool? mobileKey;

  /// 速度限制开关：false=关，true=开
  @JsonKey(fromJson: LWObject.dynamicToBool)
  bool? speedLimit;

  /// 驾驶模式：0=ECO模式，1=运动模式，2=狂暴模式
  int? drivingMode;

  /// 动能回收类型：0=无，1=中，2=强
  int? energyRecovery;

  /// 新版本信息
  @JsonKey(defaultValue: [])
  List<HomePageVersion> version;

  /// 服务电话号码
  String? servicePhone;

  /// 蓝牙mac地址
  String? bluetoothAddress;

  /// 蓝牙握手秘钥
  String? bluetoothSecrectKey;

  HomePageModel(
      {this.nickname,
      this.remainMile = 0,
      this.electricity = 0,
      this.batteryStatus = false,
      this.lockedStatus = false,
      this.geoLocation,
      this.isHavingCar = false,
      this.userDeviceType,
      this.authStatus,
      this.mobileKey,
      this.speedLimit,
      this.drivingMode,
      this.energyRecovery,
      this.version = const [],
      this.servicePhone,
      this.bluetoothAddress,
      this.bluetoothSecrectKey});

  factory HomePageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HomePageModelFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$HomePageModelToJson(this);
  }
}

@JsonSerializable()
class HomePageVersion {
  String? versionId;

  /// 版本编码：app显示当前版本号使用，例如：V1.1.1
  String? versionCode;

  /// 版本类型：0=APP更新，1=固件升级
  int? versionType;

  /// 版本更新类型：0=弱更新，1=强更新
  int? versionUpdateType;

  /// 版本链接
  String? versionUrl;

  /// 版本描述，用于app显示的新版本信息
  String? versionDesc;

  HomePageVersion({
    this.versionId,
    this.versionCode,
    this.versionType,
    this.versionUpdateType,
    this.versionUrl,
    this.versionDesc,
  });

  factory HomePageVersion.fromJson(Map<String, dynamic> srcJson) =>
      _$HomePageVersionFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$HomePageVersionToJson(this);
  }
}
