// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      deptId: json['deptId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'deptId': instance.deptId,
      'name': instance.name,
    };
