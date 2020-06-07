// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuationInsertReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuationInsertReqDto _$FBallValuationInsertReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallValuationInsertReqDto(
    valueUuid: json['valueUuid'] as String,
    ballUuid: json['ballUuid'] as String,
    uid: json['uid'] as String,
    upAndDown: json['upAndDown'] as int,
  );
}

Map<String, dynamic> _$FBallValuationInsertReqDtoToJson(
        FBallValuationInsertReqDto instance) =>
    <String, dynamic>{
      'valueUuid': instance.valueUuid,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'upAndDown': instance.upAndDown,
    };
