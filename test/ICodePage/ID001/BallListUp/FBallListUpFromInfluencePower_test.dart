import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpFromInfluencePower.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort_test.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  test('Pass pageWrap', () async {
    //arrange
    MockFBallRepository mockFBallRepository = MockFBallRepository();
    FBallListUpFromBallInfluencePowerReqDto listUpReqDto = FBallListUpFromBallInfluencePowerReqDto();

    PageWrap pageWrap = PageWrap<FBallResDto>.fromJson(json.decode(
        fixtureString("/FBall/Data/DataSource/ListUpFromBallInfluencePower.json")),
        FBallResDto.fromJson);

    when(mockFBallRepository.listUpFromInfluencePower(
        listUpReqDto: anyNamed("listUpReqDto"), pageable: anyNamed("pageable")))
        .thenAnswer((realInvocation) async => pageWrap);

    FBallListUpUseCaseInputPort fBallListUpFromInfluencePower = FBallListUpFromInfluencePower(
      fBallRepository: mockFBallRepository,
      listUpReqDto: listUpReqDto,
    );

    //act
    PageWrap<FBallResDto> result = await fBallListUpFromInfluencePower.search(Pageable(0, 20, null));
    //assert
    expect(result, pageWrap);
  });
}