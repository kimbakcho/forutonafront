import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoin.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateUserUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Preference.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
class MockFUserRepository extends Mock implements FUserRepository {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}
class MockFireBaseCreateUserUseCaseInputPort extends Mock implements FireBaseCreateUserUseCaseInputPort{}
void main() {
  SingUpUseCase singUpUseCase;
  MockFUserRepository mockFUserRepository;
  MockFireBaseCreateUserUseCaseInputPort mockFireBaseCreateUserUseCaseInputPort;
  setUp(() {
    mockFireBaseCreateUserUseCaseInputPort =  MockFireBaseCreateUserUseCaseInputPort();
    mockFUserRepository = new MockFUserRepository();

    singUpUseCase = SingUpUseCase(
        fUserRepository: mockFUserRepository,
        preference: Preference());
  });

  test('should be 가입 여부 체크 ', () async {
    //arrange
    FUserSnSLoginReqDto reqDto = FUserSnSLoginReqDto();
    reqDto.snsUid = "snsUid";
    reqDto.snsService = SnsSupportService.Kakao;
    reqDto.fUserUid = "${SnsSupportService.Kakao}${reqDto.snsUid}";
    reqDto.accessToken = "kakaoToken";
    FUserSnsCheckJoin fUserSnsCheckJoin = FUserSnsCheckJoin();
    fUserSnsCheckJoin.snsUid = "snsUid";

    when(mockFUserRepository.getSnsUserJoinCheckInfo(any))
        .thenAnswer((realInvocation) async => fUserSnsCheckJoin);
    //act
    await singUpUseCase.snsUidJoinCheck(reqDto);
    //assert
    verify(mockFUserRepository.getSnsUserJoinCheckInfo(reqDto));
  });

  test('should be 가입시 FireBase 가입 및 BackEnd Repository 호출  ', () async {
    //arrange
    FUserInfoJoinReqDto reqDto = FUserInfoJoinReqDto();
    reqDto.nickName = "TESTNickName";
    FUserInfoJoin fUserInfoJoin = new FUserInfoJoin();
    fUserInfoJoin.customToken = "testToken";
    fUserInfoJoin.joinComplete = true;


    when(mockFUserRepository.joinUser(any))
        .thenAnswer((realInvocation) async => fUserInfoJoin);
    //act
    await singUpUseCase.joinUser(mockFireBaseCreateUserUseCaseInputPort);
    //assert
    verifyInOrder([
      mockFireBaseCreateUserUseCaseInputPort.createUser(email: anyNamed('email'),pw: anyNamed('pw')),
      mockFUserRepository.joinUser(any)
    ]);
  });

}
