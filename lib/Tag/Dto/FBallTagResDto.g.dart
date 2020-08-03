// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTagResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTagResDto _$FBallTagResDtoFromJson(Map<String, dynamic> json) {
  return FBallTagResDto()
    ..idx = json['idx'] as int
    ..tagItem = json['tagItem'] as String
    ..ballUuid = json['ballUuid'] == null
        ? null
        : FBallResDto.fromJson(json['ballUuid'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FBallTagResDtoToJson(FBallTagResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'tagItem': instance.tagItem,
      'ballUuid': instance.ballUuid,
    };
