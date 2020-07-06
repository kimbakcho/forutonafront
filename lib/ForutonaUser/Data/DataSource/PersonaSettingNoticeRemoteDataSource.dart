import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNoticeResWrap.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResWrapDto.dart';

abstract class PersonaSettingNoticeRemoteDataSource {
  Future<PersonaSettingNoticeResWrapDto> getPersonaSettingNotice(Pageable pageable,FDio noneTokenFDio);
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx,FDio noneTokenFDio);
}

class PersonaSettingNoticeRemoteDataSourceImpl implements PersonaSettingNoticeRemoteDataSource {
  @override
  Future<PersonaSettingNoticeResWrapDto> getPersonaSettingNotice(Pageable pageable,FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/ForutonaUser/PersonaSettingNotice",queryParameters: pageable.toJson());
    return PersonaSettingNoticeResWrapDto.fromJson(response.data);
  }

  @override
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx,FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/ForutonaUser/PersonaSettingNotice/"+idx.toString());
    return PersonaSettingNoticeResDto.fromJson(response.data);
  }

}
