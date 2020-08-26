import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:mockito/mockito.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;

import '../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../TestUtil/FBallLike/FBallLikeTestUtil.dart';
import '../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../TestUtil/FballValuation/FBallValuationTestUtil.dart';
class MockValuationMediatorComponent extends Mock implements ValuationMediatorComponent{}
class MockFBallValuationRepository extends Mock implements FBallValuationRepository {}

void main () {
  ValuationMediator valuationMediator;
  setUp((){
    sl.allowReassignment = true;
    di.init();
  });

  test('Mediator Component 등록 테스트', () async {
    //arrange
    valuationMediator = ValuationMediatorImpl(
        ballLikeUseCaseInputPort: sl()
    );
    MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    //act
    expect(valuationMediator.componentCount(), 0);
    valuationMediator.registerComponent(mockValuationMediatorComponent);
    //assert
    expect(valuationMediator.componentCount(), 1);
  });

  test('Mediator Component 제거 테스트', () async {
    //arrange
    valuationMediator = ValuationMediatorImpl(
        ballLikeUseCaseInputPort: sl()
    );
    MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    //act
    valuationMediator.registerComponent(mockValuationMediatorComponent);
    expect(valuationMediator.componentCount(), 1);
    valuationMediator.unregisterComponent(mockValuationMediatorComponent);
    //assert
    expect(valuationMediator.componentCount(), 0);
  });

  test('get valuation with Logout', () async {
    //arrange
    MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();

    String testBallUuid ="testBallUuid";

    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));
    MockFBallValuationRepository mockFBallValuationRepository = MockFBallValuationRepository();

    sl.registerSingleton<FBallValuationRepository>(mockFBallValuationRepository);

    when(mockFBallValuationRepository.getBallLikeState(testBallUuid, null))
        .thenAnswer((realInvocation) async =>
        FBallLikeTestUtil.getBasicFBallLikeResDto(
            FBallValuationTestUtil.getLogOutUserFBallValuationResDto(
                basicFBallResDto)));

    sl.registerSingleton<BallLikeUseCaseInputPort>(BallLikeUseCase(fBallValuationRepository: sl()));

    valuationMediator = ValuationMediatorImpl(
        ballLikeUseCaseInputPort: sl()
    );
    //act
    valuationMediator.registerComponent(mockValuationMediatorComponent);
    await valuationMediator.getBallLikeState(testBallUuid);
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.None);

  });

  test('get valuation with login and DownState', () async {
    //arrange
    MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();

    String testBallUuid ="testBallUuid";

    String loginUid = "TestUid2";

    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));
    MockFBallValuationRepository mockFBallValuationRepository = MockFBallValuationRepository();

    sl.registerSingleton<FBallValuationRepository>(mockFBallValuationRepository);

    when(mockFBallValuationRepository.getBallLikeState(testBallUuid, loginUid))
        .thenAnswer((realInvocation) async =>
        FBallLikeTestUtil.getBasicFBallLikeResDto(
            FBallValuationTestUtil.getBasicFBallValuationResDto(
                basicFBallResDto, FUserInfoSimpleTestUtil.getBasicUserResDto(loginUid),
                ballLike: 0, ballDislike: 1, point: -1),
            ballLike: 10,
            ballDislike: 1,
            ballPower: 11,
            likeServiceUseUserCount: 4));

    sl.registerSingleton<BallLikeUseCaseInputPort>(BallLikeUseCase(fBallValuationRepository: sl()));

    valuationMediator = ValuationMediatorImpl(
        ballLikeUseCaseInputPort: sl()
    );
    //act
    valuationMediator.registerComponent(mockValuationMediatorComponent);
    await valuationMediator.getBallLikeState(testBallUuid,uid: loginUid);
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Down);
  });

  test('get valuation with login and UpState', () async {
    //arrange
    MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();

    String testBallUuid ="testBallUuid";

    String loginUid = "TestUid2";

    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));
    MockFBallValuationRepository mockFBallValuationRepository = MockFBallValuationRepository();

    sl.registerSingleton<FBallValuationRepository>(mockFBallValuationRepository);

    when(mockFBallValuationRepository.getBallLikeState(testBallUuid, loginUid))
        .thenAnswer((realInvocation) async =>
        FBallLikeTestUtil.getBasicFBallLikeResDto(
            FBallValuationTestUtil.getBasicFBallValuationResDto(
                basicFBallResDto, FUserInfoSimpleTestUtil.getBasicUserResDto(loginUid),
                ballLike: 1, ballDislike: 0, point: 1),
            ballLike: 10,
            ballDislike: 1,
            ballPower: 11,
            likeServiceUseUserCount: 4));

    sl.registerSingleton<BallLikeUseCaseInputPort>(BallLikeUseCase(fBallValuationRepository: sl()));

    valuationMediator = ValuationMediatorImpl(
        ballLikeUseCaseInputPort: sl()
    );

    //act
    valuationMediator.registerComponent(mockValuationMediatorComponent);
    await valuationMediator.getBallLikeState(testBallUuid,uid: loginUid);
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Up);
  });
}