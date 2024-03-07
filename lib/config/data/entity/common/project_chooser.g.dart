// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_chooser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectChooser _$ProjectChooserFromJson(Map<String, dynamic> json) =>
    ProjectChooser(
      neighborhoodUuid: json['neighborhoodUuid'] as String?,
      companyCode: json['companyCode'] as String?,
      buildingUuid: json['buildingUuid'] as String?,
      buildingName: json['buildingName'] as String?,
      propertyTypeCode: json['propertyTypeCode'] as String?,
      propertyTypeName: json['propertyTypeName'] as String?,
      projectStatusCode: json['projectStatusCode'] as String?,
      projectStatusName: json['projectStatusName'] as String?,
      projectUuid: json['projectUuid'] as String?,
      cityPropertyUuid: json['cityPropertyUuid'] as String?,
      cityPropertyName: json['cityPropertyName'] as String?,
      currentChargeUserId: json['currentChargeUserId'] as String?,
      currentChargeUserName: json['currentChargeUserName'] as String?,
      mergerName: json['mergerName'] as String?,
      cityCode: json['cityCode'] as String?,
      areaCode: json['areaCode'] as String?,
      provinceCode: json['provinceCode'] as String?,
      address: json['address'] as String?,
      lng: json['lng'] as String?,
      propertyLng: json['propertyLng'] as String?,
      maxFloor: json['maxFloor'] as int?,
      buildingAcreage: json['buildingAcreage'] as String?,
      coverNum: json['coverNum'] as int?,
      projectSource: json['projectSource'] as int?,
      topBuilding: json['topBuilding'] as int?,
      incompletWorkOrder: json['incompletWorkOrder'] as int?,
      sspStatus: json['sspStatus'] as int?,
      expireContract: json['expireContract'] as int?,
      cooperationModel: json['cooperationModel'] as int?,
      score: json['score'] as num?,
      gradeName: json['gradeName'] as String?,
      isSelected: json['isSelected'] as int?,
    );

Map<String, dynamic> _$ProjectChooserToJson(ProjectChooser instance) =>
    <String, dynamic>{
      'neighborhoodUuid': instance.neighborhoodUuid,
      'companyCode': instance.companyCode,
      'buildingUuid': instance.buildingUuid,
      'buildingName': instance.buildingName,
      'propertyTypeCode': instance.propertyTypeCode,
      'propertyTypeName': instance.propertyTypeName,
      'projectStatusCode': instance.projectStatusCode,
      'projectStatusName': instance.projectStatusName,
      'projectUuid': instance.projectUuid,
      'cityPropertyUuid': instance.cityPropertyUuid,
      'cityPropertyName': instance.cityPropertyName,
      'currentChargeUserId': instance.currentChargeUserId,
      'currentChargeUserName': instance.currentChargeUserName,
      'mergerName': instance.mergerName,
      'cityCode': instance.cityCode,
      'areaCode': instance.areaCode,
      'provinceCode': instance.provinceCode,
      'address': instance.address,
      'lng': instance.lng,
      'propertyLng': instance.propertyLng,
      'maxFloor': instance.maxFloor,
      'buildingAcreage': instance.buildingAcreage,
      'coverNum': instance.coverNum,
      'projectSource': instance.projectSource,
      'topBuilding': instance.topBuilding,
      'incompletWorkOrder': instance.incompletWorkOrder,
      'sspStatus': instance.sspStatus,
      'expireContract': instance.expireContract,
      'cooperationModel': instance.cooperationModel,
      'score': instance.score,
      'gradeName': instance.gradeName,
      'isSelected': instance.isSelected,
    };
