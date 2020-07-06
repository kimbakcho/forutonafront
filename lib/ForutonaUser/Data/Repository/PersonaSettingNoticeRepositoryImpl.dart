import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNoticeResWrap.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';

class PersonaSettingNoticeRepositoryImpl
    implements PersonaSettingNoticeRepository {
  PersonaSettingNoticeRemoteDataSource _personaSettingNoticeRemoteDataSource;

  PersonaSettingNoticeRepositoryImpl(
      {@required
          PersonaSettingNoticeRemoteDataSource
              personaSettingNoticeRemoteDataSource})
      : _personaSettingNoticeRemoteDataSource =
            personaSettingNoticeRemoteDataSource;

  @override
  Future<PersonaSettingNoticeResWrap> getPersonaSettingNotice(
      Pageable pageable) async {
    var personaSettingNoticeResWrapDto =
        await _personaSettingNoticeRemoteDataSource.getPersonaSettingNotice(
            pageable, FDio.noneToken());

    PersonaSettingNoticeResWrap noticeResWrap = PersonaSettingNoticeResWrap();
    noticeResWrap.content = personaSettingNoticeResWrapDto.content
        .map((e) => PersonaSettingNotice.fromPersonaSettingNoticeResDto(e))
        .toList();
    noticeResWrap.last = personaSettingNoticeResWrapDto.last;

    return noticeResWrap;
  }

  @override
  Future<PersonaSettingNotice> getPersonaSettingNoticePage(int idx) async {
    var personaSettingNotice = await _personaSettingNoticeRemoteDataSource
        .getPersonaSettingNoticePage(idx, FDio.noneToken());
    return PersonaSettingNotice.fromPersonaSettingNoticeResDto(personaSettingNotice);
  }
}
