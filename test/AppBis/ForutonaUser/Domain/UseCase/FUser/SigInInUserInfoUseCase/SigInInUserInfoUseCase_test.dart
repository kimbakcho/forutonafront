import 'package:flutter_test/flutter_test.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockSignInUserInfoUseCaseOutputPort extends Mock implements SignInUserInfoUseCaseOutputPort{}

class MockFUserRepository extends Mock implements FUserRepository{}

void main () {
  SignInUserInfoUseCaseInputPort signInUserInfoUseCase;
  MockSignInUserInfoUseCaseOutputPort mockSignInUserInfoUseCaseOutputPort;
  MockFUserRepository mockFUserRepository;
  final sl = GetIt.instance;

  setUpAll((){
    sl.registerSingleton<Preference>(Preference());
  });
  setUp((){

    mockFUserRepository = MockFUserRepository();
    mockSignInUserInfoUseCaseOutputPort = MockSignInUserInfoUseCaseOutputPort();
    signInUserInfoUseCase = SignInUserInfoUseCase(fUserRepository: mockFUserRepository);
  });

  test('UserInfo 정보를 Repository를 사용하여 저장함', () async {
    //arrange
    FUserInfoResDto fUserInfo = new FUserInfoResDto();
    fUserInfo.uid = "testUid";
    fUserInfo.nickName = "testNickName";
    when(mockFUserRepository.findByMe()).thenAnswer((realInvocation)async => fUserInfo);
    //act
    await signInUserInfoUseCase.saveSignInInfoInMemoryFromAPiServer();
    //assert
    verify(mockFUserRepository.findByMe());
  });

  test('메모리에서 저장하고 유저 정보 요청', () async {
    //arrange
    FUserInfoResDto fUserInfo = new FUserInfoResDto();
    fUserInfo.uid = "testUid";
    fUserInfo.nickName = "testNickName";
    when(mockFUserRepository.findByMe()).thenAnswer((realInvocation)async => fUserInfo);
    //act
    await signInUserInfoUseCase.saveSignInInfoInMemoryFromAPiServer();
    signInUserInfoUseCase.reqSignInUserInfoFromMemory(outputPort: mockSignInUserInfoUseCaseOutputPort);
    //assert
    var captured2 = verify(mockSignInUserInfoUseCaseOutputPort.onSignInUserInfoFromMemory(captureAny)).captured;
    var arg = captured2[0] as FUserInfoResDto;
    expect(arg.uid, "testUid");
    expect(arg.nickName, "testNickName");
  });

  test('유저 정보 서버로 부터 가져온뒤에 onSignInUserInfoFromMemory 실행 ', () async {
    //arrange
    FUserInfoResDto fUserInfo = new FUserInfoResDto();
    fUserInfo.uid = "testUid";
    fUserInfo.nickName = "testNickName";
    when(mockFUserRepository.findByMe()).thenAnswer((realInvocation)async => fUserInfo);
    //act
    await signInUserInfoUseCase.saveSignInInfoInMemoryFromAPiServer(outputPort: mockSignInUserInfoUseCaseOutputPort);
    //assert
    verify(mockSignInUserInfoUseCaseOutputPort.onSignInUserInfoFromMemory(any));
  });

}
