// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoJoinResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoJoinResDto _$FUserInfoJoinResDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoJoinResDto()
    ..customToken = json['customToken'] as String?
    ..joinComplete = json['joinComplete'] as bool?;
}

Map<String, dynamic> _$FUserInfoJoinResDtoToJson(
        FUserInfoJoinResDto instance) =>
    <String, dynamic>{
      'customToken': instance.customToken,
      'joinComplete': instance.joinComplete,
    };
