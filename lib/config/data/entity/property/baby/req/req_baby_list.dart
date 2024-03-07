import 'package:json_annotation/json_annotation.dart';

part 'req_baby_list.g.dart';

@JsonSerializable()
class ReqBabyList {
  int? pageIndex;
  int? pageSize;
  String? rentCode;
  String? cityCode;
  String? accountName;
  String? currentChargeUserId;

  ReqBabyList({
    this.pageIndex,
    this.pageSize,
    this.rentCode,
    this.cityCode,
    this.accountName,
    this.currentChargeUserId,
  });

  Map<String, dynamic> toJson() {
    return _$ReqBabyListToJson(this);
  }
}
