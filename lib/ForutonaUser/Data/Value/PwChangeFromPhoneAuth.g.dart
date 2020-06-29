// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwChangeFromPhoneAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwChangeFromPhoneAuth _$PwChangeFromPhoneAuthFromJson(
    Map<String, dynamic> json) {
  return PwChangeFromPhoneAuth()
    ..email = json['email'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..errorFlag = json['errorFlag'] as bool
    ..cause = json['cause'] as String;
}

Map<String, dynamic> _$PwChangeFromPhoneAuthToJson(
        PwChangeFromPhoneAuth instance) =>
    <String, dynamic>{
      'email': instance.email,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'errorFlag': instance.errorFlag,
      'cause': instance.cause,
    };
