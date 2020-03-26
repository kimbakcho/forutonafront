// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoDto _$FUserInfoDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoDto(
    json['uid'] as String,
    json['nickName'] as String,
    json['profilePicktureUrl'] as String,
    json['gender'] as int,
    json['ageDate'] == null ? null : DateTime.parse(json['ageDate'] as String),
    json['email'] as String,
    json['forutonaAgree'] as bool,
    json['privateAgree'] as bool,
    json['positionAgree'] as bool,
    json['martketingAgree'] as bool,
    json['ageLimitAgree'] as bool,
    json['snsService'] as String,
    json['phoneNumber'] as String,
    json['isoCode'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['positionUpdateTime'] == null
        ? null
        : DateTime.parse(json['positionUpdateTime'] as String),
    (json['userLevel'] as num)?.toDouble(),
    (json['expPoint'] as num)?.toDouble(),
    json['fCMtoken'] as String,
    json['joinTime'] == null
        ? null
        : DateTime.parse(json['joinTime'] as String),
    json['followCount'] as int,
    json['backOut'] as int,
    json['lastBackOutTime'] == null
        ? null
        : DateTime.parse(json['lastBackOutTime'] as String),
  );
}

Map<String, dynamic> _$FUserInfoDtoToJson(FUserInfoDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickName': instance.nickName,
      'profilePicktureUrl': instance.profilePicktureUrl,
      'gender': instance.gender,
      'ageDate': instance.ageDate?.toIso8601String(),
      'email': instance.email,
      'forutonaAgree': instance.forutonaAgree,
      'privateAgree': instance.privateAgree,
      'positionAgree': instance.positionAgree,
      'martketingAgree': instance.martketingAgree,
      'ageLimitAgree': instance.ageLimitAgree,
      'snsService': instance.snsService,
      'phoneNumber': instance.phoneNumber,
      'isoCode': instance.isoCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'positionUpdateTime': instance.positionUpdateTime?.toIso8601String(),
      'userLevel': instance.userLevel,
      'expPoint': instance.expPoint,
      'fCMtoken': instance.fCMtoken,
      'joinTime': instance.joinTime?.toIso8601String(),
      'followCount': instance.followCount,
      'backOut': instance.backOut,
      'lastBackOutTime': instance.lastBackOutTime?.toIso8601String(),
    };
