// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfoMain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoMain _$UserInfoMainFromJson(Map<String, dynamic> json) {
  return UserInfoMain()
    ..uid = json['uid'] as String
    ..nickname = json['nickname'] as String
    ..profilepicktureurl = json['profilepicktureurl'] as String
    ..sex = json['sex'] as int
    ..agedate = json['agedate'] as String
    ..email = json['email'] as String
    ..forutonaagree = json['forutonaagree'] as int
    ..privateagree = json['privateagree'] as int
    ..positionagree = json['positionagree'] as int
    ..martketingagree = json['martketingagree'] as int
    ..agelimitagree = json['agelimitagree'] as int
    ..password = json['password'] as String
    ..snsservice = json['snsservice'] as String
    ..snstoken = json['snstoken'] as String;
}

Map<String, dynamic> _$UserInfoMainToJson(UserInfoMain instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'profilepicktureurl': instance.profilepicktureurl,
      'sex': instance.sex,
      'agedate': instance.agedate,
      'email': instance.email,
      'forutonaagree': instance.forutonaagree,
      'privateagree': instance.privateagree,
      'positionagree': instance.positionagree,
      'martketingagree': instance.martketingagree,
      'agelimitagree': instance.agelimitagree,
      'password': instance.password,
      'snsservice': instance.snsservice,
      'snstoken': instance.snstoken
    };
