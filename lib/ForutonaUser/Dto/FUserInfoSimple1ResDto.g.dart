// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoSimple1ResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoSimple1ResDto _$FUserInfoSimple1ResDtoFromJson(
    Map<String, dynamic> json) {
  return FUserInfoSimple1ResDto()
    ..nickName = json['nickName'] as String
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num)?.toDouble()
    ..followCount = json['followCount'] as int
    ..profilePictureUrl = json['profilePictureUrl'] as String;
}

Map<String, dynamic> _$FUserInfoSimple1ResDtoToJson(
        FUserInfoSimple1ResDto instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'cumulativeInfluence': instance.cumulativeInfluence,
      'followCount': instance.followCount,
      'profilePictureUrl': instance.profilePictureUrl,
    };
