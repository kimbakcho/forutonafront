
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PersonaSettingNotice.g.dart';

@JsonSerializable()
class PersonaSettingNotice {
  int idx;
  String noticeName ;
  DateTime noticeWriteDateTime ;
  String noticeContent ;
  String lang ;
  PersonaSettingNotice();
  factory PersonaSettingNotice.fromPersonaSettingNoticeResDto(PersonaSettingNoticeResDto resDto){
    PersonaSettingNotice item = PersonaSettingNotice();
    item.idx = resDto.idx;
    item.noticeName = resDto.noticeName;
    item.noticeWriteDateTime = resDto.noticeWriteDateTime;
    item.noticeContent = resDto.noticeContent;
    item.lang = resDto.lang;
    return item;
  }

  factory PersonaSettingNotice.fromJson(Map<String, dynamic> json) => _$PersonaSettingNoticeFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaSettingNoticeToJson(this);
}