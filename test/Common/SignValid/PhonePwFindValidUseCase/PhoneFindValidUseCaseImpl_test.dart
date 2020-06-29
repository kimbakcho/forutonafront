import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:mockito/mockito.dart';

class MockPhoneAuthRepository extends Mock implements PhoneAuthRepository {}

void main() {
  PhoneFindValidUseCase phoneFindValidUseCase;
  MockPhoneAuthRepository mockPhoneAuthRepository = MockPhoneAuthRepository();
  setUp(() {
    phoneFindValidUseCase =
        PhoneFindValidUseCaseImpl(phoneAuthRepository: mockPhoneAuthRepository);
  });

  test('should 이메일에 대한 폰 번호 검증시 에러를 줄때 ', () async {
    //arrange
    PwFindPhoneAuth result = PwFindPhoneAuth();
    result.cause = "MissMatchEmailAndPhone";
    result.error = true;
    when(mockPhoneAuthRepository.reqPwFindPhoneAuth(any)).thenAnswer((_) async => result);
    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    reqDto.phoneNumber = "+8201088884444";
    reqDto.email = "tetst@gmail.com";
    reqDto.emailPhoneAuthToken = "TEST";
    //act
    await phoneFindValidUseCase.phoneEmailIdValidWithReqPhoneSmsAuth(reqDto);
    //assert
    expect(phoneFindValidUseCase.hasPhoneEmailError(), true);
  });

  test('should 이메일에 대한 폰 번호 검증시 정상일때 ', () async {
    //arrange
    PwFindPhoneAuth result = PwFindPhoneAuth();
    result.cause = "";
    result.error = false;
    when(mockPhoneAuthRepository.reqPwFindPhoneAuth(any)).thenAnswer((_) async => result);
    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    reqDto.phoneNumber = "+8201088884444";
    reqDto.email = "tetst@gmail.com";
    reqDto.emailPhoneAuthToken = "TEST";
    //act
    await phoneFindValidUseCase.phoneEmailIdValidWithReqPhoneSmsAuth(reqDto);
    //assert
    expect(phoneFindValidUseCase.hasPhoneEmailError(), false);
  });

  test('should 폰 인증 번호에 에러가 있을때', () async {
    //arrange
    PwFindPhoneAuthNumber result = PwFindPhoneAuthNumber();
    result.errorFlag = true;
    result.errorCause = "인증번호 틀림";
    when(mockPhoneAuthRepository.reqPwFindNumberAuth(any)).thenAnswer((_) async => result);
    PwFindPhoneAuthNumberReqDto reqDto = PwFindPhoneAuthNumberReqDto();
    reqDto.phoneNumber = "+8201088884444";
    reqDto.email = "tetst@gmail.com";
    reqDto.authNumber = "234567";
    //act
    await phoneFindValidUseCase.phoneAuthNumberValid(reqDto);
    //assert
    expect(phoneFindValidUseCase.hasPhoneAuthNumberError(), true);
  });

  test('should 폰 인증 번호에 에러가 없을때', () async {
    //arrange
    PwFindPhoneAuthNumber result = PwFindPhoneAuthNumber();
    result.errorFlag = false;
    result.errorCause = "";
    when(mockPhoneAuthRepository.reqPwFindNumberAuth(any)).thenAnswer((_) async => result);
    PwFindPhoneAuthNumberReqDto reqDto = PwFindPhoneAuthNumberReqDto();
    reqDto.phoneNumber = "+8201088884444";
    reqDto.email = "tetst@gmail.com";
    reqDto.authNumber = "234567";
    //act
    await phoneFindValidUseCase.phoneAuthNumberValid(reqDto);
    //assert
    expect(phoneFindValidUseCase.hasPhoneAuthNumberError(), false);
  });

  test('should 폰으로 PassWord 변경시 에러 발생', () async {
    //arrange
    PwChangeFromPhoneAuth result = PwChangeFromPhoneAuth();
    result.errorFlag = true;
    result.cause = "원인 알수 없는 에러";
    when(mockPhoneAuthRepository.reqChangePwAuthPhone(any)).thenAnswer((_) async => result);

    PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
    reqDto.emailPhoneAuthToken = "TESTTEST";
    reqDto.password = "Aa123123";
    reqDto.internationalizedPhoneNumber = "+82010000000";
    reqDto.email = "tetst@gmail.com";

    //act
    await phoneFindValidUseCase.phonePwChangeWithValid(reqDto);
    //assert
    expect(phoneFindValidUseCase.hasPhonePwChangeError(), true);
  });

  test('should 폰으로 PassWord 변경시 에러 발생', () async {
    //arrange
    PwChangeFromPhoneAuth result = PwChangeFromPhoneAuth();
    result.errorFlag = false;
    result.cause = "";
    when(mockPhoneAuthRepository.reqChangePwAuthPhone(any)).thenAnswer((_) async => result);

    PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
    reqDto.emailPhoneAuthToken = "TESTTEST";
    reqDto.password = "Aa123123";
    reqDto.internationalizedPhoneNumber = "+82010000000";
    reqDto.email = "tetst@gmail.com";

    //act
    await phoneFindValidUseCase.phonePwChangeWithValid(reqDto);
    //assert
    expect(phoneFindValidUseCase.hasPhonePwChangeError(), false);
  });
}
