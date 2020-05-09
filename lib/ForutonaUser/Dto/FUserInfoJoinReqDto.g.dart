// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoJoinReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoJoinReqDto _$FUserInfoJoinReqDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoJoinReqDto()
    ..forutonaAgree = json['forutonaAgree'] as bool
    ..forutonaManagementAgree = json['forutonaManagementAgree'] as bool
    ..privateAgree = json['privateAgree'] as bool
    ..positionAgree = json['positionAgree'] as bool
    ..martketingAgree = json['martketingAgree'] as bool
    ..ageLimitAgree = json['ageLimitAgree'] as bool
    ..nickName = json['nickName'] as String
    ..email = json['email'] as String
    ..userProfileImageUrl = json['userProfileImageUrl'] as String
    ..snsSupportService = _$enumDecodeNullable(
        _$SnsSupportServiceEnumMap, json['snsSupportService'])
    ..countryCode = json['countryCode'] as String
    ..snsToken = json['snsToken'] as String
    ..userIntroduce = json['userIntroduce'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..phoneAuthToken = json['phoneAuthToken'] as String;
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
      'userProfileImageUrl': instance.userProfileImageUrl,
      'snsSupportService':
          _$SnsSupportServiceEnumMap[instance.snsSupportService],
      'countryCode': instance.countryCode,
      'snsToken': instance.snsToken,
      'userIntroduce': instance.userIntroduce,
      'phoneNumber': instance.phoneNumber,
      'phoneAuthToken': instance.phoneAuthToken,
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
};
