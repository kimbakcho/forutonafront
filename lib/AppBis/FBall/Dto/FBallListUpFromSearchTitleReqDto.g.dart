// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpFromSearchTitleReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpFromSearchTitleReqDto _$FBallListUpFromSearchTitleReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallListUpFromSearchTitleReqDto(
    searchText: json['searchText'] as String,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$FBallListUpFromSearchTitleReqDtoToJson(
        FBallListUpFromSearchTitleReqDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
