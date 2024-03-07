import 'package:json_annotation/json_annotation.dart';

part 'req_baby_create.g.dart';

@JsonSerializable()
class ReqBabyCreate {
  String? rentCode;
  String? accountName;
  String? parentAccountCode; // 创建子账户时传入
  String? userName;
  String? phone;
  String? password;
  String? percentage;
  List<String>? buildingUuidList;

  ReqBabyCreate({
    this.rentCode,
    this.accountName,
    this.parentAccountCode,
    this.userName,
    this.phone,
    this.password,
    this.percentage,
    this.buildingUuidList,
  });

  Map<String, dynamic> toJson() {
    return _$ReqBabyCreateToJson(this);
  }
}
