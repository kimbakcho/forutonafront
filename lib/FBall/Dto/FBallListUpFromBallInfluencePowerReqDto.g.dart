// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpFromBallInfluencePowerReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpFromBallInfluencePowerReqDto
    _$FBallListUpFromBallInfluencePowerReqDtoFromJson(
        Map<String, dynamic> json) {
  return FBallListUpFromBallInfluencePowerReqDto(
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    ballLimit: json['ballLimit'] as int,
    page: json['page'] as int,
    size: json['size'] as int,
  );
}

Map<String, dynamic> _$FBallListUpFromBallInfluencePowerReqDtoToJson(
        FBallListUpFromBallInfluencePowerReqDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'ballLimit': instance.ballLimit,
      'page': instance.page,
      'size': instance.size,
    };
