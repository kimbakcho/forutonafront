// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonaSettingNoticeResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaSettingNoticeResDto _$PersonaSettingNoticeResDtoFromJson(
    Map<String, dynamic> json) {
  return PersonaSettingNoticeResDto()
    ..idx = json['idx'] as int
    ..noticeName = json['noticeName'] as String
    ..noticeWriteDateTime = json['noticeWriteDateTime'] == null
        ? null
        : DateTime.parse(json['noticeWriteDateTime'] as String)
    ..noticeContent = json['noticeContent'] as String
    ..lang = json['lang'] as String;
}

Map<String, dynamic> _$PersonaSettingNoticeResDtoToJson(
        PersonaSettingNoticeResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'noticeName': instance.noticeName,
      'noticeWriteDateTime': instance.noticeWriteDateTime?.toIso8601String(),
      'noticeContent': instance.noticeContent,
      'lang': instance.lang,
    };
