// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallInsertReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallInsertReqDto _$FBallInsertReqDtoFromJson(Map<String, dynamic> json) {
  return FBallInsertReqDto()
    ..ballUuid = json['ballUuid'] as String
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..ballName = json['ballName'] as String
    ..ballType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType'])
    ..placeAddress = json['placeAddress'] as String
    ..administrativeArea = json['administrativeArea'] as String
    ..country = json['country'] as String
    ..ballPassword = json['ballPassword'] as String
    ..maximumPlayers = json['maximumPlayers'] as int
    ..description = json['description'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null
            ? null
            : TagInsertReqDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallInsertReqDtoToJson(FBallInsertReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'ballName': instance.ballName,
      'ballType': _$FBallTypeEnumMap[instance.ballType],
      'placeAddress': instance.placeAddress,
      'administrativeArea': instance.administrativeArea,
      'country': instance.country,
      'ballPassword': instance.ballPassword,
      'maximumPlayers': instance.maximumPlayers,
      'description': instance.description,
      'tags': instance.tags,
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