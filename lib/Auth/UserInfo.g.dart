// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
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
    ..password = json['password'] as String;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
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
      'password': instance.password
    };
