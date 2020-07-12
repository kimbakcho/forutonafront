// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyResWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyResWrap _$FBallReplyResWrapFromJson(Map<String, dynamic> json) {
  return FBallReplyResWrap()
    ..count = json['count'] as int
    ..replyTotalCount = json['replyTotalCount'] as int
    ..contents = (json['contents'] as List)
        ?.map((e) =>
            e == null ? null : FBallReply.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallReplyResWrapToJson(FBallReplyResWrap instance) =>
    <String, dynamic>{
      'count': instance.count,
      'replyTotalCount': instance.replyTotalCount,
      'contents': instance.contents,
    };
