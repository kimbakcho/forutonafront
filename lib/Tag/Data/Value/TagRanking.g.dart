// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRanking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRanking _$TagRankingFromJson(Map<String, dynamic> json) {
  return TagRanking(
    json['ranking'] as int,
    json['tagName'] as String,
    (json['tagPower'] as num)?.toDouble(),
  )..tagBallPower = json['tagBallPower'] as int;
}

Map<String, dynamic> _$TagRankingToJson(TagRanking instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'tagName': instance.tagName,
      'tagPower': instance.tagPower,
      'tagBallPower': instance.tagBallPower,
    };
