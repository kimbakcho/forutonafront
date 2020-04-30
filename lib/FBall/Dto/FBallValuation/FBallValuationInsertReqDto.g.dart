// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuationInsertReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuationInsertReqDto _$FBallValuationInsertReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallValuationInsertReqDto()
    ..idx = json['idx'] as int
    ..ballUuid = json['ballUuid'] as String
    ..uid = json['uid'] as String
    ..unAndDown = json['unAndDown'] as int;
}

Map<String, dynamic> _$FBallValuationInsertReqDtoToJson(
        FBallValuationInsertReqDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'unAndDown': instance.unAndDown,
    };
