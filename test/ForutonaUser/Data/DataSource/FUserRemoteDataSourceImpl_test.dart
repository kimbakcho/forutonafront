import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
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

  test('should getUserInfoSimple1 API Call', () async {
    //arrange
    var resResult = FUserInfoSimple1();
    resResult.nickName = "test";
    resResult.profilePictureUrl = "test";
    resResult.followCount = 0;
    when(fDio.get("/v1/ForutonaUser/UserInfoSimple1",
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: resResult.toJson()));
    //act
    var result = await fUserRemoteDataSource.getUserInfoSimple1(
        FUserReqDto("testUid"), fDio);
    //assert
    verify(fDio.get("/v1/ForutonaUser/UserInfoSimple1",
        queryParameters: anyNamed('queryParameters')));
    expect(result.nickName, "test");
    expect(result.profilePictureUrl, "test");
    expect(result.followCount, 0);
  });

  test('should updateUserPosition API Call', () async {
    //arrange
    when(fDio.put("/v1/ForutonaUser/UserPosition", data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: 1));
    //act
    var result = await fUserRemoteDataSource.updateUserPosition(
        LatLng(127.1, 31.1), fDio);
    //assert
    verify(fDio.put("/v1/ForutonaUser/UserPosition", data: anyNamed('data')));
    expect(result, 1);
  });


  test('should be API Call updateFireBaseMessageToken', () async {
    //arrange
    when(fDio.put("/v1/ForutonaUser/FireBaseMessageToken", queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: 1));
    //act
    var result = await fUserRemoteDataSource.updateFireBaseMessageToken("test","testToken",fDio);
    //assert
    verify(fDio.put("/v1/ForutonaUser/FireBaseMessageToken", queryParameters: anyNamed('queryParameters')));
    expect(result, 1);
  });


  test('should be API Call checkNickNameDuplication', () async {
    //arrange
    when(fDio.get("/v1/ForutonaUser/checkNickNameDuplication", queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(data: true));
    //act
    var result = await fUserRemoteDataSource.checkNickNameDuplication("testNickName",fDio);
    //assert
    verify(fDio.get("/v1/ForutonaUser/checkNickNameDuplication", queryParameters: anyNamed('queryParameters')));
    expect(result, true);
  });

  test('should be API Call getForutonaGetMe', () async {
    //arrange
    FUserInfoResDto fUserInfoResDto = FUserInfoResDto();
    fUserInfoResDto.uid = "testUid";
    when(fDio.get("/v1/ForutonaUser/Me"))
        .thenAnswer((_) async => Response<dynamic>(data: fUserInfoResDto.toJson()));
    //act
    var result = await fUserRemoteDataSource.getForutonaGetMe(fDio);
    //assert
    verify(fDio.get("/v1/ForutonaUser/Me"));
  });

  test('should be API Call updateUserProfileImage', () async {
    //arrange
    FormData formData = FormData.fromMap({
      "ProfileImage": MultipartFile.fromBytes([2,3,4,5],contentType: MediaType("image", "jpeg"),filename: "ProfileImage.jpg")
    });
    when(fDio.put("/v1/ForutonaUser/ProfileImage",data: formData ))
        .thenAnswer((_) async => Response<dynamic>(data: "imageUrl"));
    //act
    var result = await fUserRemoteDataSource.updateUserProfileImage(formData,fDio);
    //assert
    verify(fDio.put("/v1/ForutonaUser/ProfileImage",data: formData));
  });

  test('should', () async {
    //TODO TEST 작성 필요.
    //arrange

    //act

    //assert
  });
}
