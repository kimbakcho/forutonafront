// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyResDto _$FBallReplyResDtoFromJson(Map<String, dynamic> json) {
  return FBallReplyResDto()
    ..idx = json['idx'] as int
    ..ballUuid = json['ballUuid'] as String
    ..uid = json['uid'] as String
    ..replyNumber = json['replyNumber'] as int
    ..replySort = json['replySort'] as int
    ..replyDepth = json['replyDepth'] as int
    ..replyText = json['replyText'] as String
    ..replyUploadDateTime = json['replyUploadDateTime'] == null
        ? null
        : DateTime.parse(json['replyUploadDateTime'] as String)
    ..replyUpdateDateTime = json['replyUpdateDateTime'] == null
        ? null
        : DateTime.parse(json['replyUpdateDateTime'] as String)
    ..userNickName = json['userNickName'] as String
    ..userProfilePictureUrl = json['userProfilePictureUrl'] as String
    ..deleteFlag = json['deleteFlag'] as bool;
}

Map<String, dynamic> _$FBallReplyResDtoToJson(FBallReplyResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'ballUuid': instance.ballUuid,
      'uid': instance.uid,
      'replyNumber': instance.replyNumber,
      'replySort': instance.replySort,
      'replyDepth': instance.replyDepth,
      'replyText': instance.replyText,
      'replyUploadDateTime': instance.replyUploadDateTime?.toIso8601String(),
      'replyUpdateDateTime': instance.replyUpdateDateTime?.toIso8601String(),
      'userNickName': instance.userNickName,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
      'deleteFlag': instance.deleteFlag,
    };
