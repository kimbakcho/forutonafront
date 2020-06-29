// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhoneAuthNumber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneAuthNumber _$PhoneAuthNumberFromJson(Map<String, dynamic> json) {
  return PhoneAuthNumber()
    ..phoneAuthToken = json['phoneAuthToken'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..errorFlag = json['errorFlag'] as bool
    ..errorCause = json['errorCause'] as String;
}

Map<String, dynamic> _$PhoneAuthNumberToJson(PhoneAuthNumber instance) =>
    <String, dynamic>{
      'phoneAuthToken': instance.phoneAuthToken,
      'phoneNumber': instance.phoneNumber,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'errorFlag': instance.errorFlag,
      'errorCause': instance.errorCause,
    };
