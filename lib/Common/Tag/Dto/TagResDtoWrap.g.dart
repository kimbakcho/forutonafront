// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagResDtoWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagResDtoWrap _$TagResDtoWrapFromJson(Map<String, dynamic> json) {
  return TagResDtoWrap()
    ..totalCount = json['totalCount'] as int
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagResDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TagResDtoWrapToJson(TagResDtoWrap instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'tags': instance.tags,
    };
