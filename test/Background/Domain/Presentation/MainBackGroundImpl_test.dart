import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Background/Presentation/MainBackGround.dart';
import 'package:mockito/mockito.dart';

class MockBackgroundUserPositionUseCaseInputPort extends Mock
    implements BackgroundUserPositionUseCaseInputPort {}

class MockBackgroundFetchAdapter extends Mock
    implements BackgroundFetchAdapter {}

void main() {
  BackgroundUserPositionUseCaseInputPort
      mockBackgroundUserPositionUseCaseInputPort;
  BackgroundFetchAdapter mockBackgroundFetchAdapter;
  MainBackGround mainBackGround;

  setUp(() {
    mockBackgroundUserPositionUseCaseInputPort =
        MockBackgroundUserPositionUseCaseInputPort();

    mockBackgroundFetchAdapter = MockBackgroundFetchAdapter();

    mainBackGround = MainBackGroundImpl(
        backgroundFetchAdapter: mockBackgroundFetchAdapter,
        backgroundUserPositionUseCaseInputPort:
            mockBackgroundUserPositionUseCaseInputPort);
  });

  test('should config with Loop 메소드 등록', () async {
    //arrange

    //act
    mainBackGround.startBackGroundService();
    //assert
    verify(mockBackgroundFetchAdapter.configWithLoopFuncRegister(any));
  });

  test('should UserPositionUseCaseInputPort Loop 실행', () async {
    //arrange
    when(mockBackgroundUserPositionUseCaseInputPort.getServiceTaskId)
        .thenReturn("com.wing.forutonafront.UserPositionService");
    //act
    mainBackGround.startBackGroundService();
    mainBackGround
        .backGroundServiceLoop("com.wing.forutonafront.UserPositionService");
    //assert
    verifyInOrder([
      verify(mockBackgroundFetchAdapter.configWithLoopFuncRegister(any)),
      verify(mockBackgroundUserPositionUseCaseInputPort.startServiceSchedule()),
      verify(mockBackgroundUserPositionUseCaseInputPort.loop()),
      verify(mockBackgroundFetchAdapter
          .backgroundFetchFinish('com.wing.forutonafront.UserPositionService'))
    ]);
  });




}
