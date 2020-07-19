import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/MainModel.dart';
import 'package:mockito/mockito.dart';

class MockGlobalModel extends Mock implements GlobalModel {}

class MockFireBaseMessageController extends Mock
    implements FireBaseMessageController {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

class MockFlutterLocalNotificationsPluginAdapter extends Mock
    implements FlutterLocalNotificationsPluginAdapter {}

class MockUserPositionForegroundMonitoringUseCaseInputPort extends Mock
    implements UserPositionForegroundMonitoringUseCaseInputPort {}
class MockGeoLocationUtilBasicUseCaseInputPort extends Mock implements GeoLocationUtilBasicUseCaseInputPort{}

void main() {
  MockFireBaseMessageController mockFireBaseMessageController = MockFireBaseMessageController();
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
  MockFlutterLocalNotificationsPluginAdapter mockFlutterLocalNotificationsPluginAdapter = MockFlutterLocalNotificationsPluginAdapter();
  MockUserPositionForegroundMonitoringUseCaseInputPort mockUserPositionForegroundMonitoringUseCaseInputPort = MockUserPositionForegroundMonitoringUseCaseInputPort();
  MockGeoLocationUtilBasicUseCaseInputPort mockGeoLocationUtilBasicUseCaseInputPort  = MockGeoLocationUtilBasicUseCaseInputPort();
  MainModel mainModel;


  test('앱 시작에 필요한 서비스 호출 검증 ', () async {
    //arrange

    //act
    mainModel = MainModel(
        fireBaseMessageController: mockFireBaseMessageController,
        fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase,
        flutterLocalNotificationsPluginAdapter: mockFlutterLocalNotificationsPluginAdapter,
        userPositionForegroundMonitoringUseCaseInputPort:mockUserPositionForegroundMonitoringUseCaseInputPort,
        geoLocationUtilBasicUseCaseInputPort: mockGeoLocationUtilBasicUseCaseInputPort
    );
    //assert
    verify(mockFlutterLocalNotificationsPluginAdapter.init());
    verify(mockFireBaseMessageController.controllerStartService());
    verify(mockFireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen());
    verify(mockUserPositionForegroundMonitoringUseCaseInputPort.startUserPositionMonitoringAndUpdateToServer());
    verify(mockGeoLocationUtilBasicUseCaseInputPort.startStreamCurrentPosition());
  });
}