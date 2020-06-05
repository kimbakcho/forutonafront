// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakeBallSelectReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakeBallSelectReqDto _$UserToMakeBallSelectReqDtoFromJson(
    Map<String, dynamic> json) {
  return UserToMakeBallSelectReqDto(
    json['makerUid'] as String,
    json['ballUuid'] as String,
  );
}

Map<String, dynamic> _$UserToMakeBallSelectReqDtoToJson(
        UserToMakeBallSelectReqDto instance) =>
    <String, dynamic>{
      'makerUid': instance.makerUid,
      'ballUuid': instance.ballUuid,
    };
