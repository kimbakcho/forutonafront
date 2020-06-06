// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTagWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTagWrap _$FBallTagWrapFromJson(Map<String, dynamic> json) {
  return FBallTagWrap()
    ..totalCount = json['totalCount'] as int
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : FBallTag.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallTagWrapToJson(FBallTagWrap instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'tags': instance.tags,
    };
