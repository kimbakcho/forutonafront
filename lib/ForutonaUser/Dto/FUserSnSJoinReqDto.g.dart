// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserSnSJoinReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserSnSJoinReqDto _$FUserSnSJoinReqDtoFromJson(Map<String, dynamic> json) {
  return FUserSnSJoinReqDto()
    ..accessToken = json['accessToken'] as String
    ..snsUid = json['snsUid'] as String
    ..snsService =
        _$enumDecodeNullable(_$SnsSupportServiceEnumMap, json['snsService'])
    ..fUserUid = json['fUserUid'] as String
    ..userNickName = json['userNickName'] as String
    ..email = json['email'] as String
    ..userProfileImageUrl = json['userProfileImageUrl'] as String;
}

Map<String, dynamic> _$FUserSnSJoinReqDtoToJson(FUserSnSJoinReqDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'snsUid': instance.snsUid,
      'snsService': _$SnsSupportServiceEnumMap[instance.snsService],
      'fUserUid': instance.fUserUid,
      'userNickName': instance.userNickName,
      'email': instance.email,
      'userProfileImageUrl': instance.userProfileImageUrl,
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
