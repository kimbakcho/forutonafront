// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FCMFBallMakeDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMFBallMakeDto _$FCMFBallMakeDtoFromJson(Map<String, dynamic> json) {
  return FCMFBallMakeDto()
    ..ballMakerNickName = json['ballMakerNickName'] as String?
    ..ballMakerProfileImageUrl = json['ballMakerProfileImageUrl'] as String?
    ..ballTitle = json['ballTitle'] as String?
    ..ballUuid = json['ballUuid'] as String?
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

const _$FBallTypeEnumMap = {
  FBallType.IssueBall: 'IssueBall',
  FBallType.QuestBall: 'QuestBall',
};
