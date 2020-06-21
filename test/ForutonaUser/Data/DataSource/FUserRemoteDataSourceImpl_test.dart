import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockFDio extends Mock implements FDio {}

void main() {
  FUserRemoteDataSource fUserRemoteDataSource;
  FDio fDio;

  setUp(() {
    fUserRemoteDataSource = FUserRemoteDataSourceImpl();
    fDio = MockFDio();
  });

  test('should getUserInfoSimple1', () async {
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

  test('should updateUserPosition', () async {
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
}
