// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToPlayBallWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToPlayBallWrap _$UserToPlayBallWrapFromJson(Map<String, dynamic> json) {
  return UserToPlayBallWrap(
    json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String),
    (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : UserToPlayBall.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToPlayBallWrapToJson(UserToPlayBallWrap instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
