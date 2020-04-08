// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpWrapDto _$FBallListUpWrapDtoFromJson(Map<String, dynamic> json) {
  return FBallListUpWrapDto(
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    (json['balls'] as List)
        ?.map((e) =>
            e == null ? null : FBallResDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..searchBallCount = json['searchBallCount'] as int;
}

Map<String, dynamic> _$FBallListUpWrapDtoToJson(FBallListUpWrapDto instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'balls': instance.balls,
      'searchBallCount': instance.searchBallCount,
    };
