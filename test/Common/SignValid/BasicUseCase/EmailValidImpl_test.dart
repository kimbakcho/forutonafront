import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/EmailValidImpl.dart';

import 'package:forutonafront/Common/SignValid/SignValid.dart';


void main(){
  SignValid signUpEmailValid = EmailValidImpl();

  //TODO DefaultSignValidUseCase_test 작성 필요
  test('emailIdValid ', () async {
    await signUpEmailValid.valid("test@test.com");
    expect(signUpEmailValid.hasError(), false);

    await signUpEmailValid.valid("test@test.");
    expect(signUpEmailValid.hasError(), true);

    await signUpEmailValid.valid("test22");
    expect(signUpEmailValid.hasError(), true);

    await signUpEmailValid.valid("test2 2@gere.com");
    expect(signUpEmailValid.hasError(), true);

    await signUpEmailValid.valid("tes!er@gere.com");
    expect(signUpEmailValid.hasError(), false);
  });
}