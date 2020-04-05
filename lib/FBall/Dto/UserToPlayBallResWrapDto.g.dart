// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToPlayBallResWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToPlayBallResWrapDto _$UserToPlayBallResWrapDtoFromJson(
    Map<String, dynamic> json) {
  return UserToPlayBallResWrapDto(
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : UserToPlayBallResDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToPlayBallResWrapDtoToJson(
        UserToPlayBallResWrapDto instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
