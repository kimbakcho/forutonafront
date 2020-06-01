import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Data/DataStore/IFBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallrepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/IFBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../fixtures/fixture_reader.dart';

class MockIFBallRemoteDataSource extends Mock implements IFBallRemoteDataSource {}

void main() {

  MockIFBallRemoteDataSource mockIFBallRemoteDataSource;
  IFBallRepository ifBallRepository;
  setUp(() {
    mockIFBallRemoteDataSource = MockIFBallRemoteDataSource();
    ifBallRepository = FBallrepositoryImpl(ifBallRemoteDataSource: mockIFBallRemoteDataSource);
  });
  final FBallListUpReqDto searchCondition = new FBallListUpReqDto(
      latitude: 37.43469925835876,
      longitude: 126.79077610373497,
      ballLimit: 1000,
      page: 0,
      size: 20,
      sort: "Influence,DESC"
  );

  test('should be result type FBallListUpWrap', () async {
    //arrange
    setDateSourceListUpBall(mockIFBallRemoteDataSource);
    //act
    var reslut = await ifBallRepository.listUpFromPosition(listUpReqDto: searchCondition);
    //assert
    verify(mockIFBallRemoteDataSource.listUpFromPosition(fBallListUpReqDto: anyNamed('fBallListUpReqDto'), fDio: anyNamed('fDio')));
    expect(reslut,TypeMatcher<FBallListUpWrap>());
  });

  test('should be call reqBalls Type Match', () async {
    //arrange
    setDateSourceListUpBall(mockIFBallRemoteDataSource);
    //act
    var result = await ifBallRepository.listUpFromPosition(listUpReqDto: searchCondition);
    //assert
    expect(result.balls[0],TypeMatcher<FBall>());
  });

}

void setDateSourceListUpBall(MockIFBallRemoteDataSource mockIFBallRemoteDataSource) {
  when(mockIFBallRemoteDataSource
      .listUpFromPosition(fBallListUpReqDto: anyNamed('fBallListUpReqDto'), fDio: anyNamed('fDio')))
      .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
}