// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FCMReplyDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMReplyDto _$FCMReplyDtoFromJson(Map<String, dynamic> json) {
  return FCMReplyDto()
    ..replyUserUid = json['replyUserUid'] as String
    ..nickName = json['nickName'] as String
    ..replyText = json['replyText'] as String
    ..userProfileImageUrl = json['userProfileImageUrl'] as String
    ..ballUuid = json['ballUuid'] as String;
}

Map<String, dynamic> _$FCMReplyDtoToJson(FCMReplyDto instance) =>
    <String, dynamic>{
      'replyUserUid': instance.replyUserUid,
      'nickName': instance.nickName,
      'replyText': instance.replyText,
      'userProfileImageUrl': instance.userProfileImageUrl,
      'ballUuid': instance.ballUuid,
    };
