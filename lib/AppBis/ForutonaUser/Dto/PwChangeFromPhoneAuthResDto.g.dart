// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwChangeFromPhoneAuthResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwChangeFromPhoneAuthResDto _$PwChangeFromPhoneAuthResDtoFromJson(
    Map<String, dynamic> json) {
  return PwChangeFromPhoneAuthResDto()
    ..email = json['email'] as String?
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String?
    ..errorFlag = json['errorFlag'] as bool?
    ..cause = json['cause'] as String?;
}

Map<String, dynamic> _$PwChangeFromPhoneAuthResDtoToJson(
        PwChangeFromPhoneAuthResDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'errorFlag': instance.errorFlag,
      'cause': instance.cause,
    };
