// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPolicyResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPolicyResDto _$UserPolicyResDtoFromJson(Map<String, dynamic> json) {
  return UserPolicyResDto(
    json['policyName'] as String,
    json['policyContent'] as String,
    json['lang'] as String,
    json['writeDateTime'] == null
        ? null
        : DateTime.parse(json['writeDateTime'] as String),
  );
}

Map<String, dynamic> _$UserPolicyResDtoToJson(UserPolicyResDto instance) =>
    <String, dynamic>{
      'policyName': instance.policyName,
      'policyContent': instance.policyContent,
      'lang': instance.lang,
      'writeDateTime': instance.writeDateTime?.toIso8601String(),
    };
