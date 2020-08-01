import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:http_parser/http_parser.dart';

class MockFDio extends Mock implements FDio {}

void main() {
  FUserRemoteDataSource fUserRemoteDataSource;
  FDio fDio;

  setUp(() {
    fUserRemoteDataSource = FUserRemoteDataSourceImpl();
    fDio = MockFDio();
  });

  test('should updateUserPosition API Call', () async {
    //arrange
    when(fDio.put("/v1/FUserInfo/UserPosition", data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: 1));
    //act
    var result = await fUserRemoteDataSource.updateUserPosition(
        LatLng(127.1, 31.1), fDio);
    //assert
    verify(fDio.put("/v1/FUserInfo/UserPosition", data: anyNamed('data')));
  });


  test('should be API Call updateFireBaseMessageToken', () async {
    //arrange
    when(fDio.put("/v1/FUserInfo/FireBaseMessageToken", queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: 1));
    //act
    var result = await fUserRemoteDataSource.updateFireBaseMessageToken("testToken",fDio);
    //assert
    verify(fDio.put("/v1/FUserInfo/FireBaseMessageToken", queryParameters: anyNamed('queryParameters')));

  });


  test('should be API Call checkNickNameDuplication', () async {
    //arrange
    when(fDio.get("/v1/FUserInfo/CheckNickNameDuplication", queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: true));
    //act
    var result = await fUserRemoteDataSource.checkNickNameDuplication("testNickName",fDio);
    //assert
    verify(fDio.get("/v1/FUserInfo/CheckNickNameDuplication", queryParameters: anyNamed('queryParameters')));
    expect(result, true);
  });

  test('should be API Call uploadUserProfileImage', () async {
    //arrange
    when(fDio.put("/v1/FUserInfo/ProfileImage",data: anyNamed('data') ))
        .thenAnswer((_) async => Response<dynamic>(data: "imageUrl"));
    List<int> testBytes = [0,0,2,3,4];
    //act

    await fUserRemoteDataSource.uploadUserProfileImage(testBytes,fDio);
    //assert
    verify(fDio.put("/v1/FUserInfo/ProfileImage",data: anyNamed('data')));
  });

  test('API should be called  updateAccountUserInfo', () async {
    //arrange
    when(fDio.put("/v1/FUserInfo/AccountUserInfo",data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: 1));
    //act
    await fUserRemoteDataSource.updateAccountUserInfo(FUserAccountUpdateReqDto(),fDio);
    //assert
    verify(fDio.put("/v1/FUserInfo/AccountUserInfo",data: anyNamed('data')));
  });


  test('API should be called  pWChange', () async {
    //arrange
    when(fDio.put("/v1/FUserInfo/PwChange",data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: 1));
    //act
    await fUserRemoteDataSource.pWChange("TEST",fDio);
    //assert
    verify(fDio.put("/v1/FUserInfo/PwChange",data: anyNamed('data')));
  });

  test('API should be called  getSnsUserJoinCheckInfo', () async {
    //arrange
    FUserSnsCheckJoinResDto fUserSnsCheckJoin = FUserSnsCheckJoinResDto();
    fUserSnsCheckJoin.email = "test@gmail.com";
    when(fDio.get("/v1/FUserInfo/SnsUserJoinCheckInfo",queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: fUserSnsCheckJoin.toJson()));
    //act
    await fUserRemoteDataSource.getSnsUserJoinCheckInfo(SnsSupportService.FaceBook,"TEST",fDio);
    //assert
    verify(fDio.get("/v1/FUserInfo/SnsUserJoinCheckInfo",queryParameters: anyNamed('queryParameters')));
  });

  test('API should be called  joinUser', () async {
    //arrange
    FUserInfoJoinResDto fUserInfoJoin = new FUserInfoJoinResDto();
    fUserInfoJoin.customToken="TESTTOKEN";
    when(fDio.post("/v1/FUserInfo/JoinUser",data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: fUserInfoJoin.toJson()));
    //act
    FUserInfoJoinReqDto fUserInfoJoinReqDto = FUserInfoJoinReqDto();
    fUserInfoJoinReqDto.email = "TEST@gmail.com";
    fUserInfoJoinReqDto.internationalizedPhoneNumber="01064546846";
    await fUserRemoteDataSource.joinUser(fUserInfoJoinReqDto,fDio);
    //assert
    verify(fDio.post("/v1/FUserInfo/JoinUser",data: anyNamed('data')));
  });
}
