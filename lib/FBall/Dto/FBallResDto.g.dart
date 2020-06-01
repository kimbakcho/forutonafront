// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallResDto _$FBallResDtoFromJson(Map<String, dynamic> json) {
  return FBallResDto(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['ballUuid'] as String,
    json['ballName'] as String,
    _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType']),
    _$enumDecodeNullable(_$FBallStateEnumMap, json['ballState']),
    json['placeAddress'] as String,
    json['ballLikes'] as int,
    json['ballDisLikes'] as int,
    json['commentCount'] as int,
    json['ballPower'] as int,
    json['activationTime'] == null
        ? null
        : DateTime.parse(json['activationTime'] as String),
    json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String),
    json['description'] as String,
    json['nickName'] as String,
    json['profilePicktureUrl'] as String,
    json['uid'] as String,
    (json['userLevel'] as num)?.toDouble(),
    json['contributor'] as int,
    json['ballDeleteFlag'] as bool,
  )..ballHits = json['ballHits'] as int;
}

Map<String, dynamic> _$FBallResDtoToJson(FBallResDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'ballUuid': instance.ballUuid,
      'ballName': instance.ballName,
      'ballType': _$FBallTypeEnumMap[instance.ballType],
      'ballState': _$FBallStateEnumMap[instance.ballState],
      'placeAddress': instance.placeAddress,
      'ballHits': instance.ballHits,
      'ballLikes': instance.ballLikes,
      'ballDisLikes': instance.ballDisLikes,
      'commentCount': instance.commentCount,
      'ballPower': instance.ballPower,
      'activationTime': instance.activationTime?.toIso8601String(),
      'makeTime': instance.makeTime?.toIso8601String(),
      'description': instance.description,
      'nickName': instance.nickName,
      'profilePicktureUrl': instance.profilePicktureUrl,
      'uid': instance.uid,
      'userLevel': instance.userLevel,
      'contributor': instance.contributor,
      'ballDeleteFlag': instance.ballDeleteFlag,
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
