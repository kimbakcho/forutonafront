// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakerBallReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakerBallReqDto _$UserToMakerBallReqDtoFromJson(
    Map<String, dynamic> json) {
  return UserToMakerBallReqDto(
    json['makerUid'] as String,
    json['page'] as int,
    json['size'] as int,
    json['sorts'] as String,
  );
}

Map<String, dynamic> _$UserToMakerBallReqDtoToJson(
        UserToMakerBallReqDto instance) =>
    <String, dynamic>{
      'makerUid': instance.makerUid,
      'page': instance.page,
      'size': instance.size,
      'sorts': instance.sorts,
    };
