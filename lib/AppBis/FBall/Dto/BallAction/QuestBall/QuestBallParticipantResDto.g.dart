// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestBallParticipantResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestBallParticipantResDto _$QuestBallParticipantResDtoFromJson(
    Map<String, dynamic> json) {
  return QuestBallParticipantResDto()
    ..idx = json['idx'] as int?
    ..ballUuid = json['ballUuid'] as String?
    ..uid = json['uid'] == null
        ? null
        : FUserInfoSimpleResDto.fromJson(json['uid'] as Map<String, dynamic>)
    ..participationTime = json['participationTime'] == null
        ? null
        : DateTime.parse(json['participationTime'] as String)
    ..photoShotForCertificationImage =
        json['photoShotForCertificationImage'] as String?
    ..checkInPositionLat = (json['checkInPositionLat'] as num?)?.toDouble()
    ..checkInPositionLng = (json['checkInPositionLng'] as num?)?.toDouble()
    ..startPositionLat = (json['startPositionLat'] as num?)?.toDouble()
    ..startPositionLng = (json['startPositionLng'] as num?)?.toDouble()
    ..likePoint = json['likePoint'] as int?
    ..dislikePoint = json['dislikePoint'] as int?
    ..currentState = _$enumDecodeNullable(
        _$QuestBallParticipateStateEnumMap, json['currentState']);
}

Map<String, dynamic> _$QuestBallParticipantResDtoToJson(
        QuestBallParticipantResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'participationTime': instance.participationTime?.toIso8601String(),
      'photoShotForCertificationImage': instance.photoShotForCertificationImage,
      'checkInPositionLat': instance.checkInPositionLat,
      'checkInPositionLng': instance.checkInPositionLng,
      'startPositionLat': instance.startPositionLat,
      'startPositionLng': instance.startPositionLng,
      'likePoint': instance.likePoint,
      'dislikePoint': instance.dislikePoint,
      'currentState': _$QuestBallParticipateStateEnumMap[instance.currentState],
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

const _$QuestBallParticipateStateEnumMap = {
  QuestBallParticipateState.Wait: 'Wait',
  QuestBallParticipateState.Accept: 'Accept',
  QuestBallParticipateState.Finish: 'Finish',
  QuestBallParticipateState.ForceOut: 'ForceOut',
  QuestBallParticipateState.SelfOut: 'SelfOut',
};
