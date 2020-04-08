// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagSearchFromTextReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagSearchFromTextReqDto _$TagSearchFromTextReqDtoFromJson(
    Map<String, dynamic> json) {
  return TagSearchFromTextReqDto(
    json['searchText'] as String,
    json['sorts'] as String,
    json['size'] as int,
    json['page'] as int,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TagSearchFromTextReqDtoToJson(
        TagSearchFromTextReqDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'sorts': instance.sorts,
      'size': instance.size,
      'page': instance.page,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
