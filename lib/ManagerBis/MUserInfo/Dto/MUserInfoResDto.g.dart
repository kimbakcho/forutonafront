// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MUserInfoResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUserInfoResDto _$MUserInfoResDtoFromJson(Map<String, dynamic> json) {
  return MUserInfoResDto()
    ..uid = json['uid'] as String
    ..userUuid = json['userUuid'] as String
    ..userName = json['userName'] as String
    ..groupName = json['groupName'] as String
    ..hasRole = json['hasRole'] as String;
}

Map<String, dynamic> _$MUserInfoResDtoToJson(MUserInfoResDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userUuid': instance.userUuid,
      'userName': instance.userName,
      'groupName': instance.groupName,
      'hasRole': instance.hasRole,
    };
