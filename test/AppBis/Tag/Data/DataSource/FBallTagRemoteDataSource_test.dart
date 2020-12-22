import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockFDio extends Mock implements FDio {}
void main(){
  MockFDio mockFDio;
  setUp((){
    mockFDio = new MockFDio();
  });

  test('RankingFromBallInfluencePower 데이터 Response Test', () async {
    //arrange
    when(mockFDio.get("/v1/FTag/RankingFromBallInfluencePower",queryParameters: anyNamed("queryParameters")))
        .thenAnswer((realInvocation) async => Response(
        data: json.decode(fixtureString("FTag/Data/DataSource/InfluenceTagRankingWrapDto.json"))
    ));

    FBallTagRemoteDataSource fBallTagRemoteDataSource = FBallTagRemoteDataSourceImpl();
    TagRankingFromBallInfluencePowerReqDto reqDto =
        TagRankingFromBallInfluencePowerReqDto(
      mapCenterLatitude: 37.5012,
      mapCenterLongitude: 126.8976,
    );
    //act
    var fTagRankingFromBallInfluencePower = await fBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(reqDto, mockFDio);
    //assert
    expect(fTagRankingFromBallInfluencePower[0].tagName, equals("TESTTag1"));
    expect(fTagRankingFromBallInfluencePower[0].tagPower, equals(0.03));
  });
}