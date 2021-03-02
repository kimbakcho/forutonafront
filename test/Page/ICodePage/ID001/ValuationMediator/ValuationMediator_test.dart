import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/Page/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:mockito/mockito.dart';
import '../../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../../TestUtil/FBallLike/FBallLikeTestUtil.dart';
import '../../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../../TestUtil/FballValuation/FBallValuationTestUtil.dart';

class MockValuationMediatorComponent extends Mock implements ValuationMediatorComponent{}
class MockFBallValuationRepository extends Mock implements FBallValuationRepository {}
class MockBallLikeUseCaseInputPort extends Mock implements BallLikeUseCaseInputPort {}
void main () {
  ValuationMediator valuationMediator;
  MockBallLikeUseCaseInputPort mockBallLikeUseCaseInputPort;
  setUp((){
    mockBallLikeUseCaseInputPort = MockBallLikeUseCaseInputPort();
  });

  test('Mediator Component 등록 테스트', () async {
    // //arrange
    // valuationMediator = ValuationMediatorImpl(
    //     ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort
    // );
    // MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    // //act
    // expect(valuationMediator.componentCount(), 0);
    // valuationMediator.registerComponent(mockValuationMediatorComponent);
    // //assert
    // expect(valuationMediator.componentCount(), 1);
  });

  test('Mediator Component 제거 테스트', () async {
    // //arrange
    // valuationMediator = ValuationMediatorImpl(
    //     ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort
    // );
    // MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    // //act
    // valuationMediator.registerComponent(mockValuationMediatorComponent);
    // expect(valuationMediator.componentCount(), 1);
    // valuationMediator.unregisterComponent(mockValuationMediatorComponent);
    // //assert
    // expect(valuationMediator.componentCount(), 0);
  });

  test('get valuation with Logout', () async {
    // //arrange
    // MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    //
    // String testBallUuid ="testBallUuid";
    //
    // FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
    //     testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));
    //
    // when(mockBallLikeUseCaseInputPort.getBallLikeState(testBallUuid, null))
    //     .thenAnswer((realInvocation) async =>
    //     FBallLikeTestUtil.getBasicFBallLikeResDto(
    //         FBallValuationTestUtil.getLogOutUserFBallValuationResDto(
    //             basicFBallResDto)));
    //
    //
    // valuationMediator = ValuationMediatorImpl(
    //     ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort
    // );
    // //act
    // valuationMediator.registerComponent(mockValuationMediatorComponent);
    // await valuationMediator.getBallLikeState(testBallUuid);
    // //assert
    // expect(valuationMediator.ballLikeState, BallLikeState.None);

  });

  test('get valuation with login and DownState', () async {
    // //arrange
    // MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    //
    // String testBallUuid ="testBallUuid";
    //
    // String loginUid = "TestUid2";
    //
    // FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
    //     testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));
    //
    // when(mockBallLikeUseCaseInputPort.getBallLikeState(testBallUuid, loginUid))
    //     .thenAnswer((realInvocation) async =>
    //     FBallLikeTestUtil.getBasicFBallLikeResDto(
    //         FBallValuationTestUtil.getBasicFBallValuationResDto(
    //             basicFBallResDto, FUserInfoSimpleTestUtil.getBasicUserResDto(loginUid),
    //             ballLike: 0, ballDislike: 1, point: -1),
    //         ballLike: 10,
    //         ballDislike: 1,
    //         ballPower: 11,
    //         likeServiceUseUserCount: 4));
    //
    //
    // valuationMediator = ValuationMediatorImpl(
    //     ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort
    // );
    // //act
    // valuationMediator.registerComponent(mockValuationMediatorComponent);
    // await valuationMediator.getBallLikeState(testBallUuid,uid: loginUid);
    // //assert
    // expect(valuationMediator.ballLikeState, BallLikeState.Down);
  });

  test('get valuation with login and UpState', () async {
    //arrange
    // MockValuationMediatorComponent mockValuationMediatorComponent =  MockValuationMediatorComponent();
    //
    // String testBallUuid ="testBallUuid";
    //
    // String loginUid = "TestUid2";
    //
    // FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
    //     testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid1"));
    //
    //
    // when(mockBallLikeUseCaseInputPort.getBallLikeState(testBallUuid, loginUid))
    //     .thenAnswer((realInvocation) async =>
    //     FBallLikeTestUtil.getBasicFBallLikeResDto(
    //         FBallValuationTestUtil.getBasicFBallValuationResDto(
    //             basicFBallResDto, FUserInfoSimpleTestUtil.getBasicUserResDto(loginUid),
    //             ballLike: 1, ballDislike: 0, point: 1),
    //         ballLike: 10,
    //         ballDislike: 1,
    //         ballPower: 11,
    //         likeServiceUseUserCount: 4));
    //
    //
    // valuationMediator = ValuationMediatorImpl(
    //     ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort
    // );
    //
    // //act
    // valuationMediator.registerComponent(mockValuationMediatorComponent);
    // await valuationMediator.getBallLikeState(testBallUuid,uid: loginUid);
    // //assert
    // expect(valuationMediator.ballLikeState, BallLikeState.Up);
  });
}