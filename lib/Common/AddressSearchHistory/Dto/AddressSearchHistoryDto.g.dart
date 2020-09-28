// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressSearchHistoryDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSearchHistoryDto _$AddressSearchHistoryDtoFromJson(
    Map<String, dynamic> json) {
  return AddressSearchHistoryDto(
    searchText: json['searchText'] as String,
    searchTime: json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
  );
}

Map<String, dynamic> _$AddressSearchHistoryDtoToJson(
        AddressSearchHistoryDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'searchTime': instance.searchTime?.toIso8601String(),
    };
