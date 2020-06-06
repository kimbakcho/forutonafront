// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpFromSearchTitleReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpFromSearchTitleReqDto _$FBallListUpFromSearchTitleReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallListUpFromSearchTitleReqDto(
    searchText: json['searchText'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    sortsJsonText: json['sorts'] as String,
    size: json['size'] as int,
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$FBallListUpFromSearchTitleReqDtoToJson(
        FBallListUpFromSearchTitleReqDto instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'sorts': instance.sortsJsonText,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'size': instance.size,
      'page': instance.page,
    };
