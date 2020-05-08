// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhoneAuthReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneAuthReqDto _$PhoneAuthReqDtoFromJson(Map<String, dynamic> json) {
  return PhoneAuthReqDto()
    ..phoneNumber = json['phoneNumber'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..isoCode = json['isoCode'] as String;
}

Map<String, dynamic> _$PhoneAuthReqDtoToJson(PhoneAuthReqDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'isoCode': instance.isoCode,
    };
