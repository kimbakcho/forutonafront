// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallLikeResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallLikeResDto _$FBallLikeResDtoFromJson(Map<String, dynamic> json) {
  return FBallLikeResDto()
    ..ballLike = json['ballLike'] as int
    ..ballDislike = json['ballDislike'] as int
    ..likeServiceUseUserCount = json['likeServiceUseUserCount'] as int
    ..ballPower = json['ballPower'] as int
    ..fballValuationResDto = json['fballValuationResDto'] == null
        ? null
        : FBallValuationResDto.fromJson(
            json['fballValuationResDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FBallLikeResDtoToJson(FBallLikeResDto instance) =>
    <String, dynamic>{
      'ballLike': instance.ballLike,
      'ballDislike': instance.ballDislike,
      'likeServiceUseUserCount': instance.likeServiceUseUserCount,
      'ballPower': instance.ballPower,
      'fballValuationResDto': instance.fballValuationResDto?.toJson(),
    };
