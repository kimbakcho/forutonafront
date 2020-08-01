import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Preference.dart';
import 'package:mockito/mockito.dart';

class MockFUserRepository extends Mock implements FUserRepository {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

void main() {
  SingUpUseCase singUpUseCase;
  MockFUserRepository mockFUserRepository;
  setUp(() {
    mockFUserRepository = new MockFUserRepository();

    singUpUseCase = SingUpUseCase(
        fUserRepository: mockFUserRepository,
        preference: Preference());
  });

  test('should be 가입 여부 체크 ', () async {
    //arrange
    FUserSnsCheckJoinResDto fUserSnsCheckJoin = FUserSnsCheckJoinResDto();
    fUserSnsCheckJoin.snsUid = "snsUid";

    when(mockFUserRepository.getSnsUserJoinCheckInfo(any,any,))
        .thenAnswer((realInvocation) async => fUserSnsCheckJoin);
    //act
    await singUpUseCase.snsUidJoinCheck(SnsSupportService.Kakao,"TEST");
    //assert
    verify(mockFUserRepository.getSnsUserJoinCheckInfo(SnsSupportService.Kakao,"TEST"));
  });

}
