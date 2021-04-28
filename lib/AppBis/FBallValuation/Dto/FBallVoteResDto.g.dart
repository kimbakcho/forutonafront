// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallVoteResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallVoteResDto _$FBallVoteResDtoFromJson(Map<String, dynamic> json) {
  return FBallVoteResDto()
    ..ballLike = json['ballLike'] as int?
    ..ballDislike = json['ballDislike'] as int?
    ..likeServiceUseUserCount = json['likeServiceUseUserCount'] as int?
    ..ballPower = json['ballPower'] as int?
    ..fballValuationResDto = (json['fballValuationResDto'] as List<dynamic>?)
        ?.map((e) => FBallValuationResDto.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FBallVoteResDtoToJson(FBallVoteResDto instance) =>
    <String, dynamic>{
      'ballLike': instance.ballLike,
      'ballDislike': instance.ballDislike,
      'likeServiceUseUserCount': instance.likeServiceUseUserCount,
      'ballPower': instance.ballPower,
      'fballValuationResDto':
          instance.fballValuationResDto?.map((e) => e.toJson()).toList(),
    };
