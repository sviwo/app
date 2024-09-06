import 'package:json_annotation/json_annotation.dart';

part 'user_basic_info.g.dart';

/// 用户基本信息
@JsonSerializable()
class UserBasicInfo {
  UserBasicInfo(
      {this.username,
      this.firstName,
      this.lastName,
      this.mobilePhone,
      this.userAddress,
      this.headImg,
      this.nickname,
      this.deviceName,
      this.mileage,
      this.authStatus});

  /// 用户名
  String? username;

  /// 姓
  String? firstName;

  /// 名
  String? lastName;

  /// 手机号
  String? mobilePhone;

  /// 用户地址
  String? userAddress;

  /// 头像url
  String? headImg;

  /// 车辆昵称
  String? nickname;

  /// 车架号
  String? deviceName;

  /// 行驶里程(km)
  @JsonKey(defaultValue: 0)
  int? mileage;

  /// 认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
  @JsonKey(defaultValue: 0)
  int? authStatus;

  factory UserBasicInfo.fromJson(Map<String, dynamic> json) {
    return _$UserBasicInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserBasicInfoToJson(this);
  }
}
