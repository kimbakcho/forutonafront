// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingReqDto _$TagRankingReqDtoFromJson(Map<String, dynamic> json) {
  return TagRankingReqDto(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['limit'] as int,
  );
}

Map<String, dynamic> _$TagRankingReqDtoToJson(TagRankingReqDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'limit': instance.limit,
    };
