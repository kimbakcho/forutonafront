// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoSimple1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoSimple1 _$FUserInfoSimple1FromJson(Map<String, dynamic> json) {
  return FUserInfoSimple1()
    ..nickName = json['nickName'] as String
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num)?.toDouble()
    ..followCount = json['followCount'] as int
    ..profilePictureUrl = json['profilePictureUrl'] as String;
}

Map<String, dynamic> _$FUserInfoSimple1ToJson(FUserInfoSimple1 instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'cumulativeInfluence': instance.cumulativeInfluence,
      'followCount': instance.followCount,
      'profilePictureUrl': instance.profilePictureUrl,
    };
