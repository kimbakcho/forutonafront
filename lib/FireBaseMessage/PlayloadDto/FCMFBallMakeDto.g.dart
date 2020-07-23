// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FCMFBallMakeDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMFBallMakeDto _$FCMFBallMakeDtoFromJson(Map<String, dynamic> json) {
  return FCMFBallMakeDto()
    ..ballMakerNickName = json['ballMakerNickName'] as String
    ..ballMakerProfileImageUrl = json['ballMakerProfileImageUrl'] as String
    ..ballTitle = json['ballTitle'] as String
    ..ballUuid = json['ballUuid'] as String
    ..fBallType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['fBallType']);
}

Map<String, dynamic> _$FCMFBallMakeDtoToJson(FCMFBallMakeDto instance) =>
    <String, dynamic>{
      'ballMakerNickName': instance.ballMakerNickName,
      'ballMakerProfileImageUrl': instance.ballMakerProfileImageUrl,
      'ballTitle': instance.ballTitle,
      'ballUuid': instance.ballUuid,
      'fBallType': _$FBallTypeEnumMap[instance.fBallType],
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

const _$FBallTypeEnumMap = {
  FBallType.IssueBall: 'IssueBall',
  FBallType.QuestBall: 'QuestBall',
};
