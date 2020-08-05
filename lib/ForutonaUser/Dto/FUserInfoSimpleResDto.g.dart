// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoSimpleResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoSimpleResDto _$FUserInfoSimpleResDtoFromJson(
    Map<String, dynamic> json) {
  return FUserInfoSimpleResDto()
    ..uid = json['uid'] as String
    ..nickName = json['nickName'] as String
    ..profilePictureUrl = json['profilePictureUrl'] as String
    ..isoCode = json['isoCode'] as String
    ..userLevel = (json['userLevel'] as num)?.toDouble()
    ..selfIntroduction = json['selfIntroduction'] as String
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num)?.toDouble()
    ..followCount = json['followCount'] as int;
}

Map<String, dynamic> _$FUserInfoSimpleResDtoToJson(
        FUserInfoSimpleResDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickName': instance.nickName,
      'profilePictureUrl': instance.profilePictureUrl,
      'isoCode': instance.isoCode,
      'userLevel': instance.userLevel,
      'selfIntroduction': instance.selfIntroduction,
      'cumulativeInfluence': instance.cumulativeInfluence,
      'followCount': instance.followCount,
    };
