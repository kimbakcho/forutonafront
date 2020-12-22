// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingFromBallInfluencePowerReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingFromBallInfluencePowerReqDto
    _$TagRankingFromBallInfluencePowerReqDtoFromJson(
        Map<String, dynamic> json) {
  return TagRankingFromBallInfluencePowerReqDto(
    mapCenterLatitude: (json['mapCenterLatitude'] as num)?.toDouble(),
    mapCenterLongitude: (json['mapCenterLongitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TagRankingFromBallInfluencePowerReqDtoToJson(
        TagRankingFromBallInfluencePowerReqDto instance) =>
    <String, dynamic>{
      'mapCenterLatitude': instance.mapCenterLatitude,
      'mapCenterLongitude': instance.mapCenterLongitude,
    };
