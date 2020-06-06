// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingWrapDto _$TagRankingWrapDtoFromJson(Map<String, dynamic> json) {
  return TagRankingWrapDto(
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : TagRankingDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TagRankingWrapDtoToJson(TagRankingWrapDto instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
