import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/NoInterestedBallDecorator.dart';
import 'package:forutonafront/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockFBallListUpUseCaseInputPort extends Mock
    implements FBallListUpUseCaseInputPort {}

class MockFBallListUpUseCaseOutputPort extends Mock
    implements FBallListUpUseCaseOutputPort {}

class MockNoInterestBallUseCaseInputPort extends Mock
    implements NoInterestBallUseCaseInputPort {}

void main() {
  FBallListUpUseCaseInputPort noInterestedBallDecorator;
  MockFBallListUpUseCaseInputPort mockFBallListUpUseCaseInputPort;
  MockFBallListUpUseCaseOutputPort mockFBallListUpUseCaseOutputPort;
  MockNoInterestBallUseCaseInputPort mockNoInterestBallUseCaseInputPort;

  setUp(() {
    mockFBallListUpUseCaseInputPort = MockFBallListUpUseCaseInputPort();
    mockFBallListUpUseCaseOutputPort = MockFBallListUpUseCaseOutputPort();
    mockNoInterestBallUseCaseInputPort = MockNoInterestBallUseCaseInputPort();

    noInterestedBallDecorator = NoInterestedBallDecorator(
        fBallListUpUseCaseInputPort: mockFBallListUpUseCaseInputPort,
        noInterestBallUseCaseInputPort: mockNoInterestBallUseCaseInputPort);
  });

  test('검색한 볼에서 관심 없는 볼 제외', () async {
    //given
    PageWrap originPageWrap = PageWrap<FBallResDto>.fromJson(
        json.decode(fixtureString(
            "/FBall/Data/DataSource/ListUpBallListUpOrderByBI.json")),
        FBallResDto.fromJson);

    when(mockFBallListUpUseCaseInputPort.search(any,
            outputPort: anyNamed('outputPort')))
        .thenAnswer((realInvocation) async => originPageWrap);

    when(mockNoInterestBallUseCaseInputPort.findByAll())
        .thenAnswer((realInvocation) async => ["TESTBall2NAME"]);

    //when
    var result = await noInterestedBallDecorator.search(
        Pageable(page: 0, size: 10),
        outputPort: mockFBallListUpUseCaseOutputPort);

    //then

    var indexWhere = result.content.indexWhere((element) => element.ballUuid == "TESTBall2NAME");
    expect(indexWhere, -1);

    verify(mockFBallListUpUseCaseOutputPort.searchResult(any));

  });

}
