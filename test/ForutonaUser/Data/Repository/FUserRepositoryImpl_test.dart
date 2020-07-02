import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoin.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
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
    when(mockUserRemoteDataSource.updateUserPosition(LatLng(121.0,37.0),any))
        .thenAnswer((_) async => 1);
    //act
    int result =
        await fUserRepository.updateUserPosition(LatLng(121.0, 37.0));
    //assert
    expect(result, 1);
  });

  test('updateFireBaseMessageToken DataSource call', () async {
    //arrange
    when(mockUserRemoteDataSource.updateFireBaseMessageToken(any,any,any))
        .thenAnswer((_) async => 1);
    //act
    int result =
    await fUserRepository.updateFireBaseMessageToken("test","testToken");
    //assert
    verify(mockUserRemoteDataSource.updateFireBaseMessageToken(any, any, any));
    expect(result, 1);
  });


  test('updateUserPosition DataSource call', () async {
    //arrange
    when(mockUserRemoteDataSource.updateUserPosition(LatLng(121.0,37.0),any))
        .thenAnswer((_) async => 1);
    //act
    int result =
    await fUserRepository.updateUserPosition(LatLng(121.0, 37.0));
    //assert
    expect(result, 1);
  });


  test('FUserInfoSimple1 DataSource Call', () async {
    //arrange
    var resResult = FUserInfoSimple1();
    resResult.nickName = "test";
    resResult.profilePictureUrl = "test";
    when(mockUserRemoteDataSource.getUserInfoSimple1(any,any))
        .thenAnswer((_)async => resResult);
    //act
    FUserInfoSimple1 result = await fUserRepository.getUserInfoSimple1(FUserReqDto("testUid"));
    //assert
    verify(mockUserRemoteDataSource.getUserInfoSimple1(any,any));
    expect(result.nickName, "test");
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

  test('should be getForutonaGetMe DataSource Call', () async {
    //arrange
    FUserInfo fUserInfo = new FUserInfo();
    fUserInfo.uid = "tsetUid";
    fUserInfo.nickName = 'testNickName';

    when(mockUserRemoteDataSource.getForutonaGetMe(any))
        .thenAnswer((_)async => fUserInfo);
    //act
    await fUserRepository.getForutonaGetMe("tsetUid");

    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.getForutonaGetMe(any));
  });

  test('should be uploadUserProfileImage DataSource Call', () async {
    //arrange
    when(mockUserRemoteDataSource.uploadUserProfileImage(any,any))
        .thenAnswer((_)async => "https://urlImage.com/image.jpg");
    FormData formData = FormData.fromMap({
      "ProfileImage": MultipartFile.fromBytes(
          [1,2,3,4], contentType: MediaType("image", "jpeg"),
          filename: "ProfileImage.jpg")
    });
    //act

    await fUserRepository.uploadUserProfileImage(formData);

    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.uploadUserProfileImage(formData,any));
  });

  test('should be updateAccountUserInfo DataSource Call', () async {
    //arrange
    FuserAccountUpdateReqdto fuserAccountUpdateReqdto = FuserAccountUpdateReqdto("Kr","TestNickName","introduce");

    when(mockUserRemoteDataSource.updateAccountUserInfo(fuserAccountUpdateReqdto,any))
        .thenAnswer((_)async => 1);

    //act
    await fUserRepository.updateAccountUserInfo(fuserAccountUpdateReqdto);

    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.updateAccountUserInfo(fuserAccountUpdateReqdto,any));
  });

  test('should be pWChange DataSource Call', () async {
    //arrange
    FUserInfoPwChangeReqDto fUserInfoPwChangeReqDto = FUserInfoPwChangeReqDto("changePw");

    when(mockUserRemoteDataSource.pWChange(fUserInfoPwChangeReqDto,any))
        .thenAnswer((_)async => 1);

    //act
    await fUserRepository.pWChange(fUserInfoPwChangeReqDto);

    //assert
    verify(isGivenFireBaseTokenToDataSource(mockFireBaseAdapter));

    verify(mockUserRemoteDataSource.pWChange(fUserInfoPwChangeReqDto,any));
  });

  test('should be getSnsUserJoinCheckInfo DataSource Call ', () async {
    //arrange
    FUserSnSLoginReqDto fUserInfoPwChangeReqDto = FUserSnSLoginReqDto();
    fUserInfoPwChangeReqDto.accessToken="SNSAuthToken";
    fUserInfoPwChangeReqDto.snsService=SnsSupportService.Kakao;
    fUserInfoPwChangeReqDto.snsUid="snsUid";
    fUserInfoPwChangeReqDto.fUserUid="FirebaseUid";

    FUserSnsCheckJoin fUserSnsCheckJoin =  FUserSnsCheckJoin();
    fUserSnsCheckJoin.snsUid= "snsUid";
    fUserSnsCheckJoin.email="test@gmail.com";
    fUserSnsCheckJoin.firebaseCustomToken = "loginToken";
    fUserSnsCheckJoin.join = true;

    when(mockUserRemoteDataSource.getSnsUserJoinCheckInfo(fUserInfoPwChangeReqDto,any))
        .thenAnswer((_)async => fUserSnsCheckJoin);

    //act
    await fUserRepository.getSnsUserJoinCheckInfo(fUserInfoPwChangeReqDto);

    //assert
    verify(mockUserRemoteDataSource.getSnsUserJoinCheckInfo(fUserInfoPwChangeReqDto,any));
  });

  test('should be joinUser DataSource Call', () async {
    //arrange
    FUserInfoJoinReqDto fUserInfoJoinReqDto = FUserInfoJoinReqDto();
    fUserInfoJoinReqDto.email = "test@gmail.com";
    fUserInfoJoinReqDto.snsSupportService =SnsSupportService.Kakao;
    fUserInfoJoinReqDto.positionAgree = true;

    FUserInfoJoin fUserInfoJoin =  FUserInfoJoin();
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
