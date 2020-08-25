import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwValidImpl.dart';

void main(){

  PwValid pwValid = PwValidImpl();

  test('pwValid ', () async {
    pwValid.valid("1234");
    expect(pwValid.hasError(), true);
    expect(pwValid.errorText(), "패스워드가 8자리 이하 입니다.");

    pwValid.valid("123456789");
    expect(pwValid.hasError(), true);
    expect(pwValid.errorText(),
        "영문, 소문자, 대문자, 특수문자 중 3개 이상 조합");

    pwValid.valid("AA123123");
    expect(pwValid.hasError(), true);
    expect(pwValid.errorText(),
        "영문, 소문자, 대문자, 특수문자 중 3개 이상 조합");

    pwValid.valid("Aa123123");
    expect(pwValid.hasError(), false);

    pwValid.valid("Aa123 123");
    expect(pwValid.hasError(), false);
  });
}