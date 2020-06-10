
import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockIFBallRepository extends Mock implements FBallRepository{}
class MockFBallListUpCaseOp extends Mock implements FBallListUpFromInfluencePowerUseCaseOutputPort{}
class MockGeoLocationUtil extends Mock implements GeoLocationUtilUseCase{}
void main(){
  MockIFBallRepository mockIFBallRepository;
  FBallListUpFromInfluencePowerUseCaseInputPort ballListUpUseCase;
  MockFBallListUpCaseOp mockFBallListUpCaseOp;
  MockGeoLocationUtil mockGeoLocationUtil;
  setUp((){
    mockIFBallRepository = MockIFBallRepository();
    mockFBallListUpCaseOp = MockFBallListUpCaseOp();
    mockGeoLocationUtil = MockGeoLocationUtil();
    ballListUpUseCase = FBallListUpFromInfluencePowerUseCase(fBallListUpUseCaseOutputPort: mockFBallListUpCaseOp
        ,fBallRepository: mockIFBallRepository);

  });
  final fBallListUpFromBallInfluencePowerReqDto = FBallListUpFromBallInfluencePowerReqDto(
      longitude: 124.5,
      latitude: 55.5,
      size: 10,
      ballLimit: 20,
      page: 1,
  );

  test('should be output port call',
          () async {
        //arrange
        when(mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act

        //assert
        verify(mockFBallListUpCaseOp.onListUpBallFromBallInfluencePower(fBallResDtos: anyNamed('fBallResDtos')));

      });

  test('should be entity to dto list value same position',
          () async {
        //arrange
        when(mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: anyNamed('listUpReqDto')))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act

        var repositoryListUpBall = await mockIFBallRepository.listUpFromInfluencePower(listUpReqDto: fBallListUpFromBallInfluencePowerReqDto);
        //assert

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
        );
        //act

        //assert
        verify(mockFBallListUpCaseOp.onListUpBallFromBallInfluencePower(fBallResDtos: anyNamed('fBallResDtos')));
      });

}