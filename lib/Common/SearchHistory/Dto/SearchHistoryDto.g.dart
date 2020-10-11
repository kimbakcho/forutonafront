// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchHistoryDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistoryDto _$SearchHistoryDtoFromJson(Map<String, dynamic> json) {
  return SearchHistoryDto(
    searchText: json['searchText'] as String,
    searchTime: json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
  );
}

Map<String, dynamic> _$SearchHistoryDtoToJson(SearchHistoryDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'searchTime': instance.searchTime?.toIso8601String(),
    };
