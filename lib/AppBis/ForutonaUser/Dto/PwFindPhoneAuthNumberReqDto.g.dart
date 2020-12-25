// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwFindPhoneAuthNumberReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwFindPhoneAuthNumberReqDto _$PwFindPhoneAuthNumberReqDtoFromJson(
    Map<String, dynamic> json) {
  return PwFindPhoneAuthNumberReqDto()
    ..phoneNumber = json['phoneNumber'] as String
    ..internationalizedDialCode = json['internationalizedDialCode'] as String
    ..isoCode = json['isoCode'] as String
    ..authNumber = json['authNumber'] as String
    ..email = json['email'] as String;
}

Map<String, dynamic> _$PwFindPhoneAuthNumberReqDtoToJson(
        PwFindPhoneAuthNumberReqDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'internationalizedDialCode': instance.internationalizedDialCode,
      'isoCode': instance.isoCode,
      'authNumber': instance.authNumber,
      'email': instance.email,
    };
