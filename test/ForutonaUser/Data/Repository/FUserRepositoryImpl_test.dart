import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:http_parser/http_parser.dart';

class MockUserRemoteDataSource extends Mock implements FUserRemoteDataSource {}
class MockFireBaseAdapter extends Mock implements FireBaseAuthAdapterForUseCase{}
void main() {
  FUserRepository fUserRepository;
  MockUserRemoteDataSource mockUserRemoteDataSource;
  MockFireBaseAdapter mockFireBaseAdapter;

  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockFireBaseAdapter = MockFireBaseAdapter();
    fUserRepository =
        FUserRepositoryImpl(fUserRemoteDataSource: mockUserRemoteDataSource,
        fireBaseAuthBaseAdapter: mockFireBaseAdapter);
    when(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter)).thenAnswer((realInvocation) async=> "token");
  });

  test('updateUserPosition DataSource call', () async {
    //arrange
    when(mockUserRemoteDataSource.updateUserPosition(LatLng(121.0,37.0),any));

    //act
    await fUserRepository.updateUserPosition(LatLng(121.0, 37.0));
    //assert
    verify(mockUserRemoteDataSource.updateAccountUserInfo(any, any));
  });

  test('updateFireBaseMessageToken DataSource call', () async {
    //arrange

    //act
    await fUserRepository.updateFireBaseMessageToken("test",);
    //assert
    verify(mockUserRemoteDataSource.updateFireBaseMessageToken(any, any));

  });


  test('should be checkNickNameDuplication DataSource Call', () async {
    //arrange
    when(mockUserRemoteDataSource.checkNickNameDuplication("testNickName",any))
        .thenAnswer((_)async => true);
    //act
    await fUserRepository.checkNickNameDuplication("testNickName");
    //assert
    verify(mockUserRemoteDataSource.checkNickNameDuplication("testNickName", any));
  });

  test('should be uploadUserProfileImage DataSource Call', () async {
    //arrange
    when(mockUserRemoteDataSource.uploadUserProfileImage(any,any))
        .thenAnswer((_)async => "https://urlImage.com/image.jpg");
    List<int> imageByte = [0,2,3,4,5,6];
    //act

    await fUserRepository.uploadUserProfileImage(imageByte);
    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.uploadUserProfileImage(imageByte,any));
  });

  test('should be updateAccountUserInfo DataSource Call', () async {
    //arrange
    FUserAccountUpdateReqDto fuserAccountUpdateReqdto = FUserAccountUpdateReqDto();

    //act
    await fUserRepository.updateAccountUserInfo(fuserAccountUpdateReqdto);

    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.updateAccountUserInfo(fuserAccountUpdateReqdto,any));
  });

  test('should be pWChange DataSource Call', () async {
    //arrange

    //act
    await fUserRepository.pWChange("TEST");

    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.pWChange("TEST",any));
  });

  test('should be getSnsUserJoinCheckInfo DataSource Call ', () async {
    //arrange
    FUserSnSJoinReqDto fUserInfoPwChangeReqDto = FUserSnSJoinReqDto();
    fUserInfoPwChangeReqDto.accessToken="SNSAuthToken";
    fUserInfoPwChangeReqDto.snsService=SnsSupportService.Kakao;
    fUserInfoPwChangeReqDto.snsUid="snsUid";
    fUserInfoPwChangeReqDto.fUserUid="FirebaseUid";

    FUserSnsCheckJoinResDto fUserSnsCheckJoin =  FUserSnsCheckJoinResDto();
    fUserSnsCheckJoin.snsUid= "snsUid";
    fUserSnsCheckJoin.email="test@gmail.com";
    fUserSnsCheckJoin.firebaseCustomToken = "loginToken";
    fUserSnsCheckJoin.join = true;

    when(mockUserRemoteDataSource.getSnsUserJoinCheckInfo(SnsSupportService.Kakao,"TEST",any))
        .thenAnswer((_)async => fUserSnsCheckJoin);

    //act
    await fUserRepository.getSnsUserJoinCheckInfo(SnsSupportService.Kakao,"TEST");

    //assert
    verify(mockUserRemoteDataSource.getSnsUserJoinCheckInfo(SnsSupportService.Kakao,"TEST",any));
  });

  test('should be joinUser DataSource Call', () async {
    //arrange
    FUserInfoJoinReqDto fUserInfoJoinReqDto = FUserInfoJoinReqDto();
    fUserInfoJoinReqDto.email = "test@gmail.com";
    fUserInfoJoinReqDto.snsSupportService =SnsSupportService.Kakao;
    fUserInfoJoinReqDto.positionAgree = true;

    FUserInfoJoinResDto fUserInfoJoin =  FUserInfoJoinResDto();
    fUserInfoJoin.customToken ="loginToken";
    fUserInfoJoin.joinComplete = true;

    when(mockUserRemoteDataSource.joinUser(fUserInfoJoinReqDto,any))
        .thenAnswer((_)async => fUserInfoJoin);

    //act
    await fUserRepository.joinUser(fUserInfoJoinReqDto);

    //assert
    verify(mockUserRemoteDataSource.joinUser(fUserInfoJoinReqDto,any));
  });
}

Future<String> isGivenFireBaseTokenToDataSource(MockFireBaseAdapter mockFireBaseAdapter) => mockFireBaseAdapter.getFireBaseIdToken();
