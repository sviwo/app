import 'package:json_annotation/json_annotation.dart';

part 'inner_user.g.dart';

@JsonSerializable()
class InnerUser {
  bool? innerUser; // 是否内部用户 true:内部用户，false:外部用户
  int? userId; // 用户id

  InnerUser({this.innerUser, this.userId});

  factory InnerUser.fromJson(Map<String, dynamic> json) {
    return _$InnerUserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InnerUserToJson(this);
  }
}
