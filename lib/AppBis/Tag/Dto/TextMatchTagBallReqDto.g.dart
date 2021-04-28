// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TextMatchTagBallReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMatchTagBallReqDto _$TextMatchTagBallReqDtoFromJson(
    Map<String, dynamic> json) {
  return TextMatchTagBallReqDto(
    searchText: json['searchText'] as String?,
    mapCenterLatitude: (json['mapCenterLatitude'] as num?)?.toDouble(),
    mapCenterLongitude: (json['mapCenterLongitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$TextMatchTagBallReqDtoToJson(
        TextMatchTagBallReqDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'mapCenterLatitude': instance.mapCenterLatitude,
      'mapCenterLongitude': instance.mapCenterLongitude,
    };
