// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallVoteReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallVoteReqDto _$FBallVoteReqDtoFromJson(Map<String, dynamic> json) {
  return FBallVoteReqDto()
    ..ballUuid = json['ballUuid'] as String?
    ..likePoint = json['likePoint'] as int?
    ..disLikePoint = json['disLikePoint'] as int?
    ..likeActionType =
        _$enumDecodeNullable(_$LikeActionTypeEnumMap, json['likeActionType']);
}

Map<String, dynamic> _$FBallVoteReqDtoToJson(FBallVoteReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'likePoint': instance.likePoint,
      'disLikePoint': instance.disLikePoint,
      'likeActionType': _$LikeActionTypeEnumMap[instance.likeActionType],
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

const _$LikeActionTypeEnumMap = {
  LikeActionType.Vote: 'Vote',
  LikeActionType.CANCEL: 'CANCEL',
};
