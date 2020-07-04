import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Value/TagRanking.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'package:matcher/matcher.dart';
class MockFDio extends Mock implements FDio {}

void main() {
  MockFDio mockFDio;
  FBallTagRemoteDataSource fBallTagRemoteDataSource;

  setUp(() {
    mockFDio = MockFDio();
    fBallTagRemoteDataSource = FBallTagRemoteDataSourceImpl();
  });

  test('BackEnd 에서 정보 읽어온 정보 디코딩 ', () async {
    //arrange
    TagRankingFromBallInfluencePowerReqDto reqDto = TagRankingFromBallInfluencePowerReqDto(
        position: Position(latitude: 127.0, longitude: 30.0),
        limit: 10
    );
    when(mockFDio.get("/v1/FTag/RankingFromBallInfluencePower",
        queryParameters: reqDto.toJson())).thenAnswer((realInvocation) async =>
        Response<dynamic>(
            statusCode: 200,
            data: json.decode(fixtureString(
                'FTag/Data/DataSource/InfluenceTagRankingWrapDto.json')),
            headers: Headers.fromMap({
              "Content-Type": ['application/json', 'charset=utf-8']
            })
        )
    );
    //act
    var fTagRankingFromBallInfluencePower = await fBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(
        reqDto, mockFDio);
    //assert
    expect(fTagRankingFromBallInfluencePower.contents.length >0,true);
    expect(fTagRankingFromBallInfluencePower.contents[0],TypeMatcher<TagRanking>());
  });
}