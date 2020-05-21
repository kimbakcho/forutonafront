// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakerBallSelectReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakerBallSelectReqDto _$UserToMakerBallSelectReqDtoFromJson(
    Map<String, dynamic> json) {
  return UserToMakerBallSelectReqDto(
    json['makerUid'] as String,
    json['ballUuid'] as String,
  );
}

Map<String, dynamic> _$UserToMakerBallSelectReqDtoToJson(
        UserToMakerBallSelectReqDto instance) =>
    <String, dynamic>{
      'makerUid': instance.makerUid,
      'ballUuid': instance.ballUuid,
    };
