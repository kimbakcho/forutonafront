// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwFindPhoneAuthNumberResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwFindPhoneAuthNumberResDto _$PwFindPhoneAuthNumberResDtoFromJson(
    Map<String, dynamic> json) {
  return PwFindPhoneAuthNumberResDto()
    ..phoneAuthToken = json['phoneAuthToken'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..errorFlag = json['errorFlag'] as bool
    ..errorCause = json['errorCause'] as String
    ..email = json['email'] as String
    ..emailPhoneAuthToken = json['emailPhoneAuthToken'] as String;
}

Map<String, dynamic> _$PwFindPhoneAuthNumberResDtoToJson(
        PwFindPhoneAuthNumberResDto instance) =>
    <String, dynamic>{
      'phoneAuthToken': instance.phoneAuthToken,
      'phoneNumber': instance.phoneNumber,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'errorFlag': instance.errorFlag,
      'errorCause': instance.errorCause,
      'email': instance.email,
      'emailPhoneAuthToken': instance.emailPhoneAuthToken,
    };
