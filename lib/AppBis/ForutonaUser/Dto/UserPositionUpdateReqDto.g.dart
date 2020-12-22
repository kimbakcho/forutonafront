// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPositionUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPositionUpdateReqDto _$UserPositionUpdateReqDtoFromJson(
    Map<String, dynamic> json) {
  return UserPositionUpdateReqDto(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UserPositionUpdateReqDtoToJson(
        UserPositionUpdateReqDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
