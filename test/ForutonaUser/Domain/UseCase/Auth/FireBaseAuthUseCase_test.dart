
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FireBaseAdapter/FireBaseAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
class MockFireBaseAdapter extends Mock implements FireBaseAdapter{}
class MockAuthUserCaseOutputPort extends Mock implements AuthUserCaseOutputPort{}
void main (){

  MockFireBaseAdapter mockFireBaseAdapter;

  FireBaseAuthUseCase fireBaseAuthUseCase;

  setUp((){
    mockFireBaseAdapter = new MockFireBaseAdapter();
    fireBaseAuthUseCase = new FireBaseAuthUseCase(fireBaseAdapter: mockFireBaseAdapter);
  });
  test('should isLogin return and outputPort effect', () async {
    //arrange
    when(mockFireBaseAdapter.isLogin()).thenAnswer((_) async => true);
    MockAuthUserCaseOutputPort mockAuthUserCaseOutputPort = new MockAuthUserCaseOutputPort();
    //act
    var result = await fireBaseAuthUseCase.isLogin(authUserCaseOutputPort: mockAuthUserCaseOutputPort);
    //assert
    expect(result, true);
    verify(mockAuthUserCaseOutputPort.onLoginCheck(any));
  });

  test('should isLogin return and no outputPort effect', () async {
    //arrange
    when(mockFireBaseAdapter.isLogin()).thenAnswer((_) async => true);
    MockAuthUserCaseOutputPort mockAuthUserCaseOutputPort = new MockAuthUserCaseOutputPort();
    //act
    var result = await fireBaseAuthUseCase.isLogin();
    //assert
    expect(result, true);
    verifyNever(mockAuthUserCaseOutputPort.onLoginCheck(any));
  });

  test('should myUid return Uid', () async {
    //arrange
    when(mockFireBaseAdapter.userUid()).thenAnswer((_) async => "testUid");
    //act
    var result = await fireBaseAuthUseCase.myUid();
    //assert
    expect(result, "testUid");

  });

  test('should myUid no Login throw error', () async {
    //arrange
    when(mockFireBaseAdapter.userUid()).thenAnswer((_) async => throw FireBaseAdapterException("no login state"));
    //act
    //assert
    expect(fireBaseAuthUseCase.myUid(),throwsA(const TypeMatcher<FireBaseAdapterException>()));
  });

}