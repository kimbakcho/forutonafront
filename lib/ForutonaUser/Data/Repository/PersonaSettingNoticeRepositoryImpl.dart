import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';

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
  Future<PageWrap<PersonaSettingNoticeResDto>> getPersonaSettingNotice(
      Pageable pageable) async {
       return await _personaSettingNoticeRemoteDataSource.getPersonaSettingNotice(
            pageable, FDio.noneToken());
  }

  @override
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx) async {
    var personaSettingNotice = await _personaSettingNoticeRemoteDataSource
        .getPersonaSettingNoticePage(idx, FDio.noneToken());
    return personaSettingNotice;
  }
}
