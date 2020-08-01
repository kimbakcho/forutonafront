// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyResWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyResWrap _$FBallReplyResWrapFromJson(Map<String, dynamic> json) {
  return FBallReplyResWrap()
    ..count = json['count'] as int
    ..offset = json['offset'] as int
    ..pageSize = json['pageSize'] as int
    ..replyTotalCount = json['replyTotalCount'] as int
    ..onlySubReply = json['onlySubReply'] as bool
    ..contents = (json['contents'] as List)
        ?.map((e) =>
            e == null ? null : FBallReply.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallReplyResWrapToJson(FBallReplyResWrap instance) =>
    <String, dynamic>{
      'count': instance.count,
      'offset': instance.offset,
      'pageSize': instance.pageSize,
      'replyTotalCount': instance.replyTotalCount,
      'onlySubReply': instance.onlySubReply,
      'contents': instance.contents,
    };
