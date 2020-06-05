// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BallSearchBarHistoryDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BallSearchBarHistoryDto _$BallSearchBarHistoryDtoFromJson(
    Map<String, dynamic> json) {
  return BallSearchBarHistoryDto(
    json['searchText'] as String,
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
  );
}

Map<String, dynamic> _$BallSearchBarHistoryDtoToJson(
        BallSearchBarHistoryDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'searchTime': instance.searchTime?.toIso8601String(),
    };
