// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuation _$FBallValuationFromJson(Map<String, dynamic> json) {
  return FBallValuation()
    ..valueUuid = json['valueUuid'] as String
    ..ballUuid = json['ballUuid'] as String
    ..uid = json['uid'] as String
    ..upAndDown = json['upAndDown'] as int;
}

Map<String, dynamic> _$FBallValuationToJson(FBallValuation instance) =>
    <String, dynamic>{
      'valueUuid': instance.valueUuid,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'upAndDown': instance.upAndDown,
    };
