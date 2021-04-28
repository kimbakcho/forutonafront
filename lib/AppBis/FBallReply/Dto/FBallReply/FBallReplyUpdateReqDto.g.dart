// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyUpdateReqDto _$FBallReplyUpdateReqDtoFromJson(
    Map<String, dynamic> json) {
  return FBallReplyUpdateReqDto()
    ..replyUuid = json['replyUuid'] as String?
    ..replyText = json['replyText'] as String?;
}

Map<String, dynamic> _$FBallReplyUpdateReqDtoToJson(
        FBallReplyUpdateReqDto instance) =>
    <String, dynamic>{
      'replyUuid': instance.replyUuid,
      'replyText': instance.replyText,
    };
