// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoJoin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoJoin _$FUserInfoJoinFromJson(Map<String, dynamic> json) {
  return FUserInfoJoin()
    ..customToken = json['customToken'] as String
    ..joinComplete = json['joinComplete'] as bool;
}

Map<String, dynamic> _$FUserInfoJoinToJson(FUserInfoJoin instance) =>
    <String, dynamic>{
      'customToken': instance.customToken,
      'joinComplete': instance.joinComplete,
    };
