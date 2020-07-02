import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResWrapDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockPersonaSettingNoticeRemoteDataSource extends Mock
    implements PersonaSettingNoticeRemoteDataSource {}

void main() {
  PersonaSettingNoticeRepository personaSettingNoticeRepository;
  MockPersonaSettingNoticeRemoteDataSource
      mockPersonaSettingNoticeRemoteDataSource;
  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  setUp(() {
    mockPersonaSettingNoticeRemoteDataSource =
        MockPersonaSettingNoticeRemoteDataSource();
    personaSettingNoticeRepository = PersonaSettingNoticeRepositoryImpl(
        personaSettingNoticeRemoteDataSource:
            mockPersonaSettingNoticeRemoteDataSource);
  });

  test('should getPersonaSettingNotice dataSource call', () async {
    //arrange
    var pageable = Pageable(0, 10, "WriteTime,Desc");
    PersonaSettingNoticeResWrapDto resWrapDto = new PersonaSettingNoticeResWrapDto();
    PersonaSettingNoticeResDto personaSettingNoticeResDto = new PersonaSettingNoticeResDto();
    personaSettingNoticeResDto.idx = 10;
    personaSettingNoticeResDto.noticeName  = "test";
    resWrapDto.content = [personaSettingNoticeResDto];
    resWrapDto.last = false;
    when(mockPersonaSettingNoticeRemoteDataSource.getPersonaSettingNotice(pageable, any))
        .thenAnswer((_) async => resWrapDto);
    //act
    await personaSettingNoticeRepository.getPersonaSettingNotice(pageable);
    //assert
    verify(mockPersonaSettingNoticeRemoteDataSource.getPersonaSettingNotice(pageable, any));
  });

  test('should getPersonaSettingNoticePage dataSource call', () async {
    //arrange
    int idx = 10;
    PersonaSettingNoticeResDto personaSettingNoticeResDto =  PersonaSettingNoticeResDto();
    personaSettingNoticeResDto.idx = 10;
    personaSettingNoticeResDto.noticeName = "test";
    personaSettingNoticeResDto.noticeContent = "test";
    when(mockPersonaSettingNoticeRemoteDataSource.getPersonaSettingNoticePage(idx, any))
        .thenAnswer((_) async => personaSettingNoticeResDto);
    //act
    await personaSettingNoticeRepository.getPersonaSettingNoticePage(idx);
    //assert
    verify(mockPersonaSettingNoticeRemoteDataSource.getPersonaSettingNoticePage(idx, any));
  });
}
