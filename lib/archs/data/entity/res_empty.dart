import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../utils/log_util.dart';
import 'res_data.dart';

part 'res_empty.g.dart';

@JsonSerializable()
class ResEmpty extends ResData {
  dynamic code;
  @JsonKey(defaultValue: '')
  dynamic msg = '';

  ResEmpty({required this.code, required this.msg}) : super(code: code, msg: msg, data: null);

  factory ResEmpty.fromJson(Map<String, dynamic> json) {
    json.remove('data');
    LogUtil.d('ResEmpty: ' + jsonEncode(json));
    return _$ResEmptyFromJson(json);
  }
}
