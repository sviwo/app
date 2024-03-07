import 'package:json_annotation/json_annotation.dart';

part 'res_data.g.dart';

extension BaseModel on Type {
  fromJson(Map<String, dynamic> data) {}
}

@JsonSerializable()
class ResData<T> {
  dynamic code;
  dynamic msg;
  @JsonKey(ignore: true)
  T? data;
  @JsonKey(ignore: true)
  dynamic originalData;

  ResData({required this.code, required this.msg, this.data, this.originalData});

  factory ResData.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic> json)? fromJsonT) {
    return _$ResDataFromJson2(json, fromJsonT);
  }

  factory ResData.fromJsonList(Map<String, dynamic> json, T Function(List<dynamic> json)? fromJsonT) {
    return _$ResDataFromJson3(json, fromJsonT);
  }
}

ResData<T> _$ResDataFromJson2<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic> json)? fromJsonT,
) {
  var data = json['data'];
  if (data == null || (data is String && (data.isEmpty || data == "null"))) {
    data = null;
  }
  return ResData<T>(
    code: json['code'],
    msg: json['msg'],
    data: data == null || fromJsonT == null ? null : fromJsonT(data),
  );
}

ResData<T> _$ResDataFromJson3<T>(
  Map<String, dynamic> json,
  T Function(List<dynamic> json)? fromJsonT,
) {
  return ResData<T>(
    code: json['code'],
    msg: json['msg'],
    data: json['data'] == null ? null : (fromJsonT == null ? json['data'] : fromJsonT(json['data'])),
  );
}
