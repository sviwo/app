
import 'package:json_annotation/json_annotation.dart';

part 'media_content.g.dart';

@JsonSerializable()
class MediaContent {
  MediaContent({this.content});

  /// 文本内容
  String? content;

  factory MediaContent.fromJson(Map<String, dynamic> srcJson) =>
      _$MediaContentFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$MediaContentToJson(this);
  }
}
