import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:mockito/mockito.dart';

class MockPhoneAuthRepository extends Mock implements PhoneAuthRepository {}

void main() {
  PwFindPhoneUseCaseInputPort pwFindPhoneUseCaseInputPort;
  MockPhoneAuthRepository mockPhoneAuthRepository;

  setUp(() {
    mockPhoneAuthRepository = MockPhoneAuthRepository();
    pwFindPhoneUseCaseInputPort =
        PwFindPhoneUseCase(phoneAuthRepository: mockPhoneAuthRepository);
  });

  test('레포지 토리에 Pw 변경 요청 검증', () async {
    //arrange
    PwChangeFromPhoneAuthReqDto pwChangeFromPhoneAuthReqDto =
        PwChangeFromPhoneAuthReqDto();
    pwChangeFromPhoneAuthReqDto.email = "test@Email.com";
    PwChangeFromPhoneAuthResDto pwChangeFromPhoneAuth = PwChangeFromPhoneAuthResDto();
    pwChangeFromPhoneAuth.email = "test@Email.com";
    when(mockPhoneAuthRepository.reqChangePwAuthPhone(any))
        .thenAnswer((realInvocation) async => pwChangeFromPhoneAuth);
    //act
    await pwFindPhoneUseCaseInputPort.phonePwChange(pwChangeFromPhoneAuthReqDto);
    //assert
    verify(mockPhoneAuthRepository.reqChangePwAuthPhone(any));
  });
}
