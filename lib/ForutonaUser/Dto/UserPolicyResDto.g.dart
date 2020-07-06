// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPolicyResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPolicyResDto _$UserPolicyResDtoFromJson(Map<String, dynamic> json) {
  return UserPolicyResDto()
    ..policyName = json['policyName'] as String
    ..policyContent = json['policyContent'] as String
    ..lang = json['lang'] as String
    ..writeDateTime = json['writeDateTime'] == null
        ? null
        : DateTime.parse(json['writeDateTime'] as String);
}

Map<String, dynamic> _$UserPolicyResDtoToJson(UserPolicyResDto instance) =>
    <String, dynamic>{
      'policyName': instance.policyName,
      'policyContent': instance.policyContent,
      'lang': instance.lang,
      'writeDateTime': instance.writeDateTime?.toIso8601String(),
    };
