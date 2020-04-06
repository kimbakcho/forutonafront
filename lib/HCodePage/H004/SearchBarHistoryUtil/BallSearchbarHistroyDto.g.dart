// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BallSearchbarHistroyDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BallSearchbarHistroyDto _$BallSearchbarHistroyDtoFromJson(
    Map<String, dynamic> json) {
  return BallSearchbarHistroyDto(
    json['searchText'] as String,
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
  );
}

Map<String, dynamic> _$BallSearchbarHistroyDtoToJson(
        BallSearchbarHistroyDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'searchTime': instance.searchTime?.toIso8601String(),
    };
