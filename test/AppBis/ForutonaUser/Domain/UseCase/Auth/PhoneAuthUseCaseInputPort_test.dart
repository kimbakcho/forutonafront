import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:mockito/mockito.dart';

class MockPhoneAuthRepository extends Mock implements PhoneAuthRepository {}


void main() {
  PhoneAuthUseCaseInputPort phoneAuthUseCaseInputPort;
  MockPhoneAuthRepository mockPhoneAuthRepository;
  setUp(() {
    mockPhoneAuthRepository = MockPhoneAuthRepository();
    phoneAuthUseCaseInputPort =
        PhoneAuthUseCase(phoneAuthRepository: mockPhoneAuthRepository);
  });

  test('레포지토리를 통해 서버에 요청 인증 번호 요청 및 인증 결과 Output Port 로 출력', () async {
    //arrange
    PhoneAuthResDto phoneAuth = PhoneAuthResDto();
    when(mockPhoneAuthRepository.reqPhoneAuth(any))
        .thenAnswer((realInvocation) async => phoneAuth);
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = "KR";
    reqDto.phoneNumber = "010888442222";
    reqDto.internationalizedDialCode = "0108484822222";
    //act
    await phoneAuthUseCaseInputPort.reqPhoneAuth(reqDto);
    //assert
    verify(mockPhoneAuthRepository.reqPhoneAuth(reqDto));
  });

  test('레포지토리를 통해 서버에 요청 인증 번호 확인 Output Port 로 출력', () async {
    //arrange
    PhoneAuthNumberReqDto reqDto = PhoneAuthNumberReqDto();
    reqDto.internationalizedDialCode = "TEST";
    reqDto.phoneNumber = "TEST";
    reqDto.isoCode = "KR";
    reqDto.authNumber = "202000";
    //act
    await phoneAuthUseCaseInputPort.reqNumberAuthReq(reqDto);
    //assert
    verify(mockPhoneAuthRepository.reqNumberAuthReq(reqDto));
  });
}
