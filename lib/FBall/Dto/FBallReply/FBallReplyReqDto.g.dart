// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyReqDto _$FBallReplyReqDtoFromJson(Map<String, dynamic> json) {
  return FBallReplyReqDto()
    ..ballUuid = json['ballUuid'] as String
    ..replyNumber = json['replyNumber'] as int
    ..reqOnlySubReply = json['reqOnlySubReply'] as bool
    ..size = json['size'] as int
    ..page = json['page'] as int;
}

Map<String, dynamic> _$FBallReplyReqDtoToJson(FBallReplyReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'replyNumber': instance.replyNumber,
      'reqOnlySubReply': instance.reqOnlySubReply,
      'size': instance.size,
      'page': instance.page,
    };
