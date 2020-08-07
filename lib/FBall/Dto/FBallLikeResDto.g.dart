// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallLikeResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallLikeResDto _$FBallLikeResDtoFromJson(Map<String, dynamic> json) {
  return FBallLikeResDto()
    ..ballLike = json['ballLike'] as int
    ..ballDislike = json['ballDislike'] as int
    ..fballValuationResDto = json['fballValuationResDto'] == null
        ? null
        : FBallValuationResDto.fromJson(
            json['fballValuationResDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FBallLikeResDtoToJson(FBallLikeResDto instance) =>
    <String, dynamic>{
      'ballLike': instance.ballLike,
      'ballDislike': instance.ballDislike,
      'fballValuationResDto': instance.fballValuationResDto?.toJson(),
    };
