// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallPlayerResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallPlayerResDto _$FBallPlayerResDtoFromJson(Map<String, dynamic> json) {
  return FBallPlayerResDto()
    ..idx = json['idx'] as int?
    ..ballUuid = json['ballUuid'] == null
        ? null
        : FBallResDto.fromJson(json['ballUuid'] as Map<String, dynamic>)
    ..playerUid = json['playerUid'] == null
        ? null
        : FUserInfoSimpleResDto.fromJson(
            json['playerUid'] as Map<String, dynamic>)
    ..hasLike = json['hasLike'] as bool?
    ..hasDisLike = json['hasDisLike'] as bool?
    ..hasGiveUp = json['hasGiveUp'] as bool?
    ..hasExit = json['hasExit'] as bool?
    ..startTime = json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String)
    ..playState =
        _$enumDecodeNullable(_$FBallPlayStateEnumMap, json['playState']);
}

Map<String, dynamic> _$FBallPlayerResDtoToJson(FBallPlayerResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'ballUuid': instance.ballUuid,
      'playerUid': instance.playerUid,
      'hasLike': instance.hasLike,
      'hasDisLike': instance.hasDisLike,
      'hasGiveUp': instance.hasGiveUp,
      'hasExit': instance.hasExit,
      'startTime': instance.startTime?.toIso8601String(),
      'playState': _$FBallPlayStateEnumMap[instance.playState],
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

const _$FBallPlayStateEnumMap = {
  FBallPlayState.Join: 'Join',
};
