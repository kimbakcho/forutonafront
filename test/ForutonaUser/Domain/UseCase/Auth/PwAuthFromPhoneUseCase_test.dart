import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:mockito/mockito.dart';

class MockPhoneAuthRepository extends Mock implements PhoneAuthRepository {}

class MockPwAuthFromPhoneUseCaseOutputPort extends Mock
    implements PwAuthFromPhoneUseCaseOutputPort {}

void main() {
  PwAuthFromPhoneUseCaseInputPort pwAuthFromPhoneUseCaseInputPort;
  MockPhoneAuthRepository mockPhoneAuthRepository;
  MockPwAuthFromPhoneUseCaseOutputPort mockPwAuthFromPhoneUseCaseOutputPort;
  setUp(() {
    mockPwAuthFromPhoneUseCaseOutputPort =
        MockPwAuthFromPhoneUseCaseOutputPort();
    mockPhoneAuthRepository = MockPhoneAuthRepository();
    pwAuthFromPhoneUseCaseInputPort =
        PwAuthFromPhoneUseCase(phoneAuthRepository: mockPhoneAuthRepository);
  });

  test('레포지토리를 통해 서버에 요청 인증 번호 요청 및 인증 결과 Output Port 로 출력', () async {
    //arrange
    PhoneAuth phoneAuth = PhoneAuth();
    when(mockPhoneAuthRepository.reqPhoneAuth(any))
        .thenAnswer((realInvocation) async => phoneAuth);
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = "KR";
    reqDto.phoneNumber = "010888442222";
    reqDto.internationalizedPhoneNumber = "0108484822222";
    //act
    await pwAuthFromPhoneUseCaseInputPort.reqPhoneAuth(reqDto,
        outputPort: mockPwAuthFromPhoneUseCaseOutputPort);
    //assert
    verify(mockPhoneAuthRepository.reqPhoneAuth(reqDto));
    verify(mockPwAuthFromPhoneUseCaseOutputPort.onPhoneAuth(any));
  });

  test('레포지토리를 통해 서버에 요청 인증 번호 확인 Output Port 로 출력', () async {
    //arrange
    PhoneAuthNumberReqDto reqDto = PhoneAuthNumberReqDto();
    reqDto.internationalizedPhoneNumber = "TEST";
    reqDto.phoneNumber = "TEST";
    reqDto.isoCode = "KR";
    reqDto.authNumber = "202000";
    //act
    await pwAuthFromPhoneUseCaseInputPort.reqNumberAuthReq(reqDto,
        outputPort: mockPwAuthFromPhoneUseCaseOutputPort);
    //assert
    verify(mockPhoneAuthRepository.reqNumberAuthReq(reqDto));
    verify(mockPwAuthFromPhoneUseCaseOutputPort.onNumberAuthReq(any));
  });
}
