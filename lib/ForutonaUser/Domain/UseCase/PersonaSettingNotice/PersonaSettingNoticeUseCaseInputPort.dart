import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResWrapDto.dart';

abstract class PersonaSettingNoticeUseCaseInputPort {
  Future<PersonaSettingNoticeResWrapDto> getPersonaSettingNotice(Pageable pageable);
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx);
}