// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwFindPhoneAuthReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwFindPhoneAuthReqDto _$PwFindPhoneAuthReqDtoFromJson(
    Map<String, dynamic> json) {
  return PwFindPhoneAuthReqDto()
    ..phoneNumber = json['phoneNumber'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..isoCode = json['isoCode'] as String
    ..email = json['email'] as String
    ..emailPhoneAuthToken = json['emailPhoneAuthToken'] as String;
}

Map<String, dynamic> _$PwFindPhoneAuthReqDtoToJson(
        PwFindPhoneAuthReqDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'isoCode': instance.isoCode,
      'email': instance.email,
      'emailPhoneAuthToken': instance.emailPhoneAuthToken,
    };
