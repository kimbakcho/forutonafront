// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyResWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyResWrapDto _$FBallReplyResWrapDtoFromJson(Map<String, dynamic> json) {
  return FBallReplyResWrapDto()
    ..count = json['count'] as int
    ..replyTotalCount = json['replyTotalCount'] as int
    ..contents = (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : FBallReplyResDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallReplyResWrapDtoToJson(
        FBallReplyResWrapDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'replyTotalCount': instance.replyTotalCount,
      'contents': instance.contents,
    };