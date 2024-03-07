import 'package:json_annotation/json_annotation.dart';

part 'req_project_chooser.g.dart';

@JsonSerializable()
class ReqProjectChooser {
  int? pageNum;
  int? pageSize;

  String? deptId; // 部门
  int? cooperationModel; // 合作模式 1:只有租用 2:只有分成 3:两种都有 4:未签约
  String? buildingName; // 楼盘名称
  List<String>? propertyTypeCodeList; // 物业类型
  int? sspStatus; // ssp提交的状态，0：未关联ssp ，1 ：已关联
  int? expireContract; // 是否到期，0：否 ，1 ：是
  int? topBuilding; // 是否是TOP楼宇，0：否 ，1 ：是
  int? incompletWorkOrder; // 有无未完成的故障工单，0：无 ，1 ：有
  List<String>? cityCodeList; // 城市CODE
  List<String>? projectStatusCodeList; // 项目状态
  List<String>? currentChargeUserIdList; // 当前负责人集合

  ReqProjectChooser({
    this.pageNum,
    this.pageSize,
    this.deptId,
    this.cooperationModel,
    this.buildingName,
    this.propertyTypeCodeList,
    this.sspStatus,
    this.expireContract,
    this.topBuilding,
    this.incompletWorkOrder,
    this.cityCodeList,
    this.projectStatusCodeList,
    this.currentChargeUserIdList,
  });

  factory ReqProjectChooser.fromJson(Map<String, dynamic> json) {
    return _$ReqProjectChooserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReqProjectChooserToJson(this);
  }
}
