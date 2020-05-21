// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToPlayBallSelectReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToPlayBallSelectReqDto _$UserToPlayBallSelectReqDtoFromJson(
    Map<String, dynamic> json) {
  return UserToPlayBallSelectReqDto(
    json['playerUid'] as String,
    json['ballUuid'] as String,
  );
}

Map<String, dynamic> _$UserToPlayBallSelectReqDtoToJson(
        UserToPlayBallSelectReqDto instance) =>
    <String, dynamic>{
      'playerUid': instance.playerUid,
      'ballUuid': instance.ballUuid,
    };
