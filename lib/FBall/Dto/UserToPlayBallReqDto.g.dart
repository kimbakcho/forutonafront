// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToPlayBallReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToPlayBallReqDto _$UserToPlayBallReqDtoFromJson(Map<String, dynamic> json) {
  return UserToPlayBallReqDto(
    json['playerUid'] as String,
    json['page'] as int,
    json['size'] as int,
    json['sorts'] as String,
  );
}

Map<String, dynamic> _$UserToPlayBallReqDtoToJson(
        UserToPlayBallReqDto instance) =>
    <String, dynamic>{
      'playerUid': instance.playerUid,
      'page': instance.page,
      'size': instance.size,
      'sorts': instance.sorts,
    };
