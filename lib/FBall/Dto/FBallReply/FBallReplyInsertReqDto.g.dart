// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyInsertReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyInsertReqDto _$FBallReplyInsertReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallReplyInsertReqDto()
    ..idx = json['idx'] as int
    ..ballUuid = json['ballUuid'] as String
    ..replyNumber = json['replyNumber'] as int
    ..replySort = json['replySort'] as int
    ..replyDepth = json['replyDepth'] as int
    ..replyText = json['replyText'] as String;
}

Map<String, dynamic> _$FBallReplyInsertReqDtoToJson(
        FBallReplyInsertReqDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'ballUuid': instance.ballUuid,
      'replyNumber': instance.replyNumber,
      'replySort': instance.replySort,
      'replyDepth': instance.replyDepth,
      'replyText': instance.replyText,
    };
