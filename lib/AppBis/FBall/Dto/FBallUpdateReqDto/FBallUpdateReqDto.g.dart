// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallUpdateReqDto _$FBallUpdateReqDtoFromJson(Map<String, dynamic> json) {
  return FBallUpdateReqDto()
    ..ballUuid = json['ballUuid'] as String?
    ..longitude = (json['longitude'] as num?)?.toDouble()
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..ballName = json['ballName'] as String?
    ..ballType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType'])
    ..placeAddress = json['placeAddress'] as String?
    ..description = json['description'] as String?
    ..tags = (json['tags'] as List<dynamic>?)
        ?.map((e) => TagInsertReqDto.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FBallUpdateReqDtoToJson(FBallUpdateReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'ballName': instance.ballName,
      'ballType': _$FBallTypeEnumMap[instance.ballType],
      'placeAddress': instance.placeAddress,
      'description': instance.description,
      'tags': instance.tags,
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
