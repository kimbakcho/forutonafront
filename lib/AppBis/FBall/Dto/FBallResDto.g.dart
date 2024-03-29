// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallResDto _$FBallResDtoFromJson(Map<String, dynamic> json) {
  return FBallResDto()
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..longitude = (json['longitude'] as num?)?.toDouble()
    ..ballUuid = json['ballUuid'] as String?
    ..ballName = json['ballName'] as String?
    ..ballType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType'])
    ..ballState = _$enumDecodeNullable(_$FBallStateEnumMap, json['ballState'])
    ..placeAddress = json['placeAddress'] as String?
    ..ballHits = json['ballHits'] as int?
    ..ballLikes = json['ballLikes'] as int?
    ..ballDisLikes = json['ballDisLikes'] as int?
    ..commentCount = json['commentCount'] as int?
    ..ballPower = json['ballPower'] as int?
    ..activationTime = json['activationTime'] == null
        ? null
        : DateTime.parse(json['activationTime'] as String)
    ..makeTime = json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String)
    ..description = json['description'] as String?
    ..uid = json['uid'] == null
        ? null
        : FUserInfoSimpleResDto.fromJson(json['uid'] as Map<String, dynamic>)
    ..contributor = json['contributor'] as int?
    ..ballDeleteFlag = json['ballDeleteFlag'] as bool
    ..isEditContent = json['isEditContent'] as bool?
    ..editContentTime = json['editContentTime'] == null
        ? null
        : DateTime.parse(json['editContentTime'] as String)
    ..replyCount = json['replyCount'] as int?;
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
      'uid': instance.uid?.toJson(),
      'contributor': instance.contributor,
      'ballDeleteFlag': instance.ballDeleteFlag,
      'isEditContent': instance.isEditContent,
      'editContentTime': instance.editContentTime?.toIso8601String(),
      'replyCount': instance.replyCount,
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

const _$FBallStateEnumMap = {
  FBallState.Wait: 'Wait',
  FBallState.Play: 'Play',
  FBallState.Finish: 'Finish',
};
