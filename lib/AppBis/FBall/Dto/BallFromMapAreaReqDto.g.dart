// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BallFromMapAreaReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BallFromMapAreaReqDto _$BallFromMapAreaReqDtoFromJson(
    Map<String, dynamic> json) {
  return BallFromMapAreaReqDto(
    (json['southwestLat'] as num).toDouble(),
    (json['southwestLng'] as num).toDouble(),
    (json['northeastLat'] as num).toDouble(),
    (json['northeastLng'] as num).toDouble(),
    (json['centerPointLat'] as num).toDouble(),
    (json['centerPointLng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$BallFromMapAreaReqDtoToJson(
        BallFromMapAreaReqDto instance) =>
    <String, dynamic>{
      'southwestLat': instance.southwestLat,
      'southwestLng': instance.southwestLng,
      'northeastLat': instance.northeastLat,
      'northeastLng': instance.northeastLng,
      'centerPointLat': instance.centerPointLat,
      'centerPointLng': instance.centerPointLng,
    };
