// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallUpdateReqDto _$FBallUpdateReqDtoFromJson(Map<String, dynamic> json) {
  return FBallUpdateReqDto()
    ..ballUuid = json['ballUuid'] as String
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..ballName = json['ballName'] as String
    ..ballType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['ballType'])
    ..placeAddress = json['placeAddress'] as String
    ..description = json['description'] as String;
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
