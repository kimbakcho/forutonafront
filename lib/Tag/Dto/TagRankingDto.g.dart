// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingDto _$TagRankingDtoFromJson(Map<String, dynamic> json) {
  return TagRankingDto()
    ..ranking = json['ranking'] as int
    ..tagName = json['tagName'] as String
    ..tagPower = (json['tagPower'] as num)?.toDouble()
    ..tagBallPower = json['tagBallPower'] as int;
}

Map<String, dynamic> _$TagRankingDtoToJson(TagRankingDto instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'tagName': instance.tagName,
      'tagPower': instance.tagPower,
      'tagBallPower': instance.tagBallPower,
    };
