import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidUseCaseInputPort.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockFUserRepository extends Mock implements FUserRepository {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

void main() {
  SignUpValidUseCaseInputPort signUpValidUseCaseInputPort;
  MockFUserRepository mockFBallRepository;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  setUp(() {
    mockFBallRepository = MockFUserRepository();
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    signUpValidUseCaseInputPort = DefaultSignValidUseCase(
        fUserRepository: mockFBallRepository,
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
  });

  //TODO DefaultSignValidUseCase_test 작성 필요
  test('emailIdValid ', () async {
    await signUpValidUseCaseInputPort.emailIdValid("test@test.com");
    expect(signUpValidUseCaseInputPort.hasEmailError(), false);

    await signUpValidUseCaseInputPort.emailIdValid("test@test.");
    expect(signUpValidUseCaseInputPort.hasEmailError(), true);

    await signUpValidUseCaseInputPort.emailIdValid("test22");
    expect(signUpValidUseCaseInputPort.hasEmailError(), true);

    await signUpValidUseCaseInputPort.emailIdValid("test2 2@gere.com");
    expect(signUpValidUseCaseInputPort.hasEmailError(), true);

    await signUpValidUseCaseInputPort.emailIdValid("tes!er@gere.com");
    expect(signUpValidUseCaseInputPort.hasEmailError(), false);
  });

  test('pwValid ', () async {
    signUpValidUseCaseInputPort.pwValid("1234");
    expect(signUpValidUseCaseInputPort.hasPwError(), true);
    expect(signUpValidUseCaseInputPort.pwErrorText(), "패스워드가 8자리 이하 입니다.");

    signUpValidUseCaseInputPort.pwValid("123456789");
    expect(signUpValidUseCaseInputPort.hasPwError(), true);
    expect(signUpValidUseCaseInputPort.pwErrorText(),
        "영문, 소문자, 대문자, 특수문자 중 3개 이상 조합");

    signUpValidUseCaseInputPort.pwValid("AA123123");
    expect(signUpValidUseCaseInputPort.hasPwError(), true);
    expect(signUpValidUseCaseInputPort.pwErrorText(),
        "영문, 소문자, 대문자, 특수문자 중 3개 이상 조합");

    signUpValidUseCaseInputPort.pwValid("Aa123123");
    expect(signUpValidUseCaseInputPort.hasPwError(), false);

    signUpValidUseCaseInputPort.pwValid("Aa123 123");
    expect(signUpValidUseCaseInputPort.hasPwError(), false);
  });

  test('pwCheckValid ', () async {
    signUpValidUseCaseInputPort.pwCheckValid("123445678", "123445678");
    expect(signUpValidUseCaseInputPort.hasPwCheckError(), false);

    signUpValidUseCaseInputPort.pwCheckValid("123445678", "12344567!");
    expect(signUpValidUseCaseInputPort.hasPwCheckError(), true);
  });

  test('nickNameValid ', () async {
    when(mockFBallRepository.checkNickNameDuplication("text"))
        .thenAnswer((realInvocation) async => false);
    when(mockFBallRepository.checkNickNameDuplication("test"))
        .thenAnswer((realInvocation) async => true);

    await signUpValidUseCaseInputPort.nickNameValid("t");

    expect(signUpValidUseCaseInputPort.hasNickNameError(), true);
    expect(signUpValidUseCaseInputPort.nickNameErrorText(),
        "닉네임은 최소 2글자 이상이어야 합니다.");

    await signUpValidUseCaseInputPort.nickNameValid("text");

    expect(signUpValidUseCaseInputPort.hasNickNameError(), false);

    await signUpValidUseCaseInputPort.nickNameValid("test");
    expect(signUpValidUseCaseInputPort.hasNickNameError(), true);
    expect(signUpValidUseCaseInputPort.nickNameErrorText(), "이미 있는 닉네임입니다.");
  });

  test('currentPwValid', () async {

    //arrange
    when(mockFireBaseAuthAdapterForUseCase.userEmail()).thenAnswer((realInvocation) async => "test");
    when(mockFireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(any, any)).thenAnswer((realInvocation) async => "test");
    //act
    await signUpValidUseCaseInputPort.currentPwValid("pass");
    //assert
    expect(signUpValidUseCaseInputPort.hasCurrentPwError(), false);


    when(mockFireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(any, any)).thenThrow(PlatformException(code:"ERROR_WRONG_PASSWORD"));
    //act
    await signUpValidUseCaseInputPort.currentPwValid("pass");
    //assert
    expect(signUpValidUseCaseInputPort.hasCurrentPwError(), true);

  });
}
