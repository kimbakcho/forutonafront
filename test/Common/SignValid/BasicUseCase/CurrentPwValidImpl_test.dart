import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/CurrentPwValidImpl.dart';

import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseAuthAdapterForUseCase extends Mock implements FireBaseAuthAdapterForUseCase{}
void main(){
  SignValid currentPwValid;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  setUp((){
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    currentPwValid = CurrentPwValidImpl(fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase);
  });

  test('currentPwValid', () async {
    //arrange
    when(mockFireBaseAuthAdapterForUseCase.userEmail()).thenAnswer((realInvocation) async => "test");
    when(mockFireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(any, any)).thenAnswer((realInvocation) async => "test");
    //act
    await currentPwValid.valid("pass");
    //assert
    expect(currentPwValid.hasError(), false);


    when(mockFireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(any, any)).thenThrow(PlatformException(code:"ERROR_WRONG_PASSWORD"));
    //act
    await currentPwValid.valid("pass");
    //assert
    expect(currentPwValid.hasError(), true);
  });
}