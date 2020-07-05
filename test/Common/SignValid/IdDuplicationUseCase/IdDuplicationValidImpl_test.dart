import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DontHaveIdError.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/HasIdError.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/IdDuplicationValidImpl.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockSignValid extends Mock implements SignValid {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

void main() {
  MockSignValid mockEmailValid;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  SignValid idDuplicationValid;
  setUp(() {
    mockEmailValid = MockSignValid();
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
  });

  test('IdDuplicationValidImpl ID 중복 체크', () async {
    //arrange
    idDuplicationValid = IdDuplicationValidImpl(
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase,
        emailValid: mockEmailValid,
        duplicationErrorLogin: HasIdError());
    List<String> resultList1 = ['email'];
    List<String> resultList2 = [];
    when(mockEmailValid.hasError()).thenReturn(false);
    when(mockEmailValid.errorText()).thenReturn("");
    when(mockFireBaseAuthAdapterForUseCase.fetchSignInMethodsForEmail("test1@naver.com")).thenAnswer((_) async => resultList1 );
    when(mockFireBaseAuthAdapterForUseCase.fetchSignInMethodsForEmail("test2@naver.com")).thenAnswer((_) async => resultList2);
    //act
    await idDuplicationValid.valid("test1@naver.com");
    //assert
    expect(idDuplicationValid.hasError(), true);
    //act
    await idDuplicationValid.valid("test2@naver.com");
    //assert
    expect(idDuplicationValid.hasError(), false);
  });
  test('IdDuplicationValidImpl 가입 여부 체크', () async {
    //arrange
    idDuplicationValid = IdDuplicationValidImpl(
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase,
        emailValid: mockEmailValid,
        duplicationErrorLogin: DontHaveIdError());
    List<String> resultList1 = ['email'];
    List<String> resultList2 = [];
    when(mockEmailValid.hasError()).thenReturn(false);
    when(mockEmailValid.errorText()).thenReturn("");
    when(mockFireBaseAuthAdapterForUseCase.fetchSignInMethodsForEmail("test1@naver.com")).thenAnswer((_) async => resultList1 );
    when(mockFireBaseAuthAdapterForUseCase.fetchSignInMethodsForEmail("test2@naver.com")).thenAnswer((_) async => resultList2);
    //act
    await idDuplicationValid.valid("test1@naver.com");
    //assert
    expect(idDuplicationValid.hasError(), false);
    //act
    await idDuplicationValid.valid("test2@naver.com");
    //assert
    expect(idDuplicationValid.hasError(), true);
  });
}
