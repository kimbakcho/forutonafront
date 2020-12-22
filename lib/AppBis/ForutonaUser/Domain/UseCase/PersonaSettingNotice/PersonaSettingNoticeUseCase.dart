import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: PersonaSettingNoticeUseCaseInputPort)
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