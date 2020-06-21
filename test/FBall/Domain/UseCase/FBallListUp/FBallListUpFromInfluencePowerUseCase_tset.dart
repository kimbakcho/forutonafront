
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockFBallRepository extends Mock implements FBallRepository{}
class MockFBallListUpFromInfluencePowerUseCaseOutputPort extends Mock implements FBallListUpFromInfluencePowerUseCaseOutputPort{}
class MockGeoLocationUtil extends Mock implements GeoLocationUtilUseCase{}

void main(){
  MockFBallRepository mockFBallRepository;
  FBallListUpFromInfluencePowerUseCaseInputPort fBallListUpFromInfluencePowerUseCaseInputPort;
  MockFBallListUpFromInfluencePowerUseCaseOutputPort mockFBallListUpFromInfluencePowerUseCaseOutputPort;

  setUp((){
    mockFBallRepository = MockFBallRepository();
    mockFBallListUpFromInfluencePowerUseCaseOutputPort = MockFBallListUpFromInfluencePowerUseCaseOutputPort();
    fBallListUpFromInfluencePowerUseCaseInputPort = FBallListUpFromInfluencePowerUseCase(fBallRepository: mockFBallRepository);
  });


  test('검색된 결과를 Output Port 로 전달 ',
          () async {
        //arrange
        when(mockFBallRepository.listUpFromInfluencePower(any))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act
        await fBallListUpFromInfluencePowerUseCaseInputPort.reqBallListUpFromInfluencePower( new Position(latitude: 127.0,longitude: 31.0), mockFBallListUpFromInfluencePowerUseCaseOutputPort);
        //assert
        verify(mockFBallRepository.listUpFromInfluencePower(any));
        verify(mockFBallListUpFromInfluencePowerUseCaseOutputPort.onListUpBallFromBallInfluencePower(any));

      });


  test('첫번째 페이지의 경우 Ball Clear 요청' ,
          () async {
        //arrange
        when(mockFBallRepository.listUpFromInfluencePower(any))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
        //act
        await fBallListUpFromInfluencePowerUseCaseInputPort.reqBallListUpFromInfluencePower( new Position(latitude: 127.0,longitude: 31.0), mockFBallListUpFromInfluencePowerUseCaseOutputPort);
        //assert
        verifyInOrder([
          verify(mockFBallListUpFromInfluencePowerUseCaseOutputPort.onBallClear()),
            verify(mockFBallRepository.listUpFromInfluencePower(any)),
          verify(mockFBallListUpFromInfluencePowerUseCaseOutputPort.onListUpBallFromBallInfluencePower(any))
        ]);
      });

  test('검색할 Ball 이 더 있는지 판단', () async {
    //arrange

    //act
      fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
      bool result1 = fBallListUpFromInfluencePowerUseCaseInputPort.hasMoreListUpBall(20);

      fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
      bool result2 = fBallListUpFromInfluencePowerUseCaseInputPort.hasMoreListUpBall(10);

      fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
      fBallListUpFromInfluencePowerUseCaseInputPort.nextPage();
      bool result3 = fBallListUpFromInfluencePowerUseCaseInputPort.hasMoreListUpBall(30);

      fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
      fBallListUpFromInfluencePowerUseCaseInputPort.nextPage();
      bool result4 = fBallListUpFromInfluencePowerUseCaseInputPort.hasMoreListUpBall(40);
    //assert
      expect(result1, true);
      expect(result2, false);
      expect(result3, false);
      expect(result4, true);

  });

  test('페이지 증가 확인 ', () async {
    //arrange
    when(mockFBallRepository.listUpFromInfluencePower(any))
        .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
    //act
    fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
    fBallListUpFromInfluencePowerUseCaseInputPort.nextPage();
    await fBallListUpFromInfluencePowerUseCaseInputPort.reqBallListUpFromInfluencePower( new Position(latitude: 127.0,longitude: 31.0), mockFBallListUpFromInfluencePowerUseCaseOutputPort);
    //assert
    verify(mockFBallListUpFromInfluencePowerUseCaseOutputPort.onListUpBallFromBallInfluencePower(any));
    FBallListUpFromBallInfluencePowerReqDto callParams = verify(mockFBallRepository.listUpFromInfluencePower(captureAny)).captured.single;
    expect(callParams.page, 1);
  });
}