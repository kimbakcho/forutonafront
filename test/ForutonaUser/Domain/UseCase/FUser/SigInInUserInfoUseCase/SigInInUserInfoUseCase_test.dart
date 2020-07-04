import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
class MockSignInUserInfoUseCaseOutputPort extends Mock implements SignInUserInfoUseCaseOutputPort{}
class MockFUserRepository extends Mock implements FUserRepository{}
void main () {

  SignInUserInfoUseCaseInputPort signInUserInfoUseCase;
  MockSignInUserInfoUseCaseOutputPort mockSignInUserInfoUseCaseOutputPort;
  MockFUserRepository mockFUserRepository;

  setUp((){
    mockFUserRepository = MockFUserRepository();
    mockSignInUserInfoUseCaseOutputPort = MockSignInUserInfoUseCaseOutputPort();
    signInUserInfoUseCase = SignInUserInfoUseCase(fUserRepository: mockFUserRepository);
  });

  test('UserInfo 정보를 Repository를 사용하여 저장함', () async {
    //arrange
    FUserInfo fUserInfo = new FUserInfo();
    fUserInfo.uid = "testUid";
    fUserInfo.nickName = "testNickName";
    when(mockFUserRepository.getForutonaGetMe("testUid")).thenAnswer((realInvocation)async => fUserInfo);
    //act
    await signInUserInfoUseCase.saveSignInInfoInMemoryFromAPiServer(fUserInfo.uid);
    //assert
    verify(mockFUserRepository.getForutonaGetMe("testUid"));
  });

  test('메모리에서 저장하고 유저 정보 요청', () async {
    //arrange
    FUserInfo fUserInfo = new FUserInfo();
    fUserInfo.uid = "testUid";
    fUserInfo.nickName = "testNickName";
    when(mockFUserRepository.getForutonaGetMe("testUid")).thenAnswer((realInvocation)async => fUserInfo);
    //act
    await signInUserInfoUseCase.saveSignInInfoInMemoryFromAPiServer(fUserInfo.uid);
    signInUserInfoUseCase.reqSignInUserInfoFromMemory(mockSignInUserInfoUseCaseOutputPort);
    //assert
    var captured2 = verify(mockSignInUserInfoUseCaseOutputPort.onSignInUserInfoFromMemory(captureAny)).captured;
    var arg = captured2[0] as FUserInfo;
    expect(arg.uid, "testUid");
    expect(arg.nickName, "testNickName");
  });

  test('저장된 정보가 없을때 에러 출력', () async {
    //arrange

    //act

    //assert
    expect(()=>signInUserInfoUseCase.reqSignInUserInfoFromMemory(mockSignInUserInfoUseCaseOutputPort),
        throwsA(TypeMatcher<Exception>())
    );
  });
}
