// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingDto _$TagRankingDtoFromJson(Map<String, dynamic> json) {
  return TagRankingDto(
    json['ranking'] as int,
    json['tagName'] as String,
    (json['tagPower'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TagRankingDtoToJson(TagRankingDto instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'tagName': instance.tagName,
      'tagPower': instance.tagPower,
    };
