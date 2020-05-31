import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Domain/Repository/IFBallRepository.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../fixtures/fixture_reader.dart';

class MockFBallRepository extends Mock implements IFBallRepository {}

void main() {
  MockFBallRepository mockFBallRepository;

  setUp(() {
    mockFBallRepository = MockFBallRepository();
  });

  final FBallListUpWrapDto fBallListUpWrapDto = FBallListUpWrapDto();
  final FBallListUpReqDto searchCondition = new FBallListUpReqDto(
      latitude: 37.43469925835876,
      longitude: 126.79077610373497,
      ballLimit: 1000,
      page: 0,
      size: 20,
      sort: "Influence,DESC"
  );

  test('should be call test', () async {
    //arrange
    FBallListUpWrapDto fBallListUpWrapDto2 = getResBallListUpPositionWrapDto();
    when(mockFBallRepository.listUpFromPosition(listUpReqDto: searchCondition))
        .thenAnswer((_) async => fBallListUpWrapDto2);
    //act
    final result = await mockFBallRepository.listUpFromPosition(
        listUpReqDto: searchCondition);
    //assert
    verify(mockFBallRepository.listUpFromPosition(
        listUpReqDto: searchCondition));
    expect(result, fBallListUpWrapDto2);
  });

  test('should be call reqBalls Type Match', () async {
    //arrange
    FBallListUpWrapDto fBallListUpWrapDto2 = getResBallListUpPositionWrapDto();
    when(mockFBallRepository.listUpFromPosition(
            listUpReqDto: searchCondition))
        .thenAnswer((realInvocation) async => fBallListUpWrapDto2);
    //act
    var result = await mockFBallRepository.listUpFromPosition(
        listUpReqDto: searchCondition);
    //assert
    expect(result.balls[0],TypeMatcher<FBallResDto>());
  });

  test('should be return FBall entity', () async {
    //arrange

    //act

    //assert
  });
}


FBallListUpWrapDto getResBallListUpPositionWrapDto() {
  var decode = json.decode(fixture(
      "FBall/Data/DataSource/BallListUpPositionWrapDto.json"));
  var fBallListUpWrapDto2 = FBallListUpWrapDto.fromJson(
      decode);
  return fBallListUpWrapDto2;
}
