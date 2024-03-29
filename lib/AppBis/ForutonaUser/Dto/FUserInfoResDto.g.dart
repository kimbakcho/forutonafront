// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoResDto _$FUserInfoResDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoResDto()
    ..uid = json['uid'] as String?
    ..nickName = json['nickName'] as String?
    ..profilePictureUrl = json['profilePictureUrl'] as String?
    ..backGroundImageUrl = json['backGroundImageUrl'] as String?
    ..gender = _$enumDecodeNullable(_$GenderTypeEnumMap, json['gender'])
    ..ageDate = json['ageDate'] == null
        ? null
        : DateTime.parse(json['ageDate'] as String)
    ..email = json['email'] as String?
    ..forutonaAgree = json['forutonaAgree'] as bool?
    ..privateAgree = json['privateAgree'] as bool?
    ..positionAgree = json['positionAgree'] as bool?
    ..martketingAgree = json['martketingAgree'] as bool?
    ..ageLimitAgree = json['ageLimitAgree'] as bool?
    ..snsService =
        _$enumDecodeNullable(_$SnsSupportServiceEnumMap, json['snsService'])
    ..phoneNumber = json['phoneNumber'] as String?
    ..isoCode = json['isoCode'] as String?
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..longitude = (json['longitude'] as num?)?.toDouble()
    ..positionUpdateTime = json['positionUpdateTime'] == null
        ? null
        : DateTime.parse(json['positionUpdateTime'] as String)
    ..userLevel = (json['userLevel'] as num?)?.toDouble()
    ..expPoint = (json['expPoint'] as num?)?.toDouble()
    ..fCMtoken = json['fCMtoken'] as String?
    ..joinTime = json['joinTime'] == null
        ? null
        : DateTime.parse(json['joinTime'] as String)
    ..followerCount = json['followerCount'] as int?
    ..followingCount = json['followingCount'] as int?
    ..backOut = json['backOut'] as int?
    ..lastBackOutTime = json['lastBackOutTime'] == null
        ? null
        : DateTime.parse(json['lastBackOutTime'] as String)
    ..selfIntroduction = json['selfIntroduction'] as String?
    ..cumulativeInfluence = (json['cumulativeInfluence'] as num?)?.toDouble()
    ..uPoint = (json['uPoint'] as num?)?.toDouble()
    ..naPoint = (json['naPoint'] as num?)?.toDouble()
    ..historyOpenAll = json['historyOpenAll'] as int?
    ..historyOpenFollowSponsor = json['historyOpenFollowSponsor'] as int?
    ..historyOpenNoOpen = json['historyOpenNoOpen'] as int?
    ..sponsorHistoryOpenAll = json['sponsorHistoryOpenAll'] as int?
    ..sponsorHistoryOpenSponAndFollowFromMe =
        json['sponsorHistoryOpenSponAndFollowFromMe'] as int?
    ..sponsorHistoryOpenSponNoOpen =
        json['sponsorHistoryOpenSponNoOpen'] as int?
    ..alarmChatMessage = json['alarmChatMessage'] as bool?
    ..alarmContentReply = json['alarmContentReply'] as bool?
    ..alarmReplyAndReply = json['alarmReplyAndReply'] as bool?
    ..alarmFollowNewContent = json['alarmFollowNewContent'] as bool?
    ..alarmSponNewContent = json['alarmSponNewContent'] as bool?
    ..deactivation = json['deactivation'] as int?
    ..maliciousCount = json['maliciousCount'] as int
    ..stopPeriod = json['stopPeriod'] == null
        ? null
        : DateTime.parse(json['stopPeriod'] as String)
    ..maliciousMessageCheck = json['maliciousMessageCheck'] as bool?
    ..maliciousCause = json['maliciousCause'] as String?
    ..influenceTicket = json['influenceTicket'] as int?
    ..maxInfluenceTicket = json['maxInfluenceTicket'] as int?
    ..influenceTicketReceiveTime = json['influenceTicketReceiveTime'] == null
        ? null
        : DateTime.parse(json['influenceTicketReceiveTime'] as String)
    ..nextGiveInfluenceTicketTime = json['nextGiveInfluenceTicketTime'] == null
        ? null
        : DateTime.parse(json['nextGiveInfluenceTicketTime'] as String)
    ..playerPower = (json['playerPower'] as num?)?.toDouble();
}

Map<String, dynamic> _$FUserInfoResDtoToJson(FUserInfoResDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickName': instance.nickName,
      'profilePictureUrl': instance.profilePictureUrl,
      'backGroundImageUrl': instance.backGroundImageUrl,
      'gender': _$GenderTypeEnumMap[instance.gender],
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
      'longitude': instance.longitude,
      'positionUpdateTime': instance.positionUpdateTime?.toIso8601String(),
      'userLevel': instance.userLevel,
      'expPoint': instance.expPoint,
      'fCMtoken': instance.fCMtoken,
      'joinTime': instance.joinTime?.toIso8601String(),
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
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
      'maliciousCount': instance.maliciousCount,
      'stopPeriod': instance.stopPeriod?.toIso8601String(),
      'maliciousMessageCheck': instance.maliciousMessageCheck,
      'maliciousCause': instance.maliciousCause,
      'influenceTicket': instance.influenceTicket,
      'maxInfluenceTicket': instance.maxInfluenceTicket,
      'influenceTicketReceiveTime':
          instance.influenceTicketReceiveTime?.toIso8601String(),
      'nextGiveInfluenceTicketTime':
          instance.nextGiveInfluenceTicketTime?.toIso8601String(),
      'playerPower': instance.playerPower,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderTypeEnumMap = {
  GenderType.Male: 'Male',
  GenderType.FeMale: 'FeMale',
  GenderType.None: 'None',
};

const _$SnsSupportServiceEnumMap = {
  SnsSupportService.FaceBook: 'FaceBook',
  SnsSupportService.Naver: 'Naver',
  SnsSupportService.Kakao: 'Kakao',
  SnsSupportService.Forutona: 'Forutona',
};
