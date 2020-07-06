import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

class MockPersonaSettingNoticeRepository extends Mock
    implements PersonaSettingNoticeRepository {}

void main() {
  MockPersonaSettingNoticeRepository mockPersonaSettingNoticeRepository;
  PersonaSettingNoticeUseCaseInputPort personaSettingNoticeUseCaseInputPort;
  setUp(() {
    mockPersonaSettingNoticeRepository = MockPersonaSettingNoticeRepository();
    personaSettingNoticeUseCaseInputPort = PersonaSettingNoticeUseCase(
        personaSettingNoticeRepository: mockPersonaSettingNoticeRepository);
  });

  test('should getPersonaSettingNotice 레포지 토리 호출', () async {
    //arrange
    Pageable pageable = Pageable(0, 10, "WriteDate,DESC");
    //act
    await personaSettingNoticeUseCaseInputPort.getPersonaSettingNotice(pageable);
    //assert
    verify(mockPersonaSettingNoticeRepository.getPersonaSettingNotice(pageable));
  });

  test('should getPersonaSettingNoticePage 레포지 토리 호출 ' , () async {
    //arrange

    //act
    await personaSettingNoticeUseCaseInputPort.getPersonaSettingNoticePage(3);
    //assert
    verify(mockPersonaSettingNoticeRepository.getPersonaSettingNoticePage(3));
  });
}
