import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNoticeResWrap.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResWrapDto.dart';

class PersonaSettingNoticeUseCase
    implements PersonaSettingNoticeUseCaseInputPort {

  PersonaSettingNoticeRepository _personaSettingNoticeRepository;

  PersonaSettingNoticeUseCase(
      {@required PersonaSettingNoticeRepository personaSettingNoticeRepository}):
        _personaSettingNoticeRepository = personaSettingNoticeRepository;

  @override
  Future<PersonaSettingNoticeResWrapDto> getPersonaSettingNotice(
      Pageable pageable) async {
    var personaSettingNoticeResWrap = await _personaSettingNoticeRepository.getPersonaSettingNotice(pageable);
     return PersonaSettingNoticeResWrapDto.fromPersonaSettingNoticeResWrap(personaSettingNoticeResWrap);
  }

  @override
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx) async {
    var personaSettingNotice = await _personaSettingNoticeRepository.getPersonaSettingNoticePage(idx);
    return PersonaSettingNoticeResDto.fromPersonaSettingNotice(personaSettingNotice);
  }

}