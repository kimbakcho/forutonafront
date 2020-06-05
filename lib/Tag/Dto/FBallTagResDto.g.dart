// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTagResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTagResDto _$FBallTagResDtoFromJson(Map<String, dynamic> json) {
  return FBallTagResDto()
    ..ballUuid = json['ballUuid'] as String
    ..tagItem = json['tagItem'] as String;
}

Map<String, dynamic> _$FBallTagResDtoToJson(FBallTagResDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'tagItem': instance.tagItem,
    };
