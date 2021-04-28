// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BallSearchBarHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BallSearchBarHistory _$BallSearchBarHistoryFromJson(Map<String, dynamic> json) {
  return BallSearchBarHistory(
    searchText: json['searchText'] as String?,
    searchTime: json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
  );
}

Map<String, dynamic> _$BallSearchBarHistoryToJson(
        BallSearchBarHistory instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'searchTime': instance.searchTime?.toIso8601String(),
    };
