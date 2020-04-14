// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoResDto _$FUserInfoResDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoResDto(
    json['uid'] as String,
    json['nickName'] as String,
    json['profilePicktureUrl'] as String,
    json['gender'] as int,
    json['ageDate'] == null ? null : DateTime.parse(json['ageDate'] as String),
    json['email'] as String,
    json['forutonaAgree'] as int,
    json['privateAgree'] as int,
    json['positionAgree'] as int,
    json['martketingAgree'] as int,
    json['ageLimitAgree'] as int,
    json['snsService'] as String,
    json['phoneNumber'] as String,
    json['isoCode'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['intitude'] as num)?.toDouble(),
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
    json['selfIntroduction'] as String,
    (json['cumulativeInfluence'] as num)?.toDouble(),
    (json['uPoint'] as num)?.toDouble(),
    (json['naPoint'] as num)?.toDouble(),
    json['historyOpenAll'] as int,
    json['historyOpenFollowSponsor'] as int,
    json['historyOpenNoOpen'] as int,
    json['sponsorHistoryOpenAll'] as int,
    json['sponsorHistoryOpenSponAndFollowFromMe'] as int,
    json['sponsorHistoryOpenSponNoOpen'] as int,
    json['alarmChatMessage'] as int,
    json['alarmContentReply'] as int,
    json['alarmReplyAndReply'] as int,
    json['alarmFollowNewContent'] as int,
    json['alarmSponNewContent'] as int,
    json['deactivation'] as int,
  );
}

Map<String, dynamic> _$FUserInfoResDtoToJson(FUserInfoResDto instance) =>
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
      'intitude': instance.intitude,
      'positionUpdateTime': instance.positionUpdateTime?.toIso8601String(),
      'userLevel': instance.userLevel,
      'expPoint': instance.expPoint,
      'fCMtoken': instance.fCMtoken,
      'joinTime': instance.joinTime?.toIso8601String(),
      'followCount': instance.followCount,
      'backOut': instance.backOut,
      'lastBackOutTime': instance.lastBackOutTime?.toIso8601String(),
      'selfIntroduction': instance.selfIntroduction,
      'cumulativeInfluence': instance.cumulativeInfluence,
      'uPoint': instance.uPoint,
      'naPoint': instance.naPoint,
      'historyOpenAll': instance.historyOpenAll,
      'historyOpenFollowSponsor': instance.historyOpenFollowSponsor,
      'historyOpenNoOpen': instance.historyOpenNoOpen,
      'sponsorHistoryOpenAll': instance.sponsorHistoryOpenAll,
      'sponsorHistoryOpenSponAndFollowFromMe':
          instance.sponsorHistoryOpenSponAndFollowFromMe,
      'sponsorHistoryOpenSponNoOpen': instance.sponsorHistoryOpenSponNoOpen,
      'alarmChatMessage': instance.alarmChatMessage,
      'alarmContentReply': instance.alarmContentReply,
      'alarmReplyAndReply': instance.alarmReplyAndReply,
      'alarmFollowNewContent': instance.alarmFollowNewContent,
      'alarmSponNewContent': instance.alarmSponNewContent,
      'deactivation': instance.deactivation,
    };
