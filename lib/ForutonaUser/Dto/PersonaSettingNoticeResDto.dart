
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PersonaSettingNoticeResDto.g.dart';

@JsonSerializable()
class PersonaSettingNoticeResDto {
  int idx;
  String noticeName ;
  DateTime noticeWriteDateTime ;
  String noticeContent ;
  String lang ;

  PersonaSettingNoticeResDto();

  factory PersonaSettingNoticeResDto.fromPersonaSettingNotice(PersonaSettingNotice item){
    PersonaSettingNoticeResDto resDto = PersonaSettingNoticeResDto();
    resDto.idx = item.idx;
    resDto.noticeName = item.noticeName;
    resDto.noticeWriteDateTime = item.noticeWriteDateTime;
    resDto.noticeContent = item.noticeContent;
    resDto.lang = item.lang;
    return resDto;
  }

  factory PersonaSettingNoticeResDto.fromJson(Map<String, dynamic> json) => _$PersonaSettingNoticeResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaSettingNoticeResDtoToJson(this);

}