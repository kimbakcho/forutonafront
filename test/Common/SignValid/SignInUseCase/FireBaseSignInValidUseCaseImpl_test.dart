import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/SignInUseCase/FireBaseSignInValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

void main() {
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  FireBaseSignInValidUseCase fireBaseSignInValidUseCase;

  setUp(() {
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    fireBaseSignInValidUseCase = FireBaseSignInValidUseCaseImpl(
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
  });

  test('FireBaseSignInValidUseCaseImpl 로그인 정상', () async {
    //arrange
    when(mockFireBaseAuthAdapterForUseCase.signInWithEmailAndPassword("TEST1@google.com", "Aa123123"))
        .thenAnswer((_) async => "TEST123");
    //act
    await fireBaseSignInValidUseCase.signInValidWithSignIn("TEST1@google.com", "Aa123123");
    //assert
    expect(fireBaseSignInValidUseCase.hasSignInError(), false);
  });

  test('FireBaseSignInValidUseCaseImpl 비정상 로그인', () async {
    //arrange
    when(mockFireBaseAuthAdapterForUseCase.signInWithEmailAndPassword("TEST2@google.com", "Aa123123"))
        .thenThrow(PlatformException(code: "ERROR_WRONG_PASSWORD"));
    //act
    await fireBaseSignInValidUseCase.signInValidWithSignIn("TEST2@google.com", "Aa123123");
    //assert
    expect(fireBaseSignInValidUseCase.hasSignInError(), true);
    expect(fireBaseSignInValidUseCase.signInErrorText(), "패스워드가 틀렸습니다.");
  });
}
