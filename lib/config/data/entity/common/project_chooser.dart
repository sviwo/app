import 'package:json_annotation/json_annotation.dart';

part 'project_chooser.g.dart';

@JsonSerializable()
class ProjectChooser {
  String? neighborhoodUuid;
  String? companyCode;
  String? buildingUuid; // 楼盘UUID
  String? buildingName; // 楼盘名称
  String? propertyTypeCode; // 物业类型编码
  String? propertyTypeName; // 物业类型名称
  String? projectStatusCode; // 项目状态编码
  String? projectStatusName; // 项目状态名称
  String? projectUuid; // 项目UUID
  String? cityPropertyUuid; // 城市物业uuid
  String? cityPropertyName; // 城市物业名称
  String? currentChargeUserId; // 当前负责人ID
  String? currentChargeUserName;
  String? mergerName; // 合并省市区名称
  String? cityCode; // 城市编码
  String? areaCode; // 大区编码
  String? provinceCode; //省编码
  String? address; // 楼盘地址
  String? lng; // 楼盘经纬度
  String? propertyLng; // 物业经纬度
  int? maxFloor; // 最高楼层数
  String? buildingAcreage; // 建筑面积
  int? coverNum; // 覆盖人数
  int? projectSource; // 项目来源 0-人工报备 1-媒资侧线索 2-经营侧线索
  int? topBuilding; // 是否是TOP楼宇，0：否 ，1 ：是
  int? incompletWorkOrder; // 有无未完成的工单，0：无 ，1 ：有
  int? sspStatus; // ssp提交的状态，0：未关联ssp ，1 ：已关联
  int? expireContract; // 是否到期，0：否 ，1 ：是
  int? cooperationModel; // 合作模式 1:只有租用 2:只有分成 3:两种都有 4:未签约
  num? score; // 分数
  String? gradeName; // 等级名称
  int? isSelected; // 是否被选择中，0表示未选中，可以进行选择；1表示已选中，不能选择

  ProjectChooser({
    this.neighborhoodUuid,
    this.companyCode,
    this.buildingUuid,
    this.buildingName,
    this.propertyTypeCode,
    this.propertyTypeName,
    this.projectStatusCode,
    this.projectStatusName,
    this.projectUuid,
    this.cityPropertyUuid,
    this.cityPropertyName,
    this.currentChargeUserId,
    this.currentChargeUserName,
    this.mergerName,
    this.cityCode,
    this.areaCode,
    this.provinceCode,
    this.address,
    this.lng,
    this.propertyLng,
    this.maxFloor,
    this.buildingAcreage,
    this.coverNum,
    this.projectSource,
    this.topBuilding,
    this.incompletWorkOrder,
    this.sspStatus,
    this.expireContract,
    this.cooperationModel,
    this.score,
    this.gradeName,
    this.isSelected,
  });

  factory ProjectChooser.fromJson(Map<String, dynamic> json) {
    return _$ProjectChooserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProjectChooserToJson(this);
  }
}

enum ProjectFuncType {
  preDismantle(code: 'dismantlePoint'), // 预拆除
  knowledge(code: 'know'), // 潮知识-楼盘推荐
  orderInstallScreen(code: 'screen-install'), // 安装工单-智慧屏
  orderInstallFrame(code: 'frame-install'), // 安装工单-电梯海报
  orderDismantleScreen(code: 'screen-dismantle'), // 拆除工单-智慧屏
  orderDismantleFrame(code: 'frame-dismantle'), // 拆除工单-电梯海报
  orderVolume(code: 'volume-create'), // 音量工单
  projectFollow(code: 'follow'); // 项目跟进

  final String code;

  const ProjectFuncType({required this.code});
}
