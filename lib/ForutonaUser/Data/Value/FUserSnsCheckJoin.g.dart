// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FUserSnsCheckJoin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FUserSnsCheckJoin _$FUserSnsCheckJoinFromJson(Map<String, dynamic> json) {
  return FUserSnsCheckJoin()
    ..snsUid = json['snsUid'] as String
    ..pictureUrl = json['pictureUrl'] as String
    ..email = json['email'] as String
    ..userSnsName = json['userSnsName'] as String
    ..join = json['join'] as bool
    ..firebaseCustomToken = json['firebaseCustomToken'] as String;
}

Map<String, dynamic> _$FUserSnsCheckJoinToJson(FUserSnsCheckJoin instance) =>
    <String, dynamic>{
      'snsUid': instance.snsUid,
      'pictureUrl': instance.pictureUrl,
      'email': instance.email,
      'userSnsName': instance.userSnsName,
      'join': instance.join,
      'firebaseCustomToken': instance.firebaseCustomToken,
    };
