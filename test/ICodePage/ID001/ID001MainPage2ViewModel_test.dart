import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:mockito/mockito.dart';

import '../../TestUtil/FBall/FBallTestUtil.dart';
import '../../TestUtil/FBallLike/FBallLikeTestUtil.dart';
import '../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../TestUtil/FballValuation/FBallValuationTestUtil.dart';

class MockFBallRepository extends Mock implements FBallRepository {}

class MockFireBaseAuthBaseAdapter extends Mock
    implements FireBaseAuthBaseAdapter {}

class MockFBallValuationRepository extends Mock
    implements FBallValuationRepository {}

void main() {
  ID001MainPage2ViewModel id001mainPage2ViewModel;
  String testBallUuid;
  String loginUid;
  MockFBallRepository mockFBallRepository;
  MockFireBaseAuthBaseAdapter mockFireBaseAuthBaseAdapter;
  MockFBallValuationRepository mockFBallValuationRepository;
  setUpAll(() {
    sl.allowReassignment = true;

    di.init();
  });

  setUp(() {
    testBallUuid = "TESTBallUuid";
    loginUid = "TESTLoginUid";
    mockFBallRepository = MockFBallRepository();

    sl.registerSingleton<FBallRepository>(mockFBallRepository);

    sl.registerSingleton<SelectBallUseCaseInputPort>(
        SelectBallUseCase(fBallRepository: sl()));

    mockFireBaseAuthBaseAdapter = MockFireBaseAuthBaseAdapter();

    sl.registerSingleton<FireBaseAuthBaseAdapter>(mockFireBaseAuthBaseAdapter);

    sl.registerSingleton<FireBaseAuthAdapterForUseCase>(
        FireBaseAuthAdapterForUseCaseImpl(
            fireBaseAuthBaseAdapter: sl(),
            signInUserInfoUseCaseInputPort: sl(),
            fireBaseMessageAdapter: sl(),
            updateFCMTokenUseCaseInputPort: sl()));

    mockFBallValuationRepository = MockFBallValuationRepository();

    sl.registerSingleton<FBallValuationRepository>(
        mockFBallValuationRepository);

    sl.registerSingleton<BallLikeUseCaseInputPort>(
        BallLikeUseCase(fBallValuationRepository: sl()));

    id001mainPage2ViewModel = new ID001MainPage2ViewModel(
        fireBaseAuthAdapterForUseCase: sl(),
        selectBallUseCaseInputPort: sl(),
        ballUuid: testBallUuid);
  });

  test('생성자  Madiator init 테스트', () async {
    //arrange

    //act

    //assert
    expect(id001mainPage2ViewModel.reviewInertMediator, isNotNull);
    expect(id001mainPage2ViewModel.reviewCountMediator, isNotNull);
    expect(id001mainPage2ViewModel.valuationMediator, isNotNull);
    expect(id001mainPage2ViewModel.reviewDeleteMediator, isNotNull);
    expect(id001mainPage2ViewModel.reviewUpdateMediator, isNotNull);

    expect(id001mainPage2ViewModel.reviewInertMediator.componentCount(), 1);
    expect(id001mainPage2ViewModel.reviewDeleteMediator.componentCount(), 1);
    expect(id001mainPage2ViewModel.reviewUpdateMediator.componentCount(), 1);
  });

  test('dispose 테스트', () async {
    //arrange

    //act
    id001mainPage2ViewModel.dispose();
    //assert

    expect(id001mainPage2ViewModel.reviewInertMediator.componentCount(), 0);
    expect(id001mainPage2ViewModel.reviewDeleteMediator.componentCount(), 0);
    expect(id001mainPage2ViewModel.reviewUpdateMediator.componentCount(), 0);
  });

  test('logout init Will select ball and getValuation', () async {
    //arrange
    FBallResDto basicFBallResDto = logoutMockArrange(mockFireBaseAuthBaseAdapter,
        testBallUuid, mockFBallValuationRepository, mockFBallRepository);

    //act
    await id001mainPage2ViewModel.init();

    //assert
    expect(id001mainPage2ViewModel.getBallTitle(), basicFBallResDto.ballName);
    expect(id001mainPage2ViewModel.valuationMediator.ballLikeState,
        BallLikeState.None);
    expect(id001mainPage2ViewModel.valuationMediator.ballPower, 11);
    expect(id001mainPage2ViewModel.valuationMediator.ballDisLikeCount, 1);
    expect(id001mainPage2ViewModel.valuationMediator.ballLikeCount, 10);
    expect(
        id001mainPage2ViewModel.valuationMediator.likeServiceUseUserCount, 4);
  });

  test('login init Will select ball and getValuation is UpState', () async {
    //arrange
    when(mockFireBaseAuthBaseAdapter.isLogin())
        .thenAnswer((realInvocation) async => true);

    when(mockFireBaseAuthBaseAdapter.userUid())
        .thenAnswer((realInvocation) async => loginUid);

    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));

    FUserInfoSimpleResDto loginUserUid =
    FUserInfoSimpleTestUtil.getBasicUserResDto(loginUid);

    when(mockFBallValuationRepository.getBallLikeState(testBallUuid, loginUid))
        .thenAnswer((realInvocation) async =>
        FBallLikeTestUtil.getBasicFBallLikeResDto(
            FBallValuationTestUtil.getBasicFBallValuationResDto(
                basicFBallResDto, loginUserUid,
                ballLike: 1, ballDislike: 0, point: 1),
            ballLike: 10,
            ballDislike: 1,
            ballPower: 11,
            likeServiceUseUserCount: 4));

    when(mockFBallRepository.selectBall(testBallUuid))
        .thenAnswer((realInvocation) async => basicFBallResDto);

    //act
    await id001mainPage2ViewModel.init();

    //assert
    expect(id001mainPage2ViewModel.getBallTitle(), basicFBallResDto.ballName);
    expect(id001mainPage2ViewModel.valuationMediator.ballLikeState,
        BallLikeState.Up);
    expect(id001mainPage2ViewModel.valuationMediator.ballPower, 11);
    expect(id001mainPage2ViewModel.valuationMediator.ballDisLikeCount, 1);
    expect(id001mainPage2ViewModel.valuationMediator.ballLikeCount, 10);
    expect(
        id001mainPage2ViewModel.valuationMediator.likeServiceUseUserCount, 4);
  });

  test('login init Will select ball and getValuation is DownState', () async {
    //arrange
    when(mockFireBaseAuthBaseAdapter.isLogin())
        .thenAnswer((realInvocation) async => true);

    when(mockFireBaseAuthBaseAdapter.userUid())
        .thenAnswer((realInvocation) async => loginUid);

    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));

    FUserInfoSimpleResDto loginUserUid =
        FUserInfoSimpleTestUtil.getBasicUserResDto(loginUid);

    when(mockFBallValuationRepository.getBallLikeState(testBallUuid, loginUid))
        .thenAnswer((realInvocation) async =>
            FBallLikeTestUtil.getBasicFBallLikeResDto(
                FBallValuationTestUtil.getBasicFBallValuationResDto(
                    basicFBallResDto, loginUserUid,
                    ballLike: 0, ballDislike: 1, point: -1),
                ballLike: 10,
                ballDislike: 1,
                ballPower: 11,
                likeServiceUseUserCount: 4));

    when(mockFBallRepository.selectBall(testBallUuid))
        .thenAnswer((realInvocation) async => basicFBallResDto);

    //act
    await id001mainPage2ViewModel.init();

    //assert
    expect(id001mainPage2ViewModel.getBallTitle(), basicFBallResDto.ballName);
    expect(id001mainPage2ViewModel.valuationMediator.ballLikeState,
        BallLikeState.Down);
    expect(id001mainPage2ViewModel.valuationMediator.ballPower, 11);
    expect(id001mainPage2ViewModel.valuationMediator.ballDisLikeCount, 1);
    expect(id001mainPage2ViewModel.valuationMediator.ballLikeCount, 10);
    expect(
        id001mainPage2ViewModel.valuationMediator.likeServiceUseUserCount, 4);
  });


}

FBallResDto logoutMockArrange(
    MockFireBaseAuthBaseAdapter mockFireBaseAuthBaseAdapter,
    String testBallUuid,
    MockFBallValuationRepository mockFBallValuationRepository,
    MockFBallRepository mockFBallRepository) {
  when(mockFireBaseAuthBaseAdapter.isLogin())
      .thenAnswer((realInvocation) async => false);

  FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
      testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));

  when(mockFBallValuationRepository.getBallLikeState(testBallUuid, null))
      .thenAnswer((realInvocation) async =>
          FBallLikeTestUtil.getBasicFBallLikeResDto(
              FBallValuationTestUtil.getLogOutUserFBallValuationResDto(
                  basicFBallResDto),
              ballLike: 10,
              ballDislike: 1,
              ballPower: 11,
              likeServiceUseUserCount: 4));

  when(mockFBallRepository.selectBall(testBallUuid))
      .thenAnswer((realInvocation) async => basicFBallResDto);
  return basicFBallResDto;
}
