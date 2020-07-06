import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCaeInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:mockito/mockito.dart';


class MockFUserRepository extends Mock implements FUserRepository{}

void main(){
  UserInfoUpdateUseCaeInputPort userInfoUpdateUseCaeInputPort;
  MockFUserRepository mockFUserRepository;
  setUp((){
    mockFUserRepository= MockFUserRepository();
    userInfoUpdateUseCaeInputPort = UserInfoUpdateUseCase(fUserRepository: mockFUserRepository);
  });

  test('should Update 레포지토리 호출 ', () async {
    //arrange
    FuserAccountUpdateReqdto reqDto = new FuserAccountUpdateReqdto();
    reqDto.userProfileImageUrl ="https://goo.png";
    reqDto.nickName="test";
    reqDto.selfIntroduction = "test";
    //act
    await userInfoUpdateUseCaeInputPort.updateAccountUserInfo(reqDto);
    //assert
    verify(mockFUserRepository.updateAccountUserInfo(reqDto));

  });
}