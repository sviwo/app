// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_project_chooser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqProjectChooser _$ReqProjectChooserFromJson(Map<String, dynamic> json) =>
    ReqProjectChooser(
      pageNum: json['pageNum'] as int?,
      pageSize: json['pageSize'] as int?,
      deptId: json['deptId'] as String?,
      cooperationModel: json['cooperationModel'] as int?,
      buildingName: json['buildingName'] as String?,
      propertyTypeCodeList: (json['propertyTypeCodeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sspStatus: json['sspStatus'] as int?,
      expireContract: json['expireContract'] as int?,
      topBuilding: json['topBuilding'] as int?,
      incompletWorkOrder: json['incompletWorkOrder'] as int?,
      cityCodeList: (json['cityCodeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      projectStatusCodeList: (json['projectStatusCodeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      currentChargeUserIdList:
          (json['currentChargeUserIdList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$ReqProjectChooserToJson(ReqProjectChooser instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'deptId': instance.deptId,
      'cooperationModel': instance.cooperationModel,
      'buildingName': instance.buildingName,
      'propertyTypeCodeList': instance.propertyTypeCodeList,
      'sspStatus': instance.sspStatus,
      'expireContract': instance.expireContract,
      'topBuilding': instance.topBuilding,
      'incompletWorkOrder': instance.incompletWorkOrder,
      'cityCodeList': instance.cityCodeList,
      'projectStatusCodeList': instance.projectStatusCodeList,
      'currentChargeUserIdList': instance.currentChargeUserIdList,
    };
