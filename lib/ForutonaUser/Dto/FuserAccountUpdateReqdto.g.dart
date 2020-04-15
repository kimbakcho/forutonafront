// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FuserAccountUpdateReqdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuserAccountUpdateReqdto _$FuserAccountUpdateReqdtoFromJson(
    Map<String, dynamic> json) {
  return FuserAccountUpdateReqdto(
    json['isoCode'] as String,
    json['nickName'] as String,
    json['selfIntroduction'] as String,
  );
}

Map<String, dynamic> _$FuserAccountUpdateReqdtoToJson(
        FuserAccountUpdateReqdto instance) =>
    <String, dynamic>{
      'isoCode': instance.isoCode,
      'nickName': instance.nickName,
      'selfIntroduction': instance.selfIntroduction,
    };
