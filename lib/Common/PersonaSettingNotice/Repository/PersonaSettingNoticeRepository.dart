import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/PersonaSettingNotice/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/Common/PersonaSettingNotice/Dto/PersonaSettingNoticeResWrapDto.dart';

class PersonaSettingNoticeRepository {
  Future<PersonaSettingNoticeResWrapDto> getPersonaSettingNotice(Pageable pageable) async{
      FDio fDio = new FDio("noneToken");
      var response = await fDio.get("/v1/PersonaSettingNotice",queryParameters: pageable.toJson());
      return PersonaSettingNoticeResWrapDto.fromJson(response.data);
  }

  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx) async{
    FDio fDio = new FDio("noneToken");
    var response = await fDio.get("/v1/PersonaSettingNotice/"+idx.toString());
    return PersonaSettingNoticeResDto.fromJson(response.data);
  }
}