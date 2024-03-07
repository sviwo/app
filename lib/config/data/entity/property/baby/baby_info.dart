import 'package:json_annotation/json_annotation.dart';

part 'baby_info.g.dart';

@JsonSerializable()
class BabyInfo {
  ///列表
  String? accountId; // 账户ID
  String? accountName; // 账户名称
  String? userName; // 用户登录ID
  int? bypassAccountNum; // 子账户数量（含特殊账户）
  int? accountType; // 1-主账户 2-子账号
  String? accountCode; // 账户code
  String? fullAccountCode; // 父账户code+子账户code
  String? currentChargeUserId;
  String? currentChargeUserName;
  int? projectNum; // 关联项目数
  String? parentCodeAccount; // 父账号code

  ///详情独有
  String? phone;
  bool? isSpecialAccount; // 是否特殊账户（带项目分成比例）
  String? percentage; // 项目分成比例
  String? principal; // 负责人
  String? parentAccountName; // 父账户名称
  String? parentAccount; // 父账户code
  List<BabyInfo>? accountList; // 子账户列表
  List<BabyProject>? projectList; // 关联项目列表

  BabyInfo({
    this.accountId,
    this.accountName,
    this.userName,
    this.bypassAccountNum,
    this.accountType,
    this.accountCode,
    this.fullAccountCode,
    this.currentChargeUserId,
    this.currentChargeUserName,
    this.projectNum,
    this.parentCodeAccount,

    //
    this.phone,
    this.isSpecialAccount,
    this.percentage,
    this.principal,
    this.parentAccountName,
    this.parentAccount,
    this.accountList,
    this.projectList,
  });

  factory BabyInfo.fromJson(Map<String, dynamic> json) {
    return _$BabyInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BabyInfoToJson(this);
  }
}

@JsonSerializable()
class BabyProject {
  String? buildingName;
  String? buildingUuid;
  String? mergerName;
  String? companyName;
  String? companyCode;
  String? cityCode;
  String? propertyTypeCode;
  String? linkType; // 1-自主关联 2-特殊关联 5-子账号关联
  String? currentChargeUserName;
  String? fullAccountCode;
  String? accountCode;
  int? enableShowScore;
  bool? showDetail; // 是否可以查看广告明细

  BabyProject({
    this.buildingName,
    this.buildingUuid,
    this.mergerName,
    this.companyName,
    this.companyCode,
    this.cityCode,
    this.propertyTypeCode,
    this.linkType,
    this.currentChargeUserName,
    this.fullAccountCode,
    this.accountCode,
    this.enableShowScore,
    this.showDetail,
  });

  factory BabyProject.fromJson(Map<String, dynamic> json) {
    return _$BabyProjectFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BabyProjectToJson(this);
  }
}
