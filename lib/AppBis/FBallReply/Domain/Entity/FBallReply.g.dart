// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReply _$FBallReplyFromJson(Map<String, dynamic> json) {
  return FBallReply()
    ..replyUuid = json['replyUuid'] as String?
    ..ballUuid = json['ballUuid'] as String?
    ..uid = json['uid'] as String?
    ..replyNumber = json['replyNumber'] as int?
    ..replySort = json['replySort'] as int?
    ..replyDepth = json['replyDepth'] as int?
    ..replyUploadDateTime = json['replyUploadDateTime'] == null
        ? null
        : DateTime.parse(json['replyUploadDateTime'] as String)
    ..replyUpdateDateTime = json['replyUpdateDateTime'] == null
        ? null
        : DateTime.parse(json['replyUpdateDateTime'] as String)
    ..deleteFlag = json['deleteFlag'] as bool?
    ..subReplyCount = json['subReplyCount'] as int?
    ..replyText = json['replyText'] as String
    ..userNickName = json['userNickName'] as String
    ..userProfilePictureUrl = json['userProfilePictureUrl'] as String?
    ..fBallSubReplys = (json['fBallSubReplys'] as List<dynamic>)
        .map((e) => FBallReply.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FBallReplyToJson(FBallReply instance) =>
    <String, dynamic>{
      'replyUuid': instance.replyUuid,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'replyNumber': instance.replyNumber,
      'replySort': instance.replySort,
      'replyDepth': instance.replyDepth,
      'replyUploadDateTime': instance.replyUploadDateTime?.toIso8601String(),
      'replyUpdateDateTime': instance.replyUpdateDateTime?.toIso8601String(),
      'deleteFlag': instance.deleteFlag,
      'subReplyCount': instance.subReplyCount,
      'replyText': instance.replyText,
      'userNickName': instance.userNickName,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
      'fBallSubReplys': instance.fBallSubReplys,
    };
