
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

  factory PersonaSettingNoticeResDto.fromJson(Map<String, dynamic> json) => _$PersonaSettingNoticeResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaSettingNoticeResDtoToJson(this);

}