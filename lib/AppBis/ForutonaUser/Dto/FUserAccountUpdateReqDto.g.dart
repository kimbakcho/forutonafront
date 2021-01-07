// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserAccountUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserAccountUpdateReqDto _$FUserAccountUpdateReqDtoFromJson(
    Map<String, dynamic> json) {
  return FUserAccountUpdateReqDto()
    ..isoCode = json['isoCode'] as String
    ..nickName = json['nickName'] as String
    ..selfIntroduction = json['selfIntroduction'] as String
    ..gender = _$enumDecodeNullable(_$GenderTypeEnumMap, json['gender'])
    ..profileImageIsEmpty = json['profileImageIsEmpty'] as bool
    ..backGroundIsEmpty = json['backGroundIsEmpty'] as bool;
}

Map<String, dynamic> _$FUserAccountUpdateReqDtoToJson(
        FUserAccountUpdateReqDto instance) =>
    <String, dynamic>{
      'isoCode': instance.isoCode,
      'nickName': instance.nickName,
      'selfIntroduction': instance.selfIntroduction,
      'gender': _$GenderTypeEnumMap[instance.gender],
      'profileImageIsEmpty': instance.profileImageIsEmpty,
      'backGroundIsEmpty': instance.backGroundIsEmpty,
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

const _$GenderTypeEnumMap = {
  GenderType.Male: 'Male',
  GenderType.FeMale: 'FeMale',
  GenderType.None: 'None',
};
