// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingResDto _$TagRankingResDtoFromJson(Map<String, dynamic> json) {
  return TagRankingResDto()
    ..tagName = json['tagName'] as String
    ..tagPower = (json['tagPower'] as num)?.toDouble();
}

Map<String, dynamic> _$TagRankingResDtoToJson(TagRankingResDto instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'tagPower': instance.tagPower,
    };
