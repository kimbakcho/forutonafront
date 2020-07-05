import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

class MockLogoutUseCaseOutputPort extends Mock
    implements LogoutUseCaseOutputPort {}

void main() {
  LogoutUseCaseInputPort logoutUseCaseInputPort;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockLogoutUseCaseOutputPort mockLogoutUseCaseOutputPort;
  setUp(() {
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    mockLogoutUseCaseOutputPort = MockLogoutUseCaseOutputPort();
    logoutUseCaseInputPort = LogoutUseCase(
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
  });

  test('로그아웃시 FireBase 사용와 output 출력', () async {
    //arrange

    //act
    await logoutUseCaseInputPort.tryLogout(outputPort: mockLogoutUseCaseOutputPort );
    //assert
    verify(mockFireBaseAuthAdapterForUseCase.logout());
    verify(mockLogoutUseCaseOutputPort.onLogout());
  });
}
