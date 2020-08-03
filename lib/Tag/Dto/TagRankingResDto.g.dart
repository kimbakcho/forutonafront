// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingResDto _$TagRankingResDtoFromJson(Map<String, dynamic> json) {
  return TagRankingResDto()
    ..ranking = json['ranking'] as int
    ..tagName = json['tagName'] as String
    ..tagPower = (json['tagPower'] as num)?.toDouble()
    ..tagBallPower = json['tagBallPower'] as int;
}

Map<String, dynamic> _$TagRankingResDtoToJson(TagRankingResDto instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'tagName': instance.tagName,
      'tagPower': instance.tagPower,
      'tagBallPower': instance.tagBallPower,
    };
