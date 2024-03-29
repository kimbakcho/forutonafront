// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoJoinReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoJoinReqDto _$FUserInfoJoinReqDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoJoinReqDto()
    ..forutonaAgree = json['forutonaAgree'] as bool?
    ..forutonaManagementAgree = json['forutonaManagementAgree'] as bool?
    ..privateAgree = json['privateAgree'] as bool?
    ..positionAgree = json['positionAgree'] as bool?
    ..martketingAgree = json['martketingAgree'] as bool?
    ..ageLimitAgree = json['ageLimitAgree'] as bool?
    ..nickName = json['nickName'] as String?
    ..email = json['email'] as String?
    ..snsSupportService = _$enumDecodeNullable(
        _$SnsSupportServiceEnumMap, json['snsSupportService'])
    ..countryCode = json['countryCode'] as String?
    ..snsToken = json['snsToken'] as String?
    ..userIntroduce = json['userIntroduce'] as String?
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String?
    ..phoneAuthToken = json['phoneAuthToken'] as String?
    ..password = json['password'] as String?
    ..emailUserUid = json['emailUserUid'] as String?
    ..ageDate = json['ageDate'] == null
        ? null
        : DateTime.parse(json['ageDate'] as String)
    ..gender = _$enumDecodeNullable(_$GenderTypeEnumMap, json['gender'])
    ..profileImageUrl = json['profileImageUrl'] as String?;
}

Map<String, dynamic> _$FUserInfoJoinReqDtoToJson(
        FUserInfoJoinReqDto instance) =>
    <String, dynamic>{
      'forutonaAgree': instance.forutonaAgree,
      'forutonaManagementAgree': instance.forutonaManagementAgree,
      'privateAgree': instance.privateAgree,
      'positionAgree': instance.positionAgree,
      'martketingAgree': instance.martketingAgree,
      'ageLimitAgree': instance.ageLimitAgree,
      'nickName': instance.nickName,
      'email': instance.email,
      'snsSupportService':
          _$SnsSupportServiceEnumMap[instance.snsSupportService],
      'countryCode': instance.countryCode,
      'snsToken': instance.snsToken,
      'userIntroduce': instance.userIntroduce,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'phoneAuthToken': instance.phoneAuthToken,
      'password': instance.password,
      'emailUserUid': instance.emailUserUid,
      'ageDate': instance.ageDate?.toIso8601String(),
      'gender': _$GenderTypeEnumMap[instance.gender],
      'profileImageUrl': instance.profileImageUrl,
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

const _$SnsSupportServiceEnumMap = {
  SnsSupportService.FaceBook: 'FaceBook',
  SnsSupportService.Naver: 'Naver',
  SnsSupportService.Kakao: 'Kakao',
  SnsSupportService.Forutona: 'Forutona',
};

const _$GenderTypeEnumMap = {
  GenderType.Male: 'Male',
  GenderType.FeMale: 'FeMale',
  GenderType.None: 'None',
};
