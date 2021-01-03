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
    ..backGroundImageUrl = json['backGroundImageUrl'] as String
    ..isoCode = json['isoCode'] as String
    ..userLevel = (json['userLevel'] as num)?.toDouble()
    ..selfIntroduction = json['selfIntroduction'] as String
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num)?.toDouble()
    ..followerCount = json['followerCount'] as int
    ..followingCount = json['followingCount'] as int
    ..playerPower = (json['playerPower'] as num)?.toDouble();
}

Map<String, dynamic> _$FUserInfoSimpleToJson(FUserInfoSimple instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickName': instance.nickName,
      'profilePictureUrl': instance.profilePictureUrl,
      'backGroundImageUrl': instance.backGroundImageUrl,
      'isoCode': instance.isoCode,
      'userLevel': instance.userLevel,
      'selfIntroduction': instance.selfIntroduction,
      'cumulativeInfluence': instance.cumulativeInfluence,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'playerPower': instance.playerPower,
    };
