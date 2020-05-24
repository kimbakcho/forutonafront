// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToPlayBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToPlayBallResDto _$UserToPlayBallResDtoFromJson(Map<String, dynamic> json) {
  return UserToPlayBallResDto(
    json['joinTime'] == null
        ? null
        : DateTime.parse(json['joinTime'] as String),
  )..fballResDto = json['fballResDto'] == null
      ? null
      : FBallResDto.fromJson(json['fballResDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToPlayBallResDtoToJson(
        UserToPlayBallResDto instance) =>
    <String, dynamic>{
      'fballResDto': instance.fballResDto,
      'joinTime': instance.joinTime?.toIso8601String(),
    };
