import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockFDio extends Mock implements FDio{}
void main(){
  FBallRemoteDataSource fBallRemoteDataSource;
  MockFDio mockFDio;
  setUp((){
    fBallRemoteDataSource = FBallRemoteSourceImpl();
    mockFDio = MockFDio();
  });
  final FBallListUpReqDto searchCondition = new FBallListUpReqDto(
    latitude: 37.43469925835876,
    longitude: 126.79077610373497,
    ballLimit: 1000,
    page: 0,
    size: 20,
    sort: "Influence,DESC"
  );

  test('should MockDio test', () async {
    //arrange
    setWhenBallListUp(mockFDio);
    //act
    var response = await mockFDio.get("/v1/FBall/BallListUp");
    var listUpWrap = FBallListUpWrap.fromJson(response.data) ;
    //assert
    expect(listUpWrap, TypeMatcher<FBallListUpWrap>());
  });

  test('should search Position from ListUp Ball Type Change Test', () async {
    //arrange
    setWhenBallListUp(mockFDio);
    //act
       var fBallListUpWrapDto = await fBallRemoteDataSource
           .listUpFromPosition(fBallListUpReqDto: searchCondition,noneTokenFDio: mockFDio);
    //assert
      expect(fBallListUpWrapDto.balls.length > 0, isTrue);
      expect(fBallListUpWrapDto.balls[0], TypeMatcher<FBall>());
      expect(fBallListUpWrapDto.balls, isList);
  });

}

void setWhenBallListUp(MockFDio mockFDio) {
  when(mockFDio.get("/v1/FBall/BallListUp",queryParameters: anyNamed('queryParameters'))).thenAnswer((realInvocation) async => Response<dynamic>(
      statusCode: 200,
      data: json.decode(fixture('FBall/Data/DataSource/BallListUpPositionWrapDto.json')),
      headers:Headers.fromMap({
        "Content-Type":['application/json','charset=utf-8']
      })
  ));
}