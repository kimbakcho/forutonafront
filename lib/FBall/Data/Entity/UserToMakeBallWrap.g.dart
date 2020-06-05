// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakeBallWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakeBallWrap _$UserToMakeBallWrapFromJson(Map<String, dynamic> json) {
  return UserToMakeBallWrap()
    ..searchTime = json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String)
    ..contents = (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : UserToMakeBall.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToMakeBallWrapToJson(UserToMakeBallWrap instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
