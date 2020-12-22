// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwChangeFromPhoneAuthReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwChangeFromPhoneAuthReqDto _$PwChangeFromPhoneAuthReqDtoFromJson(
    Map<String, dynamic> json) {
  return PwChangeFromPhoneAuthReqDto()
    ..password = json['password'] as String
    ..email = json['email'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..emailPhoneAuthToken = json['emailPhoneAuthToken'] as String;
}

Map<String, dynamic> _$PwChangeFromPhoneAuthReqDtoToJson(
        PwChangeFromPhoneAuthReqDto instance) =>
    <String, dynamic>{
      'password': instance.password,
      'email': instance.email,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'emailPhoneAuthToken': instance.emailPhoneAuthToken,
    };
