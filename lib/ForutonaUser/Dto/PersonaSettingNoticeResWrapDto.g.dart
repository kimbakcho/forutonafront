// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonaSettingNoticeResWrapDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaSettingNoticeResWrapDto _$PersonaSettingNoticeResWrapDtoFromJson(
    Map<String, dynamic> json) {
  return PersonaSettingNoticeResWrapDto(
    (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : PersonaSettingNoticeResDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..last = json['last'] as bool;
}

Map<String, dynamic> _$PersonaSettingNoticeResWrapDtoToJson(
        PersonaSettingNoticeResWrapDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
    };
