import 'dart:convert';

import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResList<T> {
  @JsonKey(fromJson: LWObject.dynamicToInt, defaultValue: 0)
  int total;
  @JsonKey(
    includeFromJson: false,
  )
  List<T>? list;

  ResList({required this.total, this.list});

  factory ResList.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJsonT) {
    ResList<T> item = _$ResListFromJson2(json, fromJsonT);
    return item;
  }
}

ResList<T> _$ResListFromJson2<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic> json) fromJsonT,
) {
  var total = json['total'].toString();

  return ResList<T>(
    total: int.tryParse(total) ?? 0,
    list: (int.tryParse(total) ?? 0) <= 0
        ? null
        : (json['result'] as List).map((e) => fromJsonT(e)).toList(),
  );
}

enum ListLabels { list, records }
