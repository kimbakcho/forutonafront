import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

class MockLogoutUseCaseOutputPort extends Mock
    implements LogoutUseCaseOutputPort {}

class MockSignInUserInfoUseCaseInputPort extends Mock
    implements SignInUserInfoUseCaseInputPort {}

class MockNaverLoginAdapter extends Mock implements SnsLoginModuleAdapter {}

class MockKakaoAdapter extends Mock implements SnsLoginModuleAdapter {}

class MockFaceBookAdapter extends Mock implements SnsLoginModuleAdapter {}

class MockForutonaAdapter extends Mock implements SnsLoginModuleAdapter {}

void main() {
  final sl = GetIt.instance;

  LogoutUseCaseInputPort logoutUseCaseInputPort;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockLogoutUseCaseOutputPort mockLogoutUseCaseOutputPort;
  MockSignInUserInfoUseCaseInputPort mockSignInUserInfoUseCaseInputPort;
  MockNaverLoginAdapter mockNaverLoginAdapter;
  MockKakaoAdapter mockKakaoAdapter;
  MockFaceBookAdapter mockFaceBookAdapter;
  MockForutonaAdapter mockForutonaAdapter;
  setUp(() {
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    mockLogoutUseCaseOutputPort = MockLogoutUseCaseOutputPort();
    mockSignInUserInfoUseCaseInputPort = MockSignInUserInfoUseCaseInputPort();

    mockNaverLoginAdapter = MockNaverLoginAdapter();
    mockKakaoAdapter = MockKakaoAdapter();
    mockFaceBookAdapter = MockFaceBookAdapter();
    mockForutonaAdapter = MockForutonaAdapter();

    sl.registerFactoryParam<SnsLoginModuleAdapter, SnsSupportService, String>(
        (param1, param2) {
      if (param1 == SnsSupportService.Naver) {
        return mockNaverLoginAdapter;
      } else if (param1 == SnsSupportService.Kakao) {
        return mockKakaoAdapter;
      } else if (param1 == SnsSupportService.FaceBook) {
        return mockFaceBookAdapter;
      } else if (param1 == SnsSupportService.Forutona) {
        return mockForutonaAdapter;
      } else {
        return null;
      }
    }, instanceName: "SnsLoginModuleAdapter");


  });

  test('로그아웃시 FireBase 사용와 output 출력 logout adapter logout', () async {
    //arrange
    FUserInfoResDto fUserInfoResDto = FUserInfoResDto();
    fUserInfoResDto.uid = "testUid";
    fUserInfoResDto.snsService = SnsSupportService.Kakao;

    when(mockSignInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory())
        .thenAnswer((realInvocation) => fUserInfoResDto);

    logoutUseCaseInputPort = LogoutUseCase(
        signInUserInfoUseCaseInputPort: mockSignInUserInfoUseCaseInputPort,
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
    //act
    await logoutUseCaseInputPort.tryLogout(
        outputPort: mockLogoutUseCaseOutputPort);
    //assert
    verify(mockFireBaseAuthAdapterForUseCase.logout());
    verify(mockLogoutUseCaseOutputPort.onLogout());
    verify(mockKakaoAdapter.logout());
  });

}
