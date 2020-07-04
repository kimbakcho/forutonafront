import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockFDio extends Mock implements FDio {}

void main() {
  FBallRemoteDataSource fBallRemoteDataSource;
  MockFDio mockFDio;

  final FBallListUpFromBallInfluencePowerReqDto searchCondition =
      new FBallListUpFromBallInfluencePowerReqDto(
    latitude: 37.43469925835876,
    longitude: 126.79077610373497,
    ballLimit: 1000,
    page: 0,
    size: 20,
  );

  setUp(() {
    fBallRemoteDataSource = FBallRemoteSourceImpl();
    mockFDio = MockFDio();
  });

  test('Ball 영향력순 검색 API Call', () async {
    //arrange
    when(mockFDio.get("/v1/FBall/ListUpFromBallInfluencePower",
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(
            statusCode: 200,
            data: json.decode(fixtureString(
                'FBall/Data/DataSource/BallListUpPositionWrapDto.json')),
            headers: Headers.fromMap({
              "Content-Type": ['application/json', 'charset=utf-8']
            })));
    //act
    var fBallListUpWrapDto = await fBallRemoteDataSource
        .listUpFromInfluencePower(searchCondition, mockFDio);
    //assert
    expect(fBallListUpWrapDto.balls.length > 0, isTrue);
    expect(fBallListUpWrapDto.balls[0], TypeMatcher<FBall>());
    expect(fBallListUpWrapDto.balls, isList);
  });
}
