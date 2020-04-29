// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallReplyReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallReplyReqDto _$FBallReplyReqDtoFromJson(Map<String, dynamic> json) {
  return FBallReplyReqDto()
    ..ballUuid = json['ballUuid'] as String
    ..replyNumber = json['replyNumber'] as int
    ..detail = json['detail'] as bool
    ..size = json['size'] as int
    ..page = json['page'] as int
    ..sort = json['sort'] as String;
}

Map<String, dynamic> _$FBallReplyReqDtoToJson(FBallReplyReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'replyNumber': instance.replyNumber,
      'detail': instance.detail,
      'size': instance.size,
      'page': instance.page,
      'sort': instance.sort,
    };
