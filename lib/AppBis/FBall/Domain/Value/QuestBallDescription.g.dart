// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestBallDescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestBallDescription _$QuestBallDescriptionFromJson(Map<String, dynamic> json) {
  return QuestBallDescription()
    ..text = json['text'] as String?
    ..desimages = (json['desimages'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : FBallDesImages.fromJson(e as Map<String, dynamic>))
        .toList()
    ..youtubeVideoId = json['youtubeVideoId'] as String?
    ..successSelectMode = _$enumDecodeNullable(
        _$QuestSelectModeEnumMap, json['successSelectMode'])
    ..checkInPositionLat = (json['checkInPositionLat'] as num?)?.toDouble()
    ..checkInPositionLong = (json['checkInPositionLong'] as num?)?.toDouble()
    ..checkInAddress = json['checkInAddress'] as String?
    ..photoCertificationDescription =
        json['photoCertificationDescription'] as String?
    ..limitTimeSec = json['limitTimeSec'] as int?
    ..startPositionLat = (json['startPositionLat'] as num?)?.toDouble()
    ..startPositionLong = (json['startPositionLong'] as num?)?.toDouble()
    ..startPositionAddress = json['startPositionAddress'] as String?
    ..timeLimitFlag = json['timeLimitFlag'] as bool?
    ..startPositionFlag = json['startPositionFlag'] as bool?
    ..isOpenCheckInPosition = json['isOpenCheckInPosition'] as bool?
    ..qualifyingForQuestText = json['qualifyingForQuestText'] as String?;
}

Map<String, dynamic> _$QuestBallDescriptionToJson(
        QuestBallDescription instance) =>
    <String, dynamic>{
      'text': instance.text,
      'desimages': instance.desimages,
      'youtubeVideoId': instance.youtubeVideoId,
      'successSelectMode': _$QuestSelectModeEnumMap[instance.successSelectMode],
      'checkInPositionLat': instance.checkInPositionLat,
      'checkInPositionLong': instance.checkInPositionLong,
      'checkInAddress': instance.checkInAddress,
      'photoCertificationDescription': instance.photoCertificationDescription,
      'limitTimeSec': instance.limitTimeSec,
      'startPositionLat': instance.startPositionLat,
      'startPositionLong': instance.startPositionLong,
      'startPositionAddress': instance.startPositionAddress,
      'timeLimitFlag': instance.timeLimitFlag,
      'startPositionFlag': instance.startPositionFlag,
      'isOpenCheckInPosition': instance.isOpenCheckInPosition,
      'qualifyingForQuestText': instance.qualifyingForQuestText,
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

const _$QuestSelectModeEnumMap = {
  QuestSelectMode.PhotoCertification: 'PhotoCertification',
  QuestSelectMode.CheckInWithPhotoCertification:
      'CheckInWithPhotoCertification',
  QuestSelectMode.None: 'None',
};
