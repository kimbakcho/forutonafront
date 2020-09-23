import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001LikeState.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockFireBaseAuthBaseAdapter extends Mock
    implements FireBaseAuthBaseAdapter {}

class MockFBallValuationRepository extends Mock
    implements FBallValuationRepository {}

class MockBallLikeUseCaseInputPort extends Mock
    implements BallLikeUseCaseInputPort {}

void main() {
  ID001LikeStateViewModel id001likeStateViewModel;
  ValuationMediator valuationMediator;
  MockBallLikeUseCaseInputPort mockBallLikeUseCaseInputPort = MockBallLikeUseCaseInputPort();
  setUp(() {});

  test('생성시 Mediator에 Component 등록', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    valuationMediator = ValuationMediatorImpl(ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort);
    id001likeStateViewModel = ID001LikeStateViewModel(
        valuationMediator: valuationMediator,
        ballUuid: testBallUuid,
        ballActivationTime: DateTime.now().add(Duration(days: 7)));
    //assert
    expect(valuationMediator.componentCount(), 1);
  });

  test('dispose시 Mediator에 uncomposition', () async {
    //arrange
    String testBallUuid = "TESTBallUUid";
    valuationMediator = ValuationMediatorImpl(ballLikeUseCaseInputPort: mockBallLikeUseCaseInputPort);
    id001likeStateViewModel = ID001LikeStateViewModel(
        valuationMediator: valuationMediator,
        ballUuid: testBallUuid,
        ballActivationTime: DateTime.now().add(Duration(days: 7)));
    //act
    id001likeStateViewModel.dispose();
    //assert
    expect(valuationMediator.componentCount(), 0);
  });
}
