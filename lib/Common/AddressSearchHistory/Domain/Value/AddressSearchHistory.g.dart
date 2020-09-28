// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressSearchHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSearchHistory _$AddressSearchHistoryFromJson(Map<String, dynamic> json) {
  return AddressSearchHistory(
    searchText: json['searchText'] as String,
    searchTime: json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
  );
}

Map<String, dynamic> _$AddressSearchHistoryToJson(
        AddressSearchHistory instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'searchTime': instance.searchTime?.toIso8601String(),
    };
