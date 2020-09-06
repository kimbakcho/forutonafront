import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001LikeAction.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:mockito/mockito.dart';

import '../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../TestUtil/FBallLike/FBallLikeTestUtil.dart';
import '../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../TestUtil/FballValuation/FBallValuationTestUtil.dart';
import '../ID001MainPage2ViewModel_test.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main (){
  ID001LikeActionViewModel id001likeActionViewModel;
  MockBuildContext context = MockBuildContext();
  ValuationMediator valuationMediator;

  setBallLikeTest(
      String testBallUUid, int ballLike, int ballDisLike, bool isLogin) {
    String testBallUuid = testBallUUid;
    MockFireBaseAuthBaseAdapter mockFireBaseAuthBaseAdapter =
    MockFireBaseAuthBaseAdapter();
    sl.registerSingleton<FireBaseAuthBaseAdapter>(mockFireBaseAuthBaseAdapter);
    when(mockFireBaseAuthBaseAdapter.isLogin())
        .thenAnswer((realInvocation) async => isLogin);

    MockFBallValuationRepository mockFBallValuationRepository =
    MockFBallValuationRepository();
    sl.registerSingleton<FBallValuationRepository>(
        mockFBallValuationRepository);

    FBallLikeResDto basicFBallLikeResDto =
    FBallLikeTestUtil.getBasicFBallLikeResDto(
        FBallValuationTestUtil.getBasicFBallValuationResDto(
            FBallTestUtil.getBasicFBallResDto(testBallUuid,
                FUserInfoSimpleTestUtil.getBasicUserResDto("BallMakerUid")),
            FUserInfoSimpleTestUtil.getBasicUserResDto("LikeUserUid")),
        ballLike: ballLike,
        ballDislike: ballDisLike,
        likeServiceUseUserCount: 1,
        ballPower: ballLike - ballDisLike);

    when(mockFBallValuationRepository.ballLike(any))
        .thenAnswer((realInvocation) async => basicFBallLikeResDto);

    sl.registerSingleton<BallLikeUseCaseInputPort>(
        BallLikeUseCase(fBallValuationRepository: sl()));

    sl.registerSingleton<FireBaseAuthAdapterForUseCase>(
        FireBaseAuthAdapterForUseCaseImpl(
            updateFCMTokenUseCaseInputPort: sl(),
            fireBaseMessageAdapter: sl(),
            signInUserInfoUseCaseInputPort: sl(),
            fireBaseAuthBaseAdapter: sl()));
  }

  initViewModel(String testBallUuid) {
    valuationMediator = ValuationMediatorImpl(ballLikeUseCaseInputPort: sl());
    id001likeActionViewModel = ID001LikeActionViewModel(
      context: context,
      ballUuid: testBallUuid,
      valuationMediator: valuationMediator,
      fireBaseAuthAdapterForUseCase: sl(),
    );
  }

  setUp((){
    di.init();
    sl.allowReassignment = true;
  });

  test('생성시 Mediator에 Component 등록', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 1, 0, true);
    //act
    initViewModel(testBallUuid);
    //assert
    expect(valuationMediator.componentCount(), 1);
  });

  test('like Action 로그인 상태에서  볼상태 Up 확인', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 1, 0, true);
    initViewModel(testBallUuid);
    //act
    await id001likeActionViewModel.likeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Up);
  });

  test('like Action 로그인 상태에서  볼상태 Down 확인', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 0, 1, true);
    initViewModel(testBallUuid);
    //act
    await id001likeActionViewModel.disLikeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Down);
  });

  test('like Action 로그인 상태에서  볼상태 Up 2번시 원상태로', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 1, 0, true);
    initViewModel(testBallUuid);
    //act
    await id001likeActionViewModel.likeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Up);

    //arrange
    setBallLikeTest(testBallUuid, 0, 0, true);
    //act
    await id001likeActionViewModel.likeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.None);
  });

  test('like Action 로그인 상태에서  볼상태 Down 2번시 원상태로', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 0, 1, true);
    initViewModel(testBallUuid);
    //act
    await id001likeActionViewModel.disLikeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Down);

    //arrange
    setBallLikeTest(testBallUuid, 0, 0, true);
    //act
    await id001likeActionViewModel.disLikeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.None);
  });

  test('like Action 로그인 상태에서  볼상태 Up -> Down', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 1, 0, true);
    initViewModel(testBallUuid);
    //act
    await id001likeActionViewModel.likeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Up);

    //arrange
    setBallLikeTest(testBallUuid, 0, 1, true);
    //act
    await id001likeActionViewModel.disLikeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Down);
  });

  test('like Action 로그인 상태에서  볼상태 Down -> Up', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 0, 1, true);
    initViewModel(testBallUuid);
    //act
    await id001likeActionViewModel.disLikeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Down);

    //arrange
    setBallLikeTest(testBallUuid, 1, 0, true);
    //act
    await id001likeActionViewModel.likeAction();
    //assert
    expect(valuationMediator.ballLikeState, BallLikeState.Up);
  });

  test('dispose시 valuationMediator Compoenent 등록 해제 확인', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    setBallLikeTest(testBallUuid, 1, 0, true);
    initViewModel(testBallUuid);
    //act
    id001likeActionViewModel.dispose();
    //assert
    expect(valuationMediator.componentCount(), 0);
  });
}