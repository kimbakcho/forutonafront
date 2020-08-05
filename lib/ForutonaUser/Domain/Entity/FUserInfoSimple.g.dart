// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoSimple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoSimple _$FUserInfoSimpleFromJson(Map<String, dynamic> json) {
  return FUserInfoSimple()
    ..uid = json['uid'] as String
    ..nickName = json['nickName'] as String
    ..profilePictureUrl = json['profilePictureUrl'] as String
    ..isoCode = json['isoCode'] as String
    ..userLevel = (json['userLevel'] as num)?.toDouble()
    ..selfIntroduction = json['selfIntroduction'] as String
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num)?.toDouble()
    ..followCount = json['followCount'] as int;
}

Map<String, dynamic> _$FUserInfoSimpleToJson(FUserInfoSimple instance) =>
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
