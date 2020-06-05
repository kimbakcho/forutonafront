// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakeBallResWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakeBallResWrapDto _$UserToMakeBallResWrapDtoFromJson(
    Map<String, dynamic> json) {
  return UserToMakeBallResWrapDto(
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : UserToMakeBallResDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToMakeBallResWrapDtoToJson(
        UserToMakeBallResWrapDto instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
