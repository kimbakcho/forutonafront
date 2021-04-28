// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserSnsCheckJoinResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserSnsCheckJoinResDto _$FUserSnsCheckJoinResDtoFromJson(
    Map<String, dynamic> json) {
  return FUserSnsCheckJoinResDto()
    ..snsUid = json['snsUid'] as String?
    ..pictureUrl = json['pictureUrl'] as String?
    ..email = json['email'] as String?
    ..userSnsName = json['userSnsName'] as String?
    ..join = json['join'] as bool
    ..firebaseCustomToken = json['firebaseCustomToken'] as String?;
}

Map<String, dynamic> _$FUserSnsCheckJoinResDtoToJson(
        FUserSnsCheckJoinResDto instance) =>
    <String, dynamic>{
      'snsUid': instance.snsUid,
      'pictureUrl': instance.pictureUrl,
      'email': instance.email,
      'userSnsName': instance.userSnsName,
      'join': instance.join,
      'firebaseCustomToken': instance.firebaseCustomToken,
    };
