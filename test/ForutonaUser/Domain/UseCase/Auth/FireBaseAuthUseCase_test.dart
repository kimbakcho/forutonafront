
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
class MockFireBaseAdapter extends Mock implements FireBaseAuthAdapterForUseCase{}
class MockAuthUserCaseOutputPort extends Mock implements AuthUserCaseOutputPort{}
void main (){

  MockFireBaseAdapter mockFireBaseAdapter;

  FireBaseAuthUseCase fireBaseAuthUseCase;

  setUp((){
    mockFireBaseAdapter = new MockFireBaseAdapter();
    fireBaseAuthUseCase = new FireBaseAuthUseCase(fireBaseAdapter: mockFireBaseAdapter);
  });
  test('FireBase 어탭터로 부터 로그인 결과 받고 outputPort 에 출력', () async {
    //arrange
    when(mockFireBaseAdapter.isLogin()).thenAnswer((_) async => true);
    MockAuthUserCaseOutputPort mockAuthUserCaseOutputPort = new MockAuthUserCaseOutputPort();
    //act
    var result = await fireBaseAuthUseCase.isLogin(authUserCaseOutputPort: mockAuthUserCaseOutputPort);
    //assert
    expect(result, true);
    verify(mockAuthUserCaseOutputPort.onLoginCheck(any));
  });

  test('어탭터로 부터 로그인 결과 받고 outputPort 에 출력 안하기', () async {
    //arrange
    when(mockFireBaseAdapter.isLogin()).thenAnswer((_) async => true);
    MockAuthUserCaseOutputPort mockAuthUserCaseOutputPort = new MockAuthUserCaseOutputPort();
    //act
    var result = await fireBaseAuthUseCase.isLogin();
    //assert
    expect(result, true);
    verifyNever(mockAuthUserCaseOutputPort.onLoginCheck(any));
  });

  test('FireBase 어탭터로 부터 Uid 반환', () async {
    //arrange
    when(mockFireBaseAdapter.userUid()).thenAnswer((_) async => "testUid");
    //act
    var result = await fireBaseAuthUseCase.myUid();
    //assert
    expect(result, "testUid");

  });

  test('로그인 상태가 아닐때 id 요청하면 에러 던짐', () async {
    //arrange
    when(mockFireBaseAdapter.userUid()).thenAnswer((_) async => throw FireBaseAdapterException("no login state"));
    //act
    //assert
    expect(fireBaseAuthUseCase.myUid(),throwsA(const TypeMatcher<FireBaseAdapterException>()));
  });

}