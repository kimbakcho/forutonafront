// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyResDto _$FBallReplyResDtoFromJson(Map<String, dynamic> json) {
  return FBallReplyResDto()
    ..replyUuid = json['replyUuid'] as String?
    ..ballUuid = json['ballUuid'] == null
        ? null
        : FBallResDto.fromJson(json['ballUuid'] as Map<String, dynamic>)
    ..uid = json['uid'] == null
        ? null
        : FUserInfoSimpleResDto.fromJson(json['uid'] as Map<String, dynamic>)
    ..replyNumber = json['replyNumber'] as int?
    ..replySort = json['replySort'] as int?
    ..replyDepth = json['replyDepth'] as int?
    ..replyText = json['replyText'] as String?
    ..replyUploadDateTime = json['replyUploadDateTime'] == null
        ? null
        : DateTime.parse(json['replyUploadDateTime'] as String)
    ..replyUpdateDateTime = json['replyUpdateDateTime'] == null
        ? null
        : DateTime.parse(json['replyUpdateDateTime'] as String)
    ..userNickName = json['userNickName'] as String?
    ..userProfilePictureUrl = json['userProfilePictureUrl'] as String?
    ..deleteFlag = json['deleteFlag'] as bool?
    ..fballValuationResDto = json['fballValuationResDto'] == null
        ? null
        : FBallValuationResDto.fromJson(
            json['fballValuationResDto'] as Map<String, dynamic>)
    ..childCount = json['childCount'] as int?
    ..childFBallReplyResDto = (json['childFBallReplyResDto'] as List<dynamic>?)
        ?.map((e) => FBallReplyResDto.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FBallReplyResDtoToJson(FBallReplyResDto instance) =>
    <String, dynamic>{
      'replyUuid': instance.replyUuid,
      'ballUuid': instance.ballUuid?.toJson(),
      'uid': instance.uid?.toJson(),
      'replyNumber': instance.replyNumber,
      'replySort': instance.replySort,
      'replyDepth': instance.replyDepth,
      'replyText': instance.replyText,
      'replyUploadDateTime': instance.replyUploadDateTime?.toIso8601String(),
      'replyUpdateDateTime': instance.replyUpdateDateTime?.toIso8601String(),
      'userNickName': instance.userNickName,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
      'deleteFlag': instance.deleteFlag,
      'fballValuationResDto': instance.fballValuationResDto?.toJson(),
      'childCount': instance.childCount,
      'childFBallReplyResDto':
          instance.childFBallReplyResDto?.map((e) => e.toJson()).toList(),
    };
