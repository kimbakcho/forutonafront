// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagRankingFromTextReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagRankingFromTextReqDto _$TagRankingFromTextReqDtoFromJson(
    Map<String, dynamic> json) {
  return TagRankingFromTextReqDto()
    ..searchTagText = json['searchTagText'] as String
    ..mapCenterLatitude = (json['mapCenterLatitude'] as num)?.toDouble()
    ..mapCenterLongitude = (json['mapCenterLongitude'] as num)?.toDouble();
}

Map<String, dynamic> _$TagRankingFromTextReqDtoToJson(
        TagRankingFromTextReqDto instance) =>
    <String, dynamic>{
      'searchTagText': instance.searchTagText,
      'mapCenterLatitude': instance.mapCenterLatitude,
      'mapCenterLongitude': instance.mapCenterLongitude,
    };
