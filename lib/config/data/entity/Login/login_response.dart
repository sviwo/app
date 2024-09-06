import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

/// 登录返回信息
@JsonSerializable()
class LoginResponse {
  LoginResponse({
    this.Authorization,
    this.Publickey,
  });
  String? Authorization;
  String? Publickey;
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }
}
