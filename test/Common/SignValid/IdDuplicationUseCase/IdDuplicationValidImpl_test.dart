import 'package:flutter_test/flutter_test.dart';
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
        duplicationMessage: "이미 ID가 있습니다.");
    List<String> resultList1 = ['email'];
    List<String> resultList2 = [];
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
        duplicationMessage: "해당 아이디로 가입되어 있습니다.");
    List<String> resultList1 = ['email'];
    List<String> resultList2 = [];
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
}
