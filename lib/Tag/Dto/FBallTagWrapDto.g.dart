// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTagWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTagWrapDto _$FBallTagWrapDtoFromJson(Map<String, dynamic> json) {
  return FBallTagWrapDto()
    ..totalCount = json['totalCount'] as int
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null
            ? null
            : FBallTagResDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallTagWrapDtoToJson(FBallTagWrapDto instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'tags': instance.tags,
    };
