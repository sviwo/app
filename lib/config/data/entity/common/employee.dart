import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

/// 员工信息
@JsonSerializable()
class Employee {
  String? userId; // 用户ID
  String? username; // 用户工号
  String? deptId; // 所属部门ID
  String? name; // 用户名称

  Employee({this.userId, this.username, this.deptId, this.name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return _$EmployeeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmployeeToJson(this);
  }
}
