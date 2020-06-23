import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageAdapter.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

class MockFireBaseMessageAdapter extends Mock
    implements FireBaseMessageAdapter {}

class MockBaseMessageUseCaseInputPort extends Mock
    implements BaseMessageUseCaseInputPort {}

void main() {
  FireBaseMessageController fireBaseMessageController;
  MockFireBaseMessageAdapter mockFireBaseMessageAdapter;
  MockBaseMessageUseCaseInputPort launchMessageUseCase;
  MockBaseMessageUseCaseInputPort baseMessageUseCase;
  MockBaseMessageUseCaseInputPort resumeMessageUseCase;
  setUp(() {
    mockFireBaseMessageAdapter = MockFireBaseMessageAdapter();
    launchMessageUseCase = MockBaseMessageUseCaseInputPort();
    baseMessageUseCase = MockBaseMessageUseCaseInputPort();
    resumeMessageUseCase = MockBaseMessageUseCaseInputPort();
  });

  test('설정 초기화 호출', () async {
    //arrange
    fireBaseMessageController = new FireBaseMessageController(
        fireBaseMessageAdapter: mockFireBaseMessageAdapter,
        launchMessageUseCase: launchMessageUseCase,
        baseMessageUseCase: baseMessageUseCase,
        resumeMessageUseCase: resumeMessageUseCase);
    //act
    fireBaseMessageController.controllerStartService();
    //assert
    verify(mockFireBaseMessageAdapter.configure(
        onMessage: anyNamed("onMessage"),
        onLaunch: anyNamed("onLaunch"),
        onResume: anyNamed("onResume")));
    verify(mockFireBaseMessageAdapter.setRefreshTokenUseCase(any));

  });
}