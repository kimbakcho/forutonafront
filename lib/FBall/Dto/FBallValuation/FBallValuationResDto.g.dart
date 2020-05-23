// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuationResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuationResDto _$FBallValuationResDtoFromJson(Map<String, dynamic> json) {
  return FBallValuationResDto()
    ..valueUuid = json['valueUuid'] as String
    ..ballUuid = json['ballUuid'] as String
    ..uid = json['uid'] as String
    ..upAndDown = json['upAndDown'] as int;
}

Map<String, dynamic> _$FBallValuationResDtoToJson(
        FBallValuationResDto instance) =>
    <String, dynamic>{
      'valueUuid': instance.valueUuid,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'upAndDown': instance.upAndDown,
    };
