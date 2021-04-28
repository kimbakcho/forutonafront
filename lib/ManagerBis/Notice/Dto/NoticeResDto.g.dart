// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoticeResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeResDto _$NoticeResDtoFromJson(Map<String, dynamic> json) {
  return NoticeResDto()
    ..idx = json['idx'] as int?
    ..title = json['title'] as String?
    ..content = json['content'] as String?
    ..openFlag = json['openFlag'] as String?
    ..writerUid = json['writerUid'] == null
        ? null
        : MUserInfoResDto.fromJson(json['writerUid'] as Map<String, dynamic>)
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String);
}

Map<String, dynamic> _$NoticeResDtoToJson(NoticeResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'title': instance.title,
      'content': instance.content,
      'openFlag': instance.openFlag,
      'writerUid': instance.writerUid,
      'modifyDate': instance.modifyDate?.toIso8601String(),
    };
