import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewDeleteMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewUpdateMediator.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:mockito/mockito.dart';

import '../../TestUtil/FBall/FBallTestUtil.dart';
import '../../TestUtil/FBallLike/FBallLikeTestUtil.dart';
import '../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../TestUtil/FballValuation/FBallValuationTestUtil.dart';


class MockFireBaseAuthBaseAdapter extends Mock
    implements FireBaseAuthBaseAdapter {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

class MockSelectBallUseCaseInputPort extends Mock implements SelectBallUseCaseInputPort{}

class MockReviewCountMediator extends Mock implements ReviewCountMediator{}

class MockReviewDeleteMediator extends Mock implements ReviewDeleteMediator{}

class MockReviewInertMediator extends Mock implements ReviewInertMediator{}

class MockReviewUpdateMediator extends Mock implements ReviewUpdateMediator{}

class MockValuationMediator extends Mock implements ValuationMediator{}

class MockGeolocatorAdapter extends Mock implements GeolocatorAdapter{}
void main() {
  ID001MainPage2ViewModel id001mainPage2ViewModel;
  String testBallUuid;
  String loginUid;

  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockSelectBallUseCaseInputPort mockSelectBallUseCaseInputPort;
  MockReviewCountMediator mockReviewCountMediator;
  MockReviewDeleteMediator mockReviewDeleteMediator;
  MockReviewInertMediator mockReviewInertMediator;
  MockReviewUpdateMediator mockReviewUpdateMediator;
  MockValuationMediator mockValuationMediator;
  MockGeolocatorAdapter mockGeolocatorAdapter;
  setUpAll(() {});

  setUp(() {
    testBallUuid = "TESTBallUuid";
    loginUid = "TESTLoginUid";


    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();

    mockSelectBallUseCaseInputPort = MockSelectBallUseCaseInputPort();

    mockReviewCountMediator = MockReviewCountMediator();
    mockReviewDeleteMediator = MockReviewDeleteMediator();
    mockReviewInertMediator = MockReviewInertMediator();
    mockReviewUpdateMediator = MockReviewUpdateMediator();
    mockValuationMediator = MockValuationMediator();
    mockGeolocatorAdapter = MockGeolocatorAdapter();

    id001mainPage2ViewModel = new ID001MainPage2ViewModel(
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase,
        selectBallUseCaseInputPort: mockSelectBallUseCaseInputPort,
        reviewCountMediator: mockReviewCountMediator,
        reviewDeleteMediator: mockReviewDeleteMediator,
        reviewInertMediator: mockReviewInertMediator,
        reviewUpdateMediator: mockReviewUpdateMediator,
        valuationMediator: mockValuationMediator,
        detailPageController: ScrollController(),
        geolocatorAdapter: mockGeolocatorAdapter,
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

    verify(mockReviewInertMediator.registerComponent(any));
    verify(mockReviewDeleteMediator.registerComponent(any));
    verify(mockReviewUpdateMediator.registerComponent(any));
  });

  test('dispose 테스트', () async {
    //arrange

    //act
    id001mainPage2ViewModel.dispose();
    //assert

    verify(
        id001mainPage2ViewModel.reviewInertMediator.unregisterComponent(any));
    verify(
        id001mainPage2ViewModel.reviewDeleteMediator.unregisterComponent(any));
    verify(
        id001mainPage2ViewModel.reviewUpdateMediator.unregisterComponent(any));
  });

  test('logout init Will select ball and getValuation', () async {
    //arrange
    FBallResDto basicFBallResDto = logoutMockArrange(
        mockFireBaseAuthAdapterForUseCase,
        testBallUuid,
        mockSelectBallUseCaseInputPort);

    //act
    await id001mainPage2ViewModel.init();

    //assert
    expect(id001mainPage2ViewModel.getBallTitle(), basicFBallResDto.ballName);
    verify(mockValuationMediator.getBallLikeState(testBallUuid, uid: null));
  });
}
FBallResDto logoutMockArrange(
    MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase,
    String testBallUuid,
    MockSelectBallUseCaseInputPort mockSelectBallUseCaseInputPort) {
  when(mockFireBaseAuthAdapterForUseCase.isLogin())
      .thenAnswer((realInvocation) async => false);

  FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
      testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));

  when(mockSelectBallUseCaseInputPort.selectBall(testBallUuid))
      .thenAnswer((realInvocation) async => basicFBallResDto);
  return basicFBallResDto;
}
