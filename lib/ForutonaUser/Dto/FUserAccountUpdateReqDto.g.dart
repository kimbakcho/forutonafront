// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserAccountUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserAccountUpdateReqDto _$FUserAccountUpdateReqDtoFromJson(
    Map<String, dynamic> json) {
  return FUserAccountUpdateReqDto()
    ..isoCode = json['isoCode'] as String
    ..nickName = json['nickName'] as String
    ..selfIntroduction = json['selfIntroduction'] as String
    ..userProfileImageUrl = json['userProfileImageUrl'] as String;
}

Map<String, dynamic> _$FUserAccountUpdateReqDtoToJson(
        FUserAccountUpdateReqDto instance) =>
    <String, dynamic>{
      'isoCode': instance.isoCode,
      'nickName': instance.nickName,
      'selfIntroduction': instance.selfIntroduction,
      'userProfileImageUrl': instance.userProfileImageUrl,
    };
