import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:mockito/mockito.dart';

import '../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../fixtures/fixture_reader.dart';

class MockFBallRemoteDataSource extends Mock implements FBallRemoteDataSource {}

void main() {
  String ballUuid = "TESTBallUuid";
  String testUid = "TESTUid";
  setUp(() {
    di.init();
    sl.allowReassignment = true;

    MockFBallRemoteDataSource mockFBallRemoteDataSource =
        MockFBallRemoteDataSource();
    var basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        ballUuid, FUserInfoSimpleTestUtil.getBasicUserResDto(testUid));

    when(mockFBallRemoteDataSource.selectBall(
            ballUuid: ballUuid, noneTokenFDio: anyNamed("noneTokenFDio")))
        .thenAnswer((realInvocation) async => basicFBallResDto);

    when(mockFBallRemoteDataSource.listUpFromInfluencePower(any, any, any))
        .thenAnswer((realInvocation) async => PageWrap.fromJson(
            json.decode(fixtureString(
                "FBall/Data/DataSource/ListUpFromBallInfluencePower.json")),
            FBallResDto.fromJson));

    sl.registerSingleton<FBallRemoteDataSource>(mockFBallRemoteDataSource);
  });

  test('select Ball Repository convert data', () async {
    //arrange
    FBallRepository fBallRepository = FBallRepositoryImpl(
        fireBaseAuthBaseAdapter: sl(), fBallRemoteDataSource: sl());
    //act
    FBallResDto fBallResDto = await fBallRepository.selectBall(ballUuid);

    //assert
    expect(fBallResDto.ballUuid, ballUuid);
    expect(fBallResDto.uid.uid, testUid);
  });

  test('listUpFromInfluencePower convert data', () async {
    //arrange
    FBallRepository fBallRepository = FBallRepositoryImpl(
        fireBaseAuthBaseAdapter: sl(), fBallRemoteDataSource: sl());
    //act
    FBallListUpFromBallInfluencePowerReqDto reqDto =
        FBallListUpFromBallInfluencePowerReqDto(
            latitude: 127.0, longitude: 37.0);
    PageWrap<FBallResDto> pageWrap = await fBallRepository.listUpFromInfluencePower(
        listUpReqDto: reqDto, pageable: Pageable(0, 20, null));
    //assert
    expect(pageWrap.numberOfElements, 3);
    expect(pageWrap.content.length, 3);

  });
}
