import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseAuthAdapterForUseCase extends Mock implements FireBaseAuthAdapterForUseCase{}
class MockPwFindEmailUseCaseOutputPort extends Mock implements PwFindEmailUseCaseOutputPort{}
void main () {
  PwFindEmailUseCaseInputPort pwFindEmailUseCaseInputPort;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockPwFindEmailUseCaseOutputPort mockPwFindEmailUseCaseOutputPort;
  setUp((){
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    mockPwFindEmailUseCaseOutputPort = MockPwFindEmailUseCaseOutputPort();
    pwFindEmailUseCaseInputPort = PwFindEmailUseCase(fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
  });

  test('FireBaseAuthAdapter email 리셋 패스워드 요청 검증 ', () async {
    //arrange
    when(mockFireBaseAuthAdapterForUseCase.sendPasswordResetEmail(any)).thenAnswer((realInvocation) async=> null);
    //act
    await pwFindEmailUseCaseInputPort.sendPasswordResetEmail("test@Email.com",outputPort: mockPwFindEmailUseCaseOutputPort);
    //assert
    verify(mockPwFindEmailUseCaseOutputPort.onSendPasswordResetEmail());
    verify(mockFireBaseAuthAdapterForUseCase.sendPasswordResetEmail(any));
  });
}