import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResWrapDto.dart';
import 'package:mockito/mockito.dart';

class MockFDio extends Mock implements FDio {}
void main(){
  PersonaSettingNoticeRemoteDataSource personaSettingNoticeRemoteDataSource;
  FDio fDio;
  setUp((){
    personaSettingNoticeRemoteDataSource = PersonaSettingNoticeRemoteDataSourceImpl();
    fDio = MockFDio();
  });

  test('should be getPersonaSettingNotice call API REST', () async {
    PersonaSettingNoticeResWrapDto resWrapDto = new PersonaSettingNoticeResWrapDto();
    resWrapDto.content = [];
    //arrange
    when(fDio.get("/v1/ForutonaUser/PersonaSettingNotice",
        queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: resWrapDto.toJson()));
    //act
    await personaSettingNoticeRemoteDataSource.getPersonaSettingNotice(
        Pageable(0, 10, "WriteTime"), fDio);
    //assert
    verify(fDio.get("/v1/ForutonaUser/PersonaSettingNotice",
        queryParameters: anyNamed('queryParameters')));
  });

  test('should be getPersonaSettingNoticePage call API REST', () async {
    int idx = 10;
    PersonaSettingNoticeResDto noticeResDto = PersonaSettingNoticeResDto();
    noticeResDto.idx = 10;
    noticeResDto.noticeContent = "";
    //arrange
    when(fDio.get("/v1/ForutonaUser/PersonaSettingNotice/"+idx.toString()))
        .thenAnswer((_) async => Response<dynamic>(data: noticeResDto.toJson()));
    //act
    await personaSettingNoticeRemoteDataSource.getPersonaSettingNoticePage(
        idx, fDio);
    //assert
    verify(fDio.get("/v1/ForutonaUser/PersonaSettingNotice/"+idx.toString()));
  });
}