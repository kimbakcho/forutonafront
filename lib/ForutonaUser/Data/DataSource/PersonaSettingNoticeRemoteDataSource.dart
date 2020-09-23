import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:injectable/injectable.dart';


abstract class PersonaSettingNoticeRemoteDataSource {
  Future<PageWrap<PersonaSettingNoticeResDto>> getPersonaSettingNotice(Pageable pageable,FDio noneTokenFDio);
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx,FDio noneTokenFDio);
}
@LazySingleton(as: PersonaSettingNoticeRemoteDataSource)
class PersonaSettingNoticeRemoteDataSourceImpl implements PersonaSettingNoticeRemoteDataSource {
  @override
  Future<PageWrap<PersonaSettingNoticeResDto>> getPersonaSettingNotice(Pageable pageable,FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/PersonaSettingNotice",queryParameters: pageable.toJson());
    return PageWrap<PersonaSettingNoticeResDto>.fromJson(response.data, PersonaSettingNoticeResDto.fromJson);
  }

  @override
  Future<PersonaSettingNoticeResDto> getPersonaSettingNoticePage(int idx,FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/PersonaSettingNotice/"+idx.toString());
    return PersonaSettingNoticeResDto.fromJson(response.data);
  }

}
