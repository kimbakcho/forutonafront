// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhoneAuthNumberResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneAuthNumberResDto _$PhoneAuthNumberResDtoFromJson(
    Map<String, dynamic> json) {
  return PhoneAuthNumberResDto()
    ..phoneAuthToken = json['phoneAuthToken'] as String?
    ..phoneNumber = json['phoneNumber'] as String?
    ..internationalizedDialCode = json['internationalizedDialCode'] as String?
    ..errorFlag = json['errorFlag'] as bool?
    ..errorCause = json['errorCause'] as String?;
}

Map<String, dynamic> _$PhoneAuthNumberResDtoToJson(
        PhoneAuthNumberResDto instance) =>
    <String, dynamic>{
      'phoneAuthToken': instance.phoneAuthToken,
      'phoneNumber': instance.phoneNumber,
      'internationalizedDialCode': instance.internationalizedDialCode,
      'errorFlag': instance.errorFlag,
      'errorCause': instance.errorCause,
    };
