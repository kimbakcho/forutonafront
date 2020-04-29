// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBallResDto _$UserBallResDtoFromJson(Map<String, dynamic> json) {
  return UserBallResDto(
    json['fballUuid'] as String,
    _$enumDecodeNullable(_$FBallTypeEnumMap, json['fballType']),
    (json['longitude'] as num)?.toDouble(),
    (json['latitude'] as num)?.toDouble(),
    json['ballName'] as String,
    json['ballPlaceAddress'] as String,
    json['ballLikes'] as int,
    json['ballDisLikes'] as int,
    json['commentCount'] as int,
    json['activationTime'] == null
        ? null
        : DateTime.parse(json['activationTime'] as String),
    json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String),
    (json['distanceWithMapCenter'] as num)?.toDouble(),
    json['distanceDisplayText'] as String,
  );
}

Map<String, dynamic> _$UserBallResDtoToJson(UserBallResDto instance) =>
    <String, dynamic>{
      'fballUuid': instance.fBallUuid,
      'fballType': _$FBallTypeEnumMap[instance.fBallType],
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'ballName': instance.ballName,
      'ballPlaceAddress': instance.ballPlaceAddress,
      'ballLikes': instance.ballLikes,
      'ballDisLikes': instance.ballDisLikes,
      'commentCount': instance.commentCount,
      'activationTime': instance.activationTime?.toIso8601String(),
      'makeTime': instance.makeTime?.toIso8601String(),
      'distanceWithMapCenter': instance.distanceWithMapCenter,
      'distanceDisplayText': instance.distanceDisplayText,
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
