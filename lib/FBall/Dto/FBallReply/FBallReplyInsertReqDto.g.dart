// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyInsertReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyInsertReqDto _$FBallReplyInsertReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallReplyInsertReqDto()
    ..replyUuid = json['replyUuid'] as String
    ..ballUuid = json['ballUuid'] as String
    ..replyNumber = json['replyNumber'] as int
    ..replyText = json['replyText'] as String;
}

Map<String, dynamic> _$FBallReplyInsertReqDtoToJson(
        FBallReplyInsertReqDto instance) =>
    <String, dynamic>{
      'replyUuid': instance.replyUuid,
      'ballUuid': instance.ballUuid,
      'replyNumber': instance.replyNumber,
      'replyText': instance.replyText,
    };
