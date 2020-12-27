import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/ListUpBallListUpOrderByBI.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';


import '../../../../../fixtures/fixture_reader.dart';
class MockFBallRepository extends Mock implements FBallRepository{}
void main() {
  test('FBallListUpFromInfluencePower search', () async {
    //arrange
    MockFBallRepository mockFBallRepository = MockFBallRepository();
    FBallListUpFromBIReqDto listUpReqDto = FBallListUpFromBIReqDto();

    PageWrap pageWrap = PageWrap<FBallResDto>.fromJson(json.decode(
        fixtureString("/FBall/Data/DataSource/ListUpBallListUpOrderByBI.json")),
        FBallResDto.fromJson);

    when(mockFBallRepository.findByBallOrderByBI(
        listUpReqDto: anyNamed("listUpReqDto"), pageable: anyNamed("pageable")))
        .thenAnswer((realInvocation) async => pageWrap);

    FBallListUpUseCaseInputPort listUpBallListUpOrderByBI = ListUpBallListUpOrderByBI(
      fBallRepository: mockFBallRepository,
      listUpReqDto: listUpReqDto,
    );

    //act
    PageWrap<FBallResDto> result = await listUpBallListUpOrderByBI.search(Pageable(page:0, size:20, sort:null));
    //assert
    expect(result, pageWrap);
  });
}