import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

import '../../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../../fixtures/fixture_reader.dart';


class MockFBallRemoteDataSource extends Mock implements FBallRemoteDataSource {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

void main() {
  String ballUuid = "TESTBallUuid";
  String testUid = "TESTUid";
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockFBallRemoteDataSource mockFBallRemoteDataSource;
  setUp(() {
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    mockFBallRemoteDataSource = MockFBallRemoteDataSource();
    var basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        ballUuid, FUserInfoSimpleTestUtil.getBasicUserResDto(testUid));

    when(mockFBallRemoteDataSource.selectBall(
            ballUuid: ballUuid, noneTokenFDio: anyNamed("noneTokenFDio")))
        .thenAnswer((realInvocation) async => basicFBallResDto);

    when(mockFBallRemoteDataSource.findByBallOrderByBI(any, any, any))
        .thenAnswer((realInvocation) async => PageWrap.fromJson(
            json.decode(fixtureString(
                "FBall/Data/DataSource/ListUpBallListUpOrderByBI.json")),
            FBallResDto.fromJson));
  });

  test('select Ball Repository convert data', () async {
    //arrange
    FBallRepository fBallRepository = FBallRepositoryImpl(
        fireBaseAuthBaseAdapter: mockFireBaseAuthAdapterForUseCase,
        fBallRemoteDataSource: mockFBallRemoteDataSource);

    //act
    FBallResDto fBallResDto = await fBallRepository.selectBall(ballUuid);

    //assert
    expect(fBallResDto.ballUuid, ballUuid);
    expect(fBallResDto.uid.uid, testUid);
  });

  test('listUpFromInfluencePower convert data', () async {
    //arrange
    FBallRepository fBallRepository = FBallRepositoryImpl(
        fireBaseAuthBaseAdapter: mockFireBaseAuthAdapterForUseCase,
        fBallRemoteDataSource: mockFBallRemoteDataSource);
    //act
    FBallListUpFromBIReqDto reqDto = FBallListUpFromBIReqDto();
    PageWrap<FBallResDto> pageWrap = await fBallRepository.findByBallOrderByBI(
        listUpReqDto: reqDto,
        pageable: Pageable(page: 0, size: 20, sort: null));
    //assert
    expect(pageWrap.numberOfElements, 3);
    expect(pageWrap.content.length, 3);
  });
}
