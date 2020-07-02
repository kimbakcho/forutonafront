// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPolicy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPolicy _$UserPolicyFromJson(Map<String, dynamic> json) {
  return UserPolicy()
    ..policyName = json['policyName'] as String
    ..policyContent = json['policyContent'] as String
    ..lang = json['lang'] as String
    ..writeDateTime = json['writeDateTime'] == null
        ? null
        : DateTime.parse(json['writeDateTime'] as String);
}

Map<String, dynamic> _$UserPolicyToJson(UserPolicy instance) =>
    <String, dynamic>{
      'policyName': instance.policyName,
      'policyContent': instance.policyContent,
      'lang': instance.lang,
      'writeDateTime': instance.writeDateTime?.toIso8601String(),
    };
