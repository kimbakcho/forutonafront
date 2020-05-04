// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserInfoJoinReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserInfoJoinReqDto _$FUserInfoJoinReqDtoFromJson(Map<String, dynamic> json) {
  return FUserInfoJoinReqDto()
    ..forutonaAgree = json['forutonaAgree'] as bool
    ..privateAgree = json['privateAgree'] as bool
    ..positionAgree = json['positionAgree'] as bool
    ..martketingAgree = json['martketingAgree'] as bool
    ..ageLimitAgree = json['ageLimitAgree'] as bool;
}

Map<String, dynamic> _$FUserInfoJoinReqDtoToJson(
        FUserInfoJoinReqDto instance) =>
    <String, dynamic>{
      'forutonaAgree': instance.forutonaAgree,
      'privateAgree': instance.privateAgree,
      'positionAgree': instance.positionAgree,
      'martketingAgree': instance.martketingAgree,
      'ageLimitAgree': instance.ageLimitAgree,
    };
