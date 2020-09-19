import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/ListUpBallListUpOrderByBI.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../../ICodePage/ID001/ID001MainPage2ViewModel_test.dart';
import '../../../../fixtures/fixture_reader.dart';

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