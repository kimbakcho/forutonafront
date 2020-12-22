import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockFDio extends Mock implements FDio {}

void main() {
  MockFDio mockFDio;
  setUp(() {
    mockFDio = new MockFDio();
  });

  test('selectBall change Dto', () async {
    //arrange
    String ballUuid = "TestBallUuid";
    FBallRemoteDataSource fBallRemoteDataSource = FBallRemoteSourceImpl();

    when(mockFDio.get("/v1/FBall", queryParameters: {"ballUuid": ballUuid}))
        .thenAnswer((realInvocation) async => Response(
        data: json.decode(fixtureString("FBall/Data/DataSource/FBall.json"))
    ));
    //act
    FBallResDto fBallResDto = await fBallRemoteDataSource.selectBall(
        ballUuid: ballUuid, noneTokenFDio: mockFDio);
    //assert
    expect(fBallResDto, isNotNull);
  });

  test('ListUpBallListUpOrderByBI', () async {
    //arrange
    FBallRemoteDataSource fBallRemoteDataSource = FBallRemoteSourceImpl();

    when(mockFDio.get("/v1/FBall/ListUpBallListUpOrderByBI",queryParameters: anyNamed("queryParameters")))
        .thenAnswer((realInvocation) async => Response(
        data: json.decode(fixtureString("/FBall/Data/DataSource/ListUpBallListUpOrderByBI.json"))
    ));
    //act
    FBallListUpFromBIReqDto reqDto = FBallListUpFromBIReqDto();
    PageWrap<FBallResDto> pageWrap = await fBallRemoteDataSource.findByBallOrderByBI(reqDto,Pageable(page: 0,size: 20,sort: null),mockFDio);
    //assert
    expect(pageWrap.numberOfElements, 3);
    expect(pageWrap.content.length, 3);
  });
}
