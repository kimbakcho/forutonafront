import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/NotJoinException.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
class MockSingUpUseCaseInputPort extends Mock
    implements SingUpUseCaseInputPort {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

class MockSnsLoginModuleAdapter extends Mock implements SnsLoginModuleAdapter {}

void main() {
  LoginUseCaseInputPort loginUseCase;
  MockSingUpUseCaseInputPort mockSingUpUseCaseInputPort;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockSnsLoginModuleAdapter mocSnsSdkAdapter;
  setUp(() {
    mockSingUpUseCaseInputPort = MockSingUpUseCaseInputPort();
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    mocSnsSdkAdapter = MockSnsLoginModuleAdapter();
    loginUseCase = LoginUseCase(
        singUpUseCaseInputPort: mockSingUpUseCaseInputPort,
        snsLoginModuleAdapter: mocSnsSdkAdapter);
  });

  test('should FireBase에 CustomToken으로 로그인 시도', () async {
    //arrange
    when(mocSnsSdkAdapter.getSnsModuleUserInfo()).thenAnswer(
        (realInvocation) async => SnsLoginModuleResDto("testUid", "testToken"));

    FUserSnsCheckJoinResDto fUserSnsCheckJoin = FUserSnsCheckJoinResDto();
    fUserSnsCheckJoin.snsUid = "testUid";
    fUserSnsCheckJoin.join = true;
    fUserSnsCheckJoin.firebaseCustomToken = "customLoginToken";

    when(mockSingUpUseCaseInputPort.snsUidJoinCheck(any,any)).thenAnswer(
            (realInvocation) async => fUserSnsCheckJoin);

    //act
    var result = await loginUseCase.tryLogin();
    //assert
    verify(mocSnsSdkAdapter.getSnsModuleUserInfo());
    verify(mockFireBaseAuthAdapterForUseCase.signInWithCustomToken(any));
    expect(result, true);
  });

  test('should 가입이 안된 유저가 로그인시도시 에러 출력', () async {
    //arrange
    when(mocSnsSdkAdapter.getSnsModuleUserInfo()).thenAnswer(
            (realInvocation) async => SnsLoginModuleResDto("testUid", "testToken"));

    FUserSnsCheckJoinResDto fUserSnsCheckJoin = FUserSnsCheckJoinResDto();
    fUserSnsCheckJoin.snsUid = "testUid";
    fUserSnsCheckJoin.join = false;
    fUserSnsCheckJoin.firebaseCustomToken = "customLoginToken";

    when(mockSingUpUseCaseInputPort.snsUidJoinCheck(any,any)).thenAnswer(
            (realInvocation) async => fUserSnsCheckJoin);

    //assert
    expect(loginUseCase.tryLogin(),throwsA(const TypeMatcher<NotJoinException>()));

  });
}
