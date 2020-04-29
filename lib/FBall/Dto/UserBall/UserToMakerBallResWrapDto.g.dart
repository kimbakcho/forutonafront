// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakerBallResWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakerBallResWrapDto _$UserToMakerBallResWrapDtoFromJson(
    Map<String, dynamic> json) {
  return UserToMakerBallResWrapDto(
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : UserToMakerBallResDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToMakerBallResWrapDtoToJson(
        UserToMakerBallResWrapDto instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
