import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
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
    PwFindPhoneAuthResDto result = PwFindPhoneAuthResDto();
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
    PwFindPhoneAuthResDto result = PwFindPhoneAuthResDto();
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
    PwFindPhoneAuthNumberResDto result = PwFindPhoneAuthNumberResDto();
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
    PwFindPhoneAuthNumberResDto result = PwFindPhoneAuthNumberResDto();
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

}
