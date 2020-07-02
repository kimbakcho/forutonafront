// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonaSettingNotice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaSettingNotice _$PersonaSettingNoticeFromJson(Map<String, dynamic> json) {
  return PersonaSettingNotice()
    ..idx = json['idx'] as int
    ..noticeName = json['noticeName'] as String
    ..noticeWriteDateTime = json['noticeWriteDateTime'] == null
        ? null
        : DateTime.parse(json['noticeWriteDateTime'] as String)
    ..noticeContent = json['noticeContent'] as String
    ..lang = json['lang'] as String;
}

Map<String, dynamic> _$PersonaSettingNoticeToJson(
        PersonaSettingNotice instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'noticeName': instance.noticeName,
      'noticeWriteDateTime': instance.noticeWriteDateTime?.toIso8601String(),
      'noticeContent': instance.noticeContent,
      'lang': instance.lang,
    };
