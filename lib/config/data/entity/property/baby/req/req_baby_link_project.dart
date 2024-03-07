import 'package:json_annotation/json_annotation.dart';

part 'req_baby_link_project.g.dart';

@JsonSerializable()
class ReqBabyLinkProject {
  String? accountCode; // 账户code
  List<String>? buildingUuidList; // 待关联项目UUID

  ReqBabyLinkProject({
    this.accountCode,
    this.buildingUuidList,
  });

  Map<String, dynamic> toJson() {
    return _$ReqBabyLinkProjectToJson(this);
  }
}
