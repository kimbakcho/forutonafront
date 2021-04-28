// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhoneAuthResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneAuthResDto _$PhoneAuthResDtoFromJson(Map<String, dynamic> json) {
  return PhoneAuthResDto()
    ..phoneNumber = json['phoneNumber'] as String?
    ..internationalizedDialCode = json['internationalizedDialCode'] as String?
    ..isoCode = json['isoCode'] as String?
    ..authTime = json['authTime'] == null
        ? null
        : DateTime.parse(json['authTime'] as String)
    ..authRetryAvailableTime = json['authRetryAvailableTime'] == null
        ? null
        : DateTime.parse(json['authRetryAvailableTime'] as String)
    ..makeTime = json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String);
}

Map<String, dynamic> _$PhoneAuthResDtoToJson(PhoneAuthResDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'internationalizedDialCode': instance.internationalizedDialCode,
      'isoCode': instance.isoCode,
      'authTime': instance.authTime?.toIso8601String(),
      'authRetryAvailableTime':
          instance.authRetryAvailableTime?.toIso8601String(),
      'makeTime': instance.makeTime?.toIso8601String(),
    };
