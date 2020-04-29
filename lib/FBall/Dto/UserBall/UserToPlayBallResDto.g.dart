// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToPlayBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToPlayBallResDto _$UserToPlayBallResDtoFromJson(Map<String, dynamic> json) {
  return UserToPlayBallResDto(
    json['joinTime'] == null
        ? null
        : DateTime.parse(json['joinTime'] as String),
  )
    ..fBallUuid = json['fballUuid'] as String
    ..fBallType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['fballType'])
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..ballName = json['ballName'] as String
    ..ballPlaceAddress = json['ballPlaceAddress'] as String
    ..ballLikes = json['ballLikes'] as int
    ..ballDisLikes = json['ballDisLikes'] as int
    ..commentCount = json['commentCount'] as int
    ..activationTime = json['activationTime'] == null
        ? null
        : DateTime.parse(json['activationTime'] as String)
    ..makeTime = json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String)
    ..distanceWithMapCenter = (json['distanceWithMapCenter'] as num)?.toDouble()
    ..distanceDisplayText = json['distanceDisplayText'] as String;
}

Map<String, dynamic> _$UserToPlayBallResDtoToJson(
        UserToPlayBallResDto instance) =>
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
      'joinTime': instance.joinTime?.toIso8601String(),
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
