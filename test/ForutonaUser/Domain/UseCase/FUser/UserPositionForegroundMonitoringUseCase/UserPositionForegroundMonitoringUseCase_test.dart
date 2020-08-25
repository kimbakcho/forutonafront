import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';

class MockGeoLocationUtilBasicUseCaseInputPort extends Mock
    implements GeoLocationUtilBasicUseCaseInputPort {}

class MockStream<Position> extends Mock implements Stream<Position> {}

class MockFireBaseAuthAdapterForUseCase extends Mock
    implements FireBaseAuthAdapterForUseCase {}

class MockFUserRepository extends Mock implements FUserRepository {}

class MockUpdateUserPositionUseCaseInputPort extends Mock
    implements UpdateUserPositionUseCaseInputPort {}

void main() {
  UserPositionForegroundMonitoringUseCaseInputPort userPositionForegroundMonitoringUseCaseInputPort;
  MockGeoLocationUtilBasicUseCaseInputPort mockGeoLocationUtilBasicUseCaseInputPort;
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase;
  MockStream<Position> mockUserPositionStream;
  MockFUserRepository mockFUserRepository;
  MockUpdateUserPositionUseCaseInputPort mockUpdateUserPositionUseCaseInputPort;
  setUp(() {
    mockUserPositionStream = MockStream<Position>();
    mockGeoLocationUtilBasicUseCaseInputPort =
        MockGeoLocationUtilBasicUseCaseInputPort();
    mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
    mockFUserRepository = MockFUserRepository();
    mockUpdateUserPositionUseCaseInputPort =
        MockUpdateUserPositionUseCaseInputPort();
    userPositionForegroundMonitoringUseCaseInputPort =
        UserPositionForegroundMonitoringUseCase(
            geoLocationUtilBasicUseCaseInputPort: mockGeoLocationUtilBasicUseCaseInputPort,
            fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase,
            fUserRepository: mockFUserRepository,
            updateUserPositionUseCaseInputPort: mockUpdateUserPositionUseCaseInputPort
        );
  });

  test('Update Stream 추가하기', () async {
    //arrange
    when(mockGeoLocationUtilBasicUseCaseInputPort.getUserPositionStream())
        .thenAnswer((_) => mockUserPositionStream);
    //act
    userPositionForegroundMonitoringUseCaseInputPort
        .startUserPositionMonitoringAndUpdateToServer();
    //assert
    verify(mockGeoLocationUtilBasicUseCaseInputPort.getUserPositionStream());
    verify(mockUserPositionStream.listen(any));
  });
}