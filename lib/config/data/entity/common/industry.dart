import 'package:json_annotation/json_annotation.dart';

part 'industry.g.dart';

@JsonSerializable()
class Industry {
  String? delFlg;
  String? industryCode;
  String? industryName;
  String? industryLevel;
  String? parentCode;
  List<Industry>? children;

  Industry({
    this.delFlg,
    this.industryCode,
    this.industryName,
    this.industryLevel,
    this.parentCode,
    this.children,
  });

  factory Industry.fromJson(Map<String, dynamic> json) {
    return _$IndustryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IndustryToJson(this);
  }
}
