// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FuserAccountUpdateReqdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuserAccountUpdateReqdto _$FuserAccountUpdateReqdtoFromJson(
    Map<String, dynamic> json) {
  return FuserAccountUpdateReqdto()
    ..isoCode = json['isoCode'] as String
    ..nickName = json['nickName'] as String
    ..selfIntroduction = json['selfIntroduction'] as String
    ..userProfileImageUrl = json['userProfileImageUrl'] as String;
}

Map<String, dynamic> _$FuserAccountUpdateReqdtoToJson(
        FuserAccountUpdateReqdto instance) =>
    <String, dynamic>{
      'isoCode': instance.isoCode,
      'nickName': instance.nickName,
      'selfIntroduction': instance.selfIntroduction,
      'userProfileImageUrl': instance.userProfileImageUrl,
    };
