// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaTree _$MediaTreeFromJson(Map<String, dynamic> json) => MediaTree(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      displayType: LWObject.dynamicToInt(json['displayType']),
      title: json['title'] as String?,
      mediaDesc: json['mediaDesc'] as String?,
      smallImg: json['smallImg'] as String?,
      content: json['content'] as String?,
      icon: json['icon'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => MediaTree.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaTreeToJson(MediaTree instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'displayType': instance.displayType,
      'title': instance.title,
      'mediaDesc': instance.mediaDesc,
      'smallImg': instance.smallImg,
      'content': instance.content,
      'icon': instance.icon,
      'children': instance.children?.map((e) => e.toJson()).toList(),
    };
