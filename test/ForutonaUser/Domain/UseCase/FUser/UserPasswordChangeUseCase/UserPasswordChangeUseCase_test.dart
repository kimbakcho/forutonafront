import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:mockito/mockito.dart';

class MockFUserRepository extends Mock implements FUserRepository{}
void main() {
  MockFUserRepository mockFUserRepository;
  UserPasswordChangeUseCaseInputPort userPasswordChangeUseCaseInputPort;

  setUp((){
    mockFUserRepository = MockFUserRepository();
    userPasswordChangeUseCaseInputPort = UserPasswordChangeUseCase(fUserRepository:mockFUserRepository);
  });
  test('pwChange 레포지 토리 호출 ', () async {
    //arrange
    FUserInfoPwChangeReqDto reqDto = FUserInfoPwChangeReqDto("Aa!123123");
    //act
    await userPasswordChangeUseCaseInputPort.pwChange(reqDto);
    //assert
    verify(mockFUserRepository.pWChange(reqDto));
  });
}