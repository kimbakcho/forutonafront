// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpReqDto _$FBallListUpReqDtoFromJson(Map<String, dynamic> json) {
  return FBallListUpReqDto(
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    ballLimit: json['ballLimit'] as int,
    page: json['page'] as int,
    size: json['size'] as int,
    sort: json['sort'] as String,
  );
}

Map<String, dynamic> _$FBallListUpReqDtoToJson(FBallListUpReqDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'ballLimit': instance.ballLimit,
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
