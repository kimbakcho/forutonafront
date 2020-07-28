
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockFBallRepository extends Mock implements FBallRepository{}
class MockFBallListUpFromInfluencePowerUseCaseOutputPort extends Mock implements FBallListUpFromInfluencePowerUseCaseOutputPort{}
class MockGeoLocationUtil extends Mock implements GeoLocationUtilBasicUseCase{}

void main(){
  MockFBallRepository mockFBallRepository;
  FBallListUpFromInfluencePowerUseCaseInputPort fBallListUpFromInfluencePowerUseCaseInputPort;
  MockFBallListUpFromInfluencePowerUseCaseOutputPort mockFBallListUpFromInfluencePowerUseCaseOutputPort;

  setUp((){
    mockFBallRepository = MockFBallRepository();
    mockFBallListUpFromInfluencePowerUseCaseOutputPort = MockFBallListUpFromInfluencePowerUseCaseOutputPort();
    fBallListUpFromInfluencePowerUseCaseInputPort = FBallListUpFromInfluencePowerUseCase(fBallRepository: mockFBallRepository);
  });


  test('검색된 결과를 Output Port 로 전달 Repository 실행',
          () async {
        //arrange
        when(mockFBallRepository.listUpFromInfluencePower(any))
            .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(fixtureString('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
        //act

        var reqDto = new FBallListUpFromBallInfluencePowerReqDto(
            latitude: 127.0,
            longitude: 31.0,
            ballLimit: 1000,
            page: 0,
            size: 20);

        await fBallListUpFromInfluencePowerUseCaseInputPort.reqBallListUpFromInfluencePower( reqDto, mockFBallListUpFromInfluencePowerUseCaseOutputPort);
        //assert
        verify(mockFBallRepository.listUpFromInfluencePower(any));
        verify(mockFBallListUpFromInfluencePowerUseCaseOutputPort.onListUpBallFromBallInfluencePower(any));

      });

}