

import 'package:json_annotation/json_annotation.dart';

import 'PersonaSettingNoticeResDto.dart';
part 'PersonaSettingNoticeResWrapDto.g.dart';

@JsonSerializable()
class PersonaSettingNoticeResWrapDto {
  List<PersonaSettingNoticeResDto> content;
  bool last = false;


  PersonaSettingNoticeResWrapDto();

  factory PersonaSettingNoticeResWrapDto.fromJson(Map<String, dynamic> json) => _$PersonaSettingNoticeResWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaSettingNoticeResWrapDtoToJson(this);

}