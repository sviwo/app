import 'package:json_annotation/json_annotation.dart';

part 'user_real_name_info.g.dart';

/// 用户实名信息
@JsonSerializable()
class UserRealNameInfo {
  UserRealNameInfo({
    this.authFirstName,
    this.authLastName,
    this.certificateFrontImg,
    this.certificateBackImg,
    this.authStatus = 0,
    this.authFailReason,
    this.authTime,
    this.verifyTime,
  });

  /// 姓
  String? authFirstName;

  /// 名
  String? authLastName;

  /// 证件正面照片
  String? certificateFrontImg;

  /// 证件背面照片
  String? certificateBackImg;

  /// 认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
  @JsonKey(defaultValue: 0)
  int authStatus;

  /// 认证失败原因
  String? authFailReason;

  /// 认证时间
  String? authTime;

  /// 审核时间
  String? verifyTime;
  factory UserRealNameInfo.fromJson(Map<String, dynamic> json) {
    return _$UserRealNameInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserRealNameInfoToJson(this);
  }
}
