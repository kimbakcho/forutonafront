import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockFBallListUpUseCaseInputPort extends Mock
    implements FBallListUpUseCaseInputPort {}

class MockBallListMediatorComponent extends Mock
    implements BallListMediatorComponent {}

void main() {
  BallListMediator ballListMediator;
  MockFBallListUpUseCaseInputPort mockFBallListUpUseCaseInputPort;
  setUp(() {
    mockFBallListUpUseCaseInputPort = MockFBallListUpUseCaseInputPort();
    ballListMediator = BallListMediatorImpl();
  });

  test('should search first', () async {
    //given
    PageWrap pageWrap = PageWrap<FBallResDto>.fromJson(
        json.decode(fixtureString(
            "/FBall/Data/DataSource/ListUpBallListUpOrderByBI.json")),
        FBallResDto.fromJson);

    when(mockFBallListUpUseCaseInputPort
            .search(Pageable(page: 0, size: 40, sort: "")))
        .thenAnswer((realInvocation) async => pageWrap);

    //when
    ballListMediator.fBallListUpUseCaseInputPort = mockFBallListUpUseCaseInputPort;
    await ballListMediator.searchFirst();
    //then
    expect(ballListMediator.ballList.length, 3);

    //when
    await ballListMediator.searchNext();
    //then
    expect(ballListMediator.ballList.length, 3);
  });

  test('should search continue', () async {
    //given
    PageWrap pageWrap = PageWrap<FBallResDto>.fromJson(
        json.decode(fixtureString(
            "/FBall/Data/DataSource/ListUpBallListUpOrderByBIFirst.json")),
        FBallResDto.fromJson);

    when(mockFBallListUpUseCaseInputPort
            .search(Pageable(page: 0, size: 40, sort: "")))
        .thenAnswer((realInvocation) async => pageWrap);

    PageWrap pageWrap1 = PageWrap<FBallResDto>.fromJson(
        json.decode(fixtureString(
            "/FBall/Data/DataSource/ListUpBallListUpOrderByBILast.json")),
        FBallResDto.fromJson);

    when(mockFBallListUpUseCaseInputPort
            .search(Pageable(page: 1, size: 40, sort: "")))
        .thenAnswer((realInvocation) async => pageWrap1);

    //when
    ballListMediator.fBallListUpUseCaseInputPort = mockFBallListUpUseCaseInputPort;
    await ballListMediator.searchFirst();
    //then
    expect(ballListMediator.ballList.length, 3);

    //when
    await ballListMediator.searchNext();
    //then
    expect(ballListMediator.ballList.length, 6);

    //when
    await ballListMediator.searchNext();
    //then
    expect(ballListMediator.ballList.length, 6);
  });

  test('should registerComponent', () async {
    //given
    MockBallListMediatorComponent mockBallListMediatorComponent = new MockBallListMediatorComponent();
    //when
    ballListMediator.registerComponent(mockBallListMediatorComponent);
    //then
    expect(ballListMediator.componentSize(), 1);
  });

  test('should unRegisterComponent', () async {
    //given
    MockBallListMediatorComponent mockBallListMediatorComponent = new MockBallListMediatorComponent();
    ballListMediator.registerComponent(mockBallListMediatorComponent);
    //when
    ballListMediator.unregisterComponent(mockBallListMediatorComponent);
    //then
    expect(ballListMediator.componentSize(), 0);
  });

  test('볼 숨기기', () async {
    //given
    MockBallListMediatorComponent mockBallListMediatorComponent = new MockBallListMediatorComponent();
    ballListMediator.registerComponent(mockBallListMediatorComponent);
    PageWrap pageWrap = PageWrap<FBallResDto>.fromJson(
        json.decode(fixtureString(
            "/FBall/Data/DataSource/ListUpBallListUpOrderByBIFirst.json")),
        FBallResDto.fromJson);

    ballListMediator.ballList  = pageWrap.content;
    //when
    ballListMediator.hideBall("TESTBALL1UUID");
    //then
    var indexWhere = ballListMediator.ballList.indexWhere((element) => element.ballUuid == "TESTBALL1UUID");
    expect(indexWhere, -1);
    verify(mockBallListMediatorComponent.onBallListUpUpdate());
  });
}
