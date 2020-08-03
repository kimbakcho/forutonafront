// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallLikeResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallLikeResDto _$FBallLikeResDtoFromJson(Map<String, dynamic> json) {
  return FBallLikeResDto()
    ..like = json['like'] as int
    ..dislike = json['dislike'] as int
    ..fBallValuationResDto = json['fBallValuationResDto'] == null
        ? null
        : FBallValuationResDto.fromJson(
            json['fBallValuationResDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FBallLikeResDtoToJson(FBallLikeResDto instance) =>
    <String, dynamic>{
      'like': instance.like,
      'dislike': instance.dislike,
      'fBallValuationResDto': instance.fBallValuationResDto,
    };
