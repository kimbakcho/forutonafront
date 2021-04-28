// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhoneAuthNumberReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneAuthNumberReqDto _$PhoneAuthNumberReqDtoFromJson(
    Map<String, dynamic> json) {
  return PhoneAuthNumberReqDto()
    ..phoneNumber = json['phoneNumber'] as String?
    ..internationalizedDialCode = json['internationalizedDialCode'] as String?
    ..isoCode = json['isoCode'] as String?
    ..authNumber = json['authNumber'] as String?;
}

Map<String, dynamic> _$PhoneAuthNumberReqDtoToJson(
        PhoneAuthNumberReqDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'internationalizedDialCode': instance.internationalizedDialCode,
      'isoCode': instance.isoCode,
      'authNumber': instance.authNumber,
    };
