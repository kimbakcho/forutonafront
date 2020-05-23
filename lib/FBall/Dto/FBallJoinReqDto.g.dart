// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallJoinReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallJoinReqDto _$FBallJoinReqDtoFromJson(Map<String, dynamic> json) {
  return FBallJoinReqDto(
    _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType']),
    json['ballUuid'] as String,
    json['playerUid'] as String,
  );
}

Map<String, dynamic> _$FBallJoinReqDtoToJson(FBallJoinReqDto instance) =>
    <String, dynamic>{
      'ballType': _$FBallTypeEnumMap[instance.ballType],
      'ballUuid': instance.ballUuid,
      'playerUid': instance.playerUid,
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