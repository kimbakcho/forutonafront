// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FCMReplyDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMReplyDto _$FCMReplyDtoFromJson(Map<String, dynamic> json) {
  return FCMReplyDto()
    ..replyUserUid = json['replyUserUid'] as String?
    ..nickName = json['nickName'] as String?
    ..replyText = json['replyText'] as String?
    ..userProfileImageUrl = json['userProfileImageUrl'] as String?
    ..ballUuid = json['ballUuid'] as String?
    ..replyTitleType = json['replyTitleType'] as String?
    ..fBallType = _$enumDecodeNullable(_$FBallTypeEnumMap, json['fBallType']);
}

Map<String, dynamic> _$FCMReplyDtoToJson(FCMReplyDto instance) =>
    <String, dynamic>{
      'replyUserUid': instance.replyUserUid,
      'nickName': instance.nickName,
      'replyText': instance.replyText,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'ballUuid': instance.ballUuid,
      'replyTitleType': instance.replyTitleType,
      'fBallType': _$FBallTypeEnumMap[instance.fBallType],
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
