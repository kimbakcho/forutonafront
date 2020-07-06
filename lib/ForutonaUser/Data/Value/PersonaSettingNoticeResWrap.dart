import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PersonaSettingNoticeResWrap.g.dart';

@JsonSerializable()
class PersonaSettingNoticeResWrap {
  List<PersonaSettingNotice> content;
  bool last = false;

  PersonaSettingNoticeResWrap();

  factory PersonaSettingNoticeResWrap.fromJson(Map<String, dynamic> json) => _$PersonaSettingNoticeResWrapFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaSettingNoticeResWrapToJson(this);

}