// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IssueBall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueBall _$IssueBallFromJson(Map<String, dynamic> json) {
  return IssueBall()
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..ballUuid = json['ballUuid'] as String
    ..ballType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType'])
    ..ballState = _$enumDecodeNullable(_$FBallStateEnumMap, json['ballState'])
    ..ballHits = json['ballHits'] as int
    ..ballLikes = json['ballLikes'] as int
    ..ballDisLikes = json['ballDisLikes'] as int
    ..commentCount = json['commentCount'] as int
    ..ballPower = json['ballPower'] as int
    ..activationTime = json['activationTime'] == null
        ? null
        : DateTime.parse(json['activationTime'] as String)
    ..makeTime = json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String)
    ..uid = json['uid'] as String
    ..userLevel = (json['userLevel'] as num)?.toDouble()
    ..contributor = json['contributor'] as int
    ..ballDeleteFlag = json['ballDeleteFlag'] as bool
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : FBallTag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..desImages = (json['desImages'] as List)
        ?.map((e) => e == null
            ? null
            : FBallDesImages.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..descriptionText = json['descriptionText']
    ..youtubeVideoId = json['youtubeVideoId'];
}

Map<String, dynamic> _$IssueBallToJson(IssueBall instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'ballUuid': instance.ballUuid,
      'ballType': _$FBallTypeEnumMap[instance.ballType],
      'ballState': _$FBallStateEnumMap[instance.ballState],
      'ballHits': instance.ballHits,
      'ballLikes': instance.ballLikes,
      'ballDisLikes': instance.ballDisLikes,
      'commentCount': instance.commentCount,
      'ballPower': instance.ballPower,
      'activationTime': instance.activationTime?.toIso8601String(),
      'makeTime': instance.makeTime?.toIso8601String(),
      'uid': instance.uid,
      'userLevel': instance.userLevel,
      'contributor': instance.contributor,
      'ballDeleteFlag': instance.ballDeleteFlag,
      'tags': instance.tags,
      'desImages': instance.desImages,
      'descriptionText': instance.descriptionText,
      'youtubeVideoId': instance.youtubeVideoId,
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
