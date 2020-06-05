
import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockIFBallRepository extends Mock implements FBallRepository{}
class MockFBallListUpCaseOp extends Mock implements FBallListUpUseCaseOutputPort{}
class MockGeoLocationUtil extends Mock implements GeoLocationUtilUseCase{}
void main(){
  MockIFBallRepository mockIFBallRepository;
  FBallListUpUseCaseInputPort ballListUpUseCase;
  MockFBallListUpCaseOp mockFBallListUpCaseOp;
  MockGeoLocationUtil mockGeoLocationUtil;
  setUp((){
    mockIFBallRepository = MockIFBallRepository();
    mockFBallListUpCaseOp = MockFBallListUpCaseOp();
    mockGeoLocationUtil = MockGeoLocationUtil();
    ballListUpUseCase = FBallListUpUseCase(fBallListUpUseCaseOutputPort: mockFBallListUpCaseOp
        ,fBallRepository: mockIFBallRepository,geoLocationUtil: mockGeoLocationUtil);

  });
  final fBallListUpReqDto = FBallListUpReqDto(
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
        when(mockIFBallRepository.listUpFromPosition(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        var positionSearchListUpBall = await ballListUpUseCase.positionSearchListUpBall(searchReqDto: fBallListUpReqDto);
        //assert
        verify(mockFBallListUpCaseOp.onPositionSearchListUpBall(fBallResDtos: anyNamed('fBallResDtos'),address: anyNamed('address')));
        expect(positionSearchListUpBall, TypeMatcher<List<FBallResDto>>());
      });

  test('should be entity to dto list value same position',
          () async {
        //arrange
        when(mockIFBallRepository.listUpFromPosition(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        var positionSearchListUpBall = await ballListUpUseCase.positionSearchListUpBall(searchReqDto: fBallListUpReqDto);
        var repositoryListUpBall = await mockIFBallRepository.listUpFromPosition(listUpReqDto: fBallListUpReqDto);
        //assert
        expect(positionSearchListUpBall[0].latitude, repositoryListUpBall.balls[0].latitude);
        expect(positionSearchListUpBall[0].longitude, repositoryListUpBall.balls[0].longitude);
      });

  test('should be entity to dto list getCurrentPosition with SerachListUpBall from Position',
          () async {
        //arrange
        when(mockGeoLocationUtil.getCurrentWithLastPosition()).thenAnswer((_) async
        => Position(latitude: 55.5,longitude: 125.5));
        when(mockIFBallRepository.listUpFromPosition(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        var positionSearchListUpBall = await ballListUpUseCase.lastKnowPositionSearchListUpBall(searchReqDto: fBallListUpReqDto);
        var repositoryListUpBall = await mockIFBallRepository.listUpFromPosition(listUpReqDto: fBallListUpReqDto);
        //assert
        expect(positionSearchListUpBall[0].latitude, repositoryListUpBall.balls[0].latitude);
      });

  test('should be entity to dto list updateAddress flag false',
          () async {
        //arrange
        when(mockGeoLocationUtil.getCurrentWithLastPosition()).thenAnswer((_) async
        => Position(latitude: 55.5,longitude: 125.5));
        when(mockIFBallRepository.listUpFromPosition(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        final fBallListUpReqDtoFindAddressOption = FBallListUpReqDto(
            longitude: 124.5,
            latitude: 55.5,
            size: 10,
            ballLimit: 20,
            page: 1,
            sort: "WriteTime,Desc",
            findAddress: false
        );
        //act
        await ballListUpUseCase.positionSearchListUpBall(searchReqDto: fBallListUpReqDtoFindAddressOption);
        //assert
        verify(mockFBallListUpCaseOp.onPositionSearchListUpBall(fBallResDtos: anyNamed('fBallResDtos'), address: null));
      });

}