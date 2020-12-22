// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PwFindPhoneAuthResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwFindPhoneAuthResDto _$PwFindPhoneAuthResDtoFromJson(
    Map<String, dynamic> json) {
  return PwFindPhoneAuthResDto()
    ..phoneNumber = json['phoneNumber'] as String
    ..internationalizedPhoneNumber =
        json['internationalizedPhoneNumber'] as String
    ..isoCode = json['isoCode'] as String
    ..authTime = json['authTime'] == null
        ? null
        : DateTime.parse(json['authTime'] as String)
    ..authRetryAvailableTime = json['authRetryAvailableTime'] == null
        ? null
        : DateTime.parse(json['authRetryAvailableTime'] as String)
    ..makeTime = json['makeTime'] == null
        ? null
        : DateTime.parse(json['makeTime'] as String)
    ..error = json['error'] as bool
    ..cause = json['cause'] as String;
}

Map<String, dynamic> _$PwFindPhoneAuthResDtoToJson(
        PwFindPhoneAuthResDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'internationalizedPhoneNumber': instance.internationalizedPhoneNumber,
      'isoCode': instance.isoCode,
      'authTime': instance.authTime?.toIso8601String(),
      'authRetryAvailableTime':
          instance.authRetryAvailableTime?.toIso8601String(),
      'makeTime': instance.makeTime?.toIso8601String(),
      'error': instance.error,
      'cause': instance.cause,
    };
