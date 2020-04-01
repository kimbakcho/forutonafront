// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReqDto _$FBallReqDtoFromJson(Map<String, dynamic> json) {
  return FBallReqDto(
    json['uid'] as String,
    json['cubeUuid'] as String,
    (json['longitude'] as num)?.toDouble(),
    (json['latitude'] as num)?.toDouble(),
    json['matchBallName'] as String,
    _$enumDecodeNullable(_$FBallTypeEnumMap, json['fBallType']),
    json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String),
    _$enumDecodeNullable(_$FBallStateEnumMap, json['fBallState']),
    json['page'] == null
        ? null
        : Pageable.fromJson(json['page'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FBallReqDtoToJson(FBallReqDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'cubeUuid': instance.cubeUuid,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'matchBallName': instance.matchBallName,
      'fBallType': _$FBallTypeEnumMap[instance.fBallType],
      'makeTime': instance.makeTime?.toIso8601String(),
      'fBallState': _$FBallStateEnumMap[instance.fBallState],
      'page': instance.page,
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

const _$FBallStateEnumMap = {
  FBallState.Wait: 'Wait',
  FBallState.Play: 'Play',
  FBallState.Finish: 'Finish',
};
