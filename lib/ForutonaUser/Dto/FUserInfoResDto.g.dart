// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoResDto _$FUserInfoResDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoResDto()
    ..uid = json['uid'] as String
    ..nickName = json['nickName'] as String
    ..profilePictureUrl = json['profilePictureUrl'] as String
    ..gender = json['gender'] as int
    ..ageDate = json['ageDate'] == null
        ? null
        : DateTime.parse(json['ageDate'] as String)
    ..email = json['email'] as String
    ..forutonaAgree = json['forutonaAgree'] as bool
    ..privateAgree = json['privateAgree'] as bool
    ..positionAgree = json['positionAgree'] as bool
    ..martketingAgree = json['martketingAgree'] as bool
    ..ageLimitAgree = json['ageLimitAgree'] as bool
    ..snsService =
        _$enumDecodeNullable(_$SnsSupportServiceEnumMap, json['snsService'])
    ..phoneNumber = json['phoneNumber'] as String
    ..isoCode = json['isoCode'] as String
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..intitude = (json['intitude'] as num)?.toDouble()
    ..positionUpdateTime = json['positionUpdateTime'] == null
        ? null
        : DateTime.parse(json['positionUpdateTime'] as String)
    ..userLevel = (json['userLevel'] as num)?.toDouble()
    ..expPoint = (json['expPoint'] as num)?.toDouble()
    ..fCMtoken = json['fCMtoken'] as String
    ..joinTime = json['joinTime'] == null
        ? null
        : DateTime.parse(json['joinTime'] as String)
    ..followCount = json['followCount'] as int
    ..backOut = json['backOut'] as int
    ..lastBackOutTime = json['lastBackOutTime'] == null
        ? null
        : DateTime.parse(json['lastBackOutTime'] as String)
    ..selfIntroduction = json['selfIntroduction'] as String
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num)?.toDouble()
    ..uPoint = (json['uPoint'] as num)?.toDouble()
    ..naPoint = (json['naPoint'] as num)?.toDouble()
    ..historyOpenAll = json['historyOpenAll'] as int
    ..historyOpenFollowSponsor = json['historyOpenFollowSponsor'] as int
    ..historyOpenNoOpen = json['historyOpenNoOpen'] as int
    ..sponsorHistoryOpenAll = json['sponsorHistoryOpenAll'] as int
    ..sponsorHistoryOpenSponAndFollowFromMe =
        json['sponsorHistoryOpenSponAndFollowFromMe'] as int
    ..sponsorHistoryOpenSponNoOpen = json['sponsorHistoryOpenSponNoOpen'] as int
    ..alarmChatMessage = json['alarmChatMessage'] as int
    ..alarmContentReply = json['alarmContentReply'] as int
    ..alarmReplyAndReply = json['alarmReplyAndReply'] as int
    ..alarmFollowNewContent = json['alarmFollowNewContent'] as int
    ..alarmSponNewContent = json['alarmSponNewContent'] as int
    ..deactivation = json['deactivation'] as int;
}

Map<String, dynamic> _$FUserInfoResDtoToJson(FUserInfoResDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickName': instance.nickName,
      'profilePictureUrl': instance.profilePictureUrl,
      'gender': instance.gender,
      'ageDate': instance.ageDate?.toIso8601String(),
      'email': instance.email,
      'forutonaAgree': instance.forutonaAgree,
      'privateAgree': instance.privateAgree,
      'positionAgree': instance.positionAgree,
      'martketingAgree': instance.martketingAgree,
      'ageLimitAgree': instance.ageLimitAgree,
      'snsService': _$SnsSupportServiceEnumMap[instance.snsService],
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

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SnsSupportServiceEnumMap = {
  SnsSupportService.FaceBook: 'FaceBook',
  SnsSupportService.Naver: 'Naver',
  SnsSupportService.Kakao: 'Kakao',
  SnsSupportService.Forutona: 'Forutona',
};
