import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:mockito/mockito.dart';

class MockPhoneAuthRepository extends Mock implements PhoneAuthRepository {}

class MockPwFindPhoneUseCaseOutputPort extends Mock
    implements PwFindPhoneUseCaseOutputPort {}

void main() {
  PwFindPhoneUseCaseInputPort pwFindPhoneUseCaseInputPort;
  MockPhoneAuthRepository mockPhoneAuthRepository;
  MockPwFindPhoneUseCaseOutputPort mockPwFindPhoneUseCaseOutputPort;
  setUp(() {
    mockPhoneAuthRepository = MockPhoneAuthRepository();
    mockPwFindPhoneUseCaseOutputPort = MockPwFindPhoneUseCaseOutputPort();
    pwFindPhoneUseCaseInputPort =
        PwFindPhoneUseCase(phoneAuthRepository: mockPhoneAuthRepository);
  });

  test('레포지 토리에 Pw 변경 요청 검증', () async {
    //arrange
    PwChangeFromPhoneAuthReqDto pwChangeFromPhoneAuthReqDto =
        PwChangeFromPhoneAuthReqDto();
    pwChangeFromPhoneAuthReqDto.email = "test@Email.com";
    PwChangeFromPhoneAuth pwChangeFromPhoneAuth = PwChangeFromPhoneAuth();
    pwChangeFromPhoneAuth.email = "test@Email.com";
    when(mockPhoneAuthRepository.reqChangePwAuthPhone(any))
        .thenAnswer((realInvocation) async => pwChangeFromPhoneAuth);
    //act
    await pwFindPhoneUseCaseInputPort.phonePwChange(outputPort: mockPwFindPhoneUseCaseOutputPort);
    //assert
    verify(mockPhoneAuthRepository.reqChangePwAuthPhone(any));
  });
}