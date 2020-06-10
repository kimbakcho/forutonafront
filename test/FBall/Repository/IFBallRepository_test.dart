import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../fixtures/fixture_reader.dart';

class MockIFBallRemoteDataSource extends Mock implements FBallRemoteDataSource {}

void main() {

  MockIFBallRemoteDataSource mockIFBallRemoteDataSource;
  FBallRepository ifBallRepository;
  setUp(() {
    mockIFBallRemoteDataSource = MockIFBallRemoteDataSource();
    ifBallRepository = FBallRepositoryImpl(fBallRemoteDataSource: mockIFBallRemoteDataSource);
  });
  final FBallListUpFromBallInfluencePowerReqDto searchCondition = new FBallListUpFromBallInfluencePowerReqDto(
      latitude: 37.43469925835876,
      longitude: 126.79077610373497,
      ballLimit: 1000,
      page: 0,
      size: 20,
  );

  test('should be result type FBallListUpWrap', () async {
    //arrange
    setDateSourceListUpBall(mockIFBallRemoteDataSource);
    //act
    var reslut = await ifBallRepository.listUpFromInfluencePower(listUpReqDto: searchCondition);
    //assert
    verify(mockIFBallRemoteDataSource.listUpFromInfluencePower(fBallListUpFromInfluencePowerReqDto: anyNamed('fBallListUpReqDto'), noneTokenFDio : anyNamed('fDio')));
    expect(reslut,TypeMatcher<FBallListUpWrap>());
  });

  test('should be call reqBalls Type Match', () async {
    //arrange
    setDateSourceListUpBall(mockIFBallRemoteDataSource);
    //act
    var result = await ifBallRepository.listUpFromInfluencePower(listUpReqDto: searchCondition);
    //assert
    expect(result.balls[0],TypeMatcher<FBall>());
  });

}

void setDateSourceListUpBall(MockIFBallRemoteDataSource mockIFBallRemoteDataSource) {
  when(mockIFBallRemoteDataSource
      .listUpFromInfluencePower(fBallListUpFromInfluencePowerReqDto: anyNamed('fBallListUpReqDto'), noneTokenFDio: anyNamed('fDio')))
      .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
}