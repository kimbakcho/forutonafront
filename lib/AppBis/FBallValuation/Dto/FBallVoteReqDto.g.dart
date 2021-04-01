// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallVoteReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallVoteReqDto _$FBallVoteReqDtoFromJson(Map<String, dynamic> json) {
  return FBallVoteReqDto()
    ..ballUuid = json['ballUuid'] as String
    ..likePoint = json['likePoint'] as int
    ..disLikePoint = json['disLikePoint'] as int
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

const _$LikeActionTypeEnumMap = {
  LikeActionType.Vote: 'Vote',
  LikeActionType.CANCEL: 'CANCEL',
};