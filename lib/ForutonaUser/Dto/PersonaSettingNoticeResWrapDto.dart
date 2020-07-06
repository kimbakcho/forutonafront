

import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNoticeResWrap.dart';
import 'package:json_annotation/json_annotation.dart';

import 'PersonaSettingNoticeResDto.dart';
part 'PersonaSettingNoticeResWrapDto.g.dart';

@JsonSerializable()
class PersonaSettingNoticeResWrapDto {
  List<PersonaSettingNoticeResDto> content;
  bool last = false;

  factory PersonaSettingNoticeResWrapDto.fromPersonaSettingNoticeResWrap(PersonaSettingNoticeResWrap item){
    PersonaSettingNoticeResWrapDto resWrapDto = PersonaSettingNoticeResWrapDto();
    resWrapDto.content = item.content.map((x) => PersonaSettingNoticeResDto.fromPersonaSettingNotice(x)).toList();
    resWrapDto.last = item.last;
    return resWrapDto;
  }

  PersonaSettingNoticeResWrapDto();

  factory PersonaSettingNoticeResWrapDto.fromJson(Map<String, dynamic> json) => _$PersonaSettingNoticeResWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaSettingNoticeResWrapDtoToJson(this);

}