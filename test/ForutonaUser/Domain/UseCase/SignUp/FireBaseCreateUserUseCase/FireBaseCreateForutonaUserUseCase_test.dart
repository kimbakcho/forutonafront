import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateForutonaUserUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateUserUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

void main() {
  FireBaseCreateUserUseCaseInputPort fireBaseCreateUserUseCaseInputPort;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  setUp(() {
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    fireBaseCreateUserUseCaseInputPort = FireBaseCreateForutonaUserUseCase(
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
  });
  test('should FireBase에 email로 가입을 한다.', () async {
    //arrange
    when(mockFireBaseAuthAdapterForUseCase.createUserWithEmailAndPassword(
            any, any))
        .thenAnswer((realInvocation) async => "testUid");
    //act
    await fireBaseCreateUserUseCaseInputPort.createUser(
        email: "tset@gmail.com", pw: "Aa123123");
    //assert
    verify(mockFireBaseAuthAdapterForUseCase.createUserWithEmailAndPassword(any, any));
  });
}
