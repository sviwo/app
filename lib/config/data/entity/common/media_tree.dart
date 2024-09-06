import 'package:atv/widgetLibrary/basic/lw_object.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_tree.g.dart';

@JsonSerializable(explicitToJson: true)
class MediaTree {
  MediaTree(
      {this.id,
      this.parentId,
      this.displayType,
      this.title,
      this.mediaDesc,
      this.smallImg,
      this.content,
      this.icon,
      this.children});
  String? id;
  String? parentId;

  /// 显示类型：0=直接显示，1=跳转外链
  @JsonKey(fromJson: LWObject.dynamicToInt)
  int? displayType;

  /// 标题
  String? title;

  /// 简介
  String? mediaDesc;

  /// 缩略图
  String? smallImg;

  /// 内容（当显示类型为0的时候content为空，为1的时content为链接地址）
  String? content;

  /// 图表的标记
  String? icon;

  List<MediaTree>? children;

  factory MediaTree.fromJson(Map<String, dynamic> srcJson) =>
      _$MediaTreeFromJson(srcJson);
  Map<String, dynamic> toJson() {
    return _$MediaTreeToJson(this);
  }
}
