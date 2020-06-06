// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpFromTagNameReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpFromTagNameReqDto _$FBallListUpFromTagNameReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallListUpFromTagNameReqDto(
    searchTag: json['searchTag'] as String,
    sortsJsonText: json['sorts'] as String,
    size: json['size'] as int,
    page: json['page'] as int,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FBallListUpFromTagNameReqDtoToJson(
        FBallListUpFromTagNameReqDto instance) =>
    <String, dynamic>{
      'searchTag': instance.searchTag,
      'sorts': instance.sortsJsonText,
      'size': instance.size,
      'page': instance.page,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
