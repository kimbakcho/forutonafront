// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingFromBallInfluencePowerReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingFromBallInfluencePowerReqDto
    _$TagRankingFromBallInfluencePowerReqDtoFromJson(
        Map<String, dynamic> json) {
  return TagRankingFromBallInfluencePowerReqDto(
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    limit: json['limit'] as int,
  );
}

Map<String, dynamic> _$TagRankingFromBallInfluencePowerReqDtoToJson(
        TagRankingFromBallInfluencePowerReqDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'limit': instance.limit,
    };
