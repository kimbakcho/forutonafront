// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakeBallReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakeBallReqDto _$UserToMakeBallReqDtoFromJson(Map<String, dynamic> json) {
  return UserToMakeBallReqDto(
    json['makerUid'] as String,
    json['page'] as int,
    json['size'] as int,
    json['sorts'] as String,
  );
}

Map<String, dynamic> _$UserToMakeBallReqDtoToJson(
        UserToMakeBallReqDto instance) =>
    <String, dynamic>{
      'makerUid': instance.makerUid,
      'page': instance.page,
      'size': instance.size,
      'sorts': instance.sorts,
    };
