import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';

class PersonaSettingNoticeUseCase
    implements PersonaSettingNoticeUseCaseInputPort {

  PersonaSettingNoticeRepository _personaSettingNoticeRepository;

  PersonaSettingNoticeUseCase(
      {@required PersonaSettingNoticeRepository personaSettingNoticeRepository}):
        _personaSettingNoticeRepository = personaSettingNoticeRepository;

  @override
  Future<PageWrap<PersonaSettingNoticeResDto>> getPersonaSettingNotice(
      Pageable pageable) async {
     return await _personaSettingNoticeRepository.getPersonaSettingNotice(pageable);
  }

  @override
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx) async {
    return await _personaSettingNoticeRepository.getPersonaSettingNoticePage(idx);
  }

}