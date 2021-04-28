// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpFromBIReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpFromBIReqDto _$FBallListUpFromBIReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallListUpFromBIReqDto(
    mapCenterLatitude: (json['mapCenterLatitude'] as num).toDouble(),
    mapCenterLongitude: (json['mapCenterLongitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FBallListUpFromBIReqDtoToJson(
        FBallListUpFromBIReqDto instance) =>
    <String, dynamic>{
      'mapCenterLatitude': instance.mapCenterLatitude,
      'mapCenterLongitude': instance.mapCenterLongitude,
    };
