import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNoticeResWrap.dart';

abstract class PersonaSettingNoticeRepository {
  Future<PersonaSettingNoticeResWrap> getPersonaSettingNotice(Pageable pageable);
  Future<PersonaSettingNotice> getPersonaSettingNoticePage(int idx);
}