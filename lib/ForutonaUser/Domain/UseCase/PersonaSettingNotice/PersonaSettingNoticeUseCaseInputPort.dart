import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';

abstract class PersonaSettingNoticeUseCaseInputPort {
  Future<PageWrap<PersonaSettingNoticeResDto>> getPersonaSettingNotice(Pageable pageable);
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx);
}