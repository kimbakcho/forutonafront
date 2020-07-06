// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonaSettingNoticeResWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaSettingNoticeResWrap _$PersonaSettingNoticeResWrapFromJson(
    Map<String, dynamic> json) {
  return PersonaSettingNoticeResWrap()
    ..content = (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : PersonaSettingNotice.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..last = json['last'] as bool;
}

Map<String, dynamic> _$PersonaSettingNoticeResWrapToJson(
        PersonaSettingNoticeResWrap instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
    };
