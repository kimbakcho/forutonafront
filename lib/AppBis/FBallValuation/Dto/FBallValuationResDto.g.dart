// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuationResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuationResDto _$FBallValuationResDtoFromJson(Map<String, dynamic> json) {
  return FBallValuationResDto()
    ..valueUuid = json['valueUuid'] as String?
    ..ballUuid = json['ballUuid'] == null
        ? null
        : FBallResDto.fromJson(json['ballUuid'] as Map<String, dynamic>)
    ..uid = json['uid'] == null
        ? null
        : FUserInfoSimpleResDto.fromJson(json['uid'] as Map<String, dynamic>)
    ..ballLike = json['ballLike'] as int
    ..ballDislike = json['ballDislike'] as int
    ..point = json['point'] as int;
}

Map<String, dynamic> _$FBallValuationResDtoToJson(
        FBallValuationResDto instance) =>
    <String, dynamic>{
      'valueUuid': instance.valueUuid,
      'ballUuid': instance.ballUuid?.toJson(),
      'uid': instance.uid?.toJson(),
      'ballLike': instance.ballLike,
      'ballDislike': instance.ballDislike,
      'point': instance.point,
    };
