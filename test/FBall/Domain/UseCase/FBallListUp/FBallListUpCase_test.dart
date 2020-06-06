
import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromPosition/FBallListUpFromInfluencePowerUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromPosition/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromPosition/FBallListUpFromInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockIFBallRepository extends Mock implements FBallRepository{}
class MockFBallListUpCaseOp extends Mock implements FBallListUpFromPositionUseCaseOutputPort{}
class MockGeoLocationUtil extends Mock implements GeoLocationUtilUseCase{}
void main(){
  MockIFBallRepository mockIFBallRepository;
  FBallListUpFromPositionUseCaseInputPort ballListUpUseCase;
  MockFBallListUpCaseOp mockFBallListUpCaseOp;
  MockGeoLocationUtil mockGeoLocationUtil;
  setUp((){
    mockIFBallRepository = MockIFBallRepository();
    mockFBallListUpCaseOp = MockFBallListUpCaseOp();
    mockGeoLocationUtil = MockGeoLocationUtil();
    ballListUpUseCase = FBallListUpFromPositionUseCase(fBallListUpUseCaseOutputPort: mockFBallListUpCaseOp
        ,fBallRepository: mockIFBallRepository,geoLocationUtil: mockGeoLocationUtil);

  });
  final fBallListUpReqDto = FBallListUpFromBallInfluencePowerReqDto(
      longitude: 124.5,
      latitude: 55.5,
      size: 10,
      ballLimit: 20,
      page: 1,
      sort: "WriteTime,Desc"
  );

  test('should be output port call',
          () async {
        //arrange
        when(mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        var positionSearchListUpBall = await ballListUpUseCase.ballListUpFromPosition(searchReqDto: fBallListUpReqDto);
        //assert
        verify(mockFBallListUpCaseOp.onListUpBallFromPosition(fBallResDtos: anyNamed('fBallResDtos'),address: anyNamed('address')));
        expect(positionSearchListUpBall, TypeMatcher<List<FBallResDto>>());
      });

  test('should be entity to dto list value same position',
          () async {
        //arrange
        when(mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        var positionSearchListUpBall = await ballListUpUseCase.ballListUpFromPosition(searchReqDto: fBallListUpReqDto);
        var repositoryListUpBall = await mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: fBallListUpReqDto);
        //assert
        expect(positionSearchListUpBall[0].latitude, repositoryListUpBall.balls[0].latitude);
        expect(positionSearchListUpBall[0].longitude, repositoryListUpBall.balls[0].longitude);
      });

  test('should be entity to dto list getCurrentPosition with SerachListUpBall from Position',
          () async {
        //arrange
        when(mockGeoLocationUtil.getCurrentWithLastPosition()).thenAnswer((_) async
        => Position(latitude: 55.5,longitude: 125.5));
        when(mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        var positionSearchListUpBall = await ballListUpUseCase.ballListUpFromLastKnowPosition(searchReqDto: fBallListUpReqDto);
        var repositoryListUpBall = await mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: fBallListUpReqDto);
        //assert
        expect(positionSearchListUpBall[0].latitude, repositoryListUpBall.balls[0].latitude);
      });

  test('should be entity to dto list updateAddress flag false',
          () async {
        //arrange
        when(mockGeoLocationUtil.getCurrentWithLastPosition()).thenAnswer((_) async
        => Position(latitude: 55.5,longitude: 125.5));
        when(mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        final fBallListUpReqDtoFindAddressOption = FBallListUpFromBallInfluencePowerReqDto(
            longitude: 124.5,
            latitude: 55.5,
            size: 10,
            ballLimit: 20,
            page: 1,
            sort: "WriteTime,Desc",
            findAddress: false
        );
        //act
        await ballListUpUseCase.ballListUpFromPosition(searchReqDto: fBallListUpReqDtoFindAddressOption);
        //assert
        verify(mockFBallListUpCaseOp.onListUpBallFromPosition(fBallResDtos: anyNamed('fBallResDtos'), address: null));
      });

}