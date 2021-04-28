// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpFromTagNameReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpFromTagNameReqDto _$FBallListUpFromTagNameReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallListUpFromTagNameReqDto(
    searchTag: json['searchTag'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FBallListUpFromTagNameReqDtoToJson(
        FBallListUpFromTagNameReqDto instance) =>
    <String, dynamic>{
      'searchTag': instance.searchTag,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
