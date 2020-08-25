import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwCheckValidImpl.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwValidImpl.dart';

import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:mockito/mockito.dart';

class MockPwValid extends Mock implements PwValid{}

void main(){

  MockPwValid mockPwValid;
  SignValid pwCheckSignValid;

  setUp((){
    mockPwValid = new MockPwValid();
    pwCheckSignValid = PwCheckValidImpl(mockPwValid);
  });

  test('pwCheckSignValid 같을때', () async {
    //arrange
    when(mockPwValid.currentPw).thenReturn("test12345");
    //act
    await pwCheckSignValid.valid("test12345");
    //assert
    expect(pwCheckSignValid.hasError(), false);
  });

  test('pwCheckSignValid 틀릴때 ', () async {
    //arrange
    when(mockPwValid.currentPw).thenReturn("test123123");
    //act
    await pwCheckSignValid.valid("test1111111");
    //assert
    expect(pwCheckSignValid.hasError(), true);
  });

  test('pwCheckSignValid 최소 8자 이상 ', () async {
    //arrange
    when(mockPwValid.currentPw).thenReturn("test");
    //act
    await pwCheckSignValid.valid("test");
    //assert
    expect(pwCheckSignValid.hasError(), true);
  });
}