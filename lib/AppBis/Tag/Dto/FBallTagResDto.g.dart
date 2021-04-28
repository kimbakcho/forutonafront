// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTagResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTagResDto _$FBallTagResDtoFromJson(Map<String, dynamic> json) {
  return FBallTagResDto()
    ..idx = json['idx'] as int?
    ..tagItem = json['tagItem'] as String?
    ..ballUuid = json['ballUuid'] as String?
    ..tagIndex = json['tagIndex'] as int?;
}

Map<String, dynamic> _$FBallTagResDtoToJson(FBallTagResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'tagItem': instance.tagItem,
      'ballUuid': instance.ballUuid,
      'tagIndex': instance.tagIndex,
    };
