// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTag _$FBallTagFromJson(Map<String, dynamic> json) {
  return FBallTag(
    ballUuid: json['ballUuid'] as String,
    tagItem: json['tagItem'] as String,
  );
}

Map<String, dynamic> _$FBallTagToJson(FBallTag instance) => <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'tagItem': instance.tagItem,
    };
