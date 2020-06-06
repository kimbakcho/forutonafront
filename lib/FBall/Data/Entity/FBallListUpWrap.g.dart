// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallListUpWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallListUpWrap _$FBallListUpWrapFromJson(Map<String, dynamic> json) {
  return FBallListUpWrap(
    searchTime: json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    balls: (json['balls'] as List)
        ?.map(
            (e) => e == null ? null : FBall.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..searchBallTotalCount = json['searchBallTotalCount'] as int;
}

Map<String, dynamic> _$FBallListUpWrapToJson(FBallListUpWrap instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'balls': instance.balls,
      'searchBallTotalCount': instance.searchBallTotalCount,
    };
