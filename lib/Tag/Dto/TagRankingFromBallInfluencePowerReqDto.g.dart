// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingFromBallInfluencePowerReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingFromBallInfluencePowerReqDto
    _$TagRankingFromBallInfluencePowerReqDtoFromJson(
        Map<String, dynamic> json) {
  return TagRankingFromBallInfluencePowerReqDto(
    limit: json['limit'] as int,
  )
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble();
}

Map<String, dynamic> _$TagRankingFromBallInfluencePowerReqDtoToJson(
        TagRankingFromBallInfluencePowerReqDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'limit': instance.limit,
    };
