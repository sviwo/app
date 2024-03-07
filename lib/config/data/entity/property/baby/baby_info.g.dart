// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BabyInfo _$BabyInfoFromJson(Map<String, dynamic> json) => BabyInfo(
      accountId: json['accountId'] as String?,
      accountName: json['accountName'] as String?,
      userName: json['userName'] as String?,
      bypassAccountNum: json['bypassAccountNum'] as int?,
      accountType: json['accountType'] as int?,
      accountCode: json['accountCode'] as String?,
      fullAccountCode: json['fullAccountCode'] as String?,
      currentChargeUserId: json['currentChargeUserId'] as String?,
      currentChargeUserName: json['currentChargeUserName'] as String?,
      projectNum: json['projectNum'] as int?,
      parentCodeAccount: json['parentCodeAccount'] as String?,
      phone: json['phone'] as String?,
      isSpecialAccount: json['isSpecialAccount'] as bool?,
      percentage: json['percentage'] as String?,
      principal: json['principal'] as String?,
      parentAccountName: json['parentAccountName'] as String?,
      parentAccount: json['parentAccount'] as String?,
      accountList: (json['accountList'] as List<dynamic>?)
          ?.map((e) => BabyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectList: (json['projectList'] as List<dynamic>?)
          ?.map((e) => BabyProject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BabyInfoToJson(BabyInfo instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'accountName': instance.accountName,
      'userName': instance.userName,
      'bypassAccountNum': instance.bypassAccountNum,
      'accountType': instance.accountType,
      'accountCode': instance.accountCode,
      'fullAccountCode': instance.fullAccountCode,
      'currentChargeUserId': instance.currentChargeUserId,
      'currentChargeUserName': instance.currentChargeUserName,
      'projectNum': instance.projectNum,
      'parentCodeAccount': instance.parentCodeAccount,
      'phone': instance.phone,
      'isSpecialAccount': instance.isSpecialAccount,
      'percentage': instance.percentage,
      'principal': instance.principal,
      'parentAccountName': instance.parentAccountName,
      'parentAccount': instance.parentAccount,
      'accountList': instance.accountList?.map((e) => e.toJson()).toList(),
      'projectList': instance.projectList?.map((e) => e.toJson()).toList(),
    };

BabyProject _$BabyProjectFromJson(Map<String, dynamic> json) => BabyProject(
      buildingName: json['buildingName'] as String?,
      buildingUuid: json['buildingUuid'] as String?,
      mergerName: json['mergerName'] as String?,
      companyName: json['companyName'] as String?,
      companyCode: json['companyCode'] as String?,
      cityCode: json['cityCode'] as String?,
      propertyTypeCode: json['propertyTypeCode'] as String?,
      linkType: json['linkType'] as String?,
      currentChargeUserName: json['currentChargeUserName'] as String?,
      fullAccountCode: json['fullAccountCode'] as String?,
      accountCode: json['accountCode'] as String?,
      enableShowScore: json['enableShowScore'] as int?,
      showDetail: json['showDetail'] as bool?,
    );

Map<String, dynamic> _$BabyProjectToJson(BabyProject instance) =>
    <String, dynamic>{
      'buildingName': instance.buildingName,
      'buildingUuid': instance.buildingUuid,
      'mergerName': instance.mergerName,
      'companyName': instance.companyName,
      'companyCode': instance.companyCode,
      'cityCode': instance.cityCode,
      'propertyTypeCode': instance.propertyTypeCode,
      'linkType': instance.linkType,
      'currentChargeUserName': instance.currentChargeUserName,
      'fullAccountCode': instance.fullAccountCode,
      'accountCode': instance.accountCode,
      'enableShowScore': instance.enableShowScore,
      'showDetail': instance.showDetail,
    };
