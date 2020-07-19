import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

class MockGeoLocationUtilBasicUseCaseInputPort extends Mock implements GeoLocationUtilBasicUseCaseInputPort{}
class MockStream<Position> extends Mock implements Stream<Position>{}
void main(){

  UserPositionForegroundMonitoringUseCaseInputPort userPositionForegroundMonitoringUseCaseInputPort;
  MockGeoLocationUtilBasicUseCaseInputPort mockGeoLocationUtilBasicUseCaseInputPort;
  MockStream<Position> mockUserPositionStream;
  setUp((){
    mockUserPositionStream = MockStream<Position>();
    mockGeoLocationUtilBasicUseCaseInputPort = MockGeoLocationUtilBasicUseCaseInputPort();
    userPositionForegroundMonitoringUseCaseInputPort = UserPositionForegroundMonitoringUseCase(
      geoLocationUtilBasicUseCaseInputPort:mockGeoLocationUtilBasicUseCaseInputPort
    );
  });

  test('Update Stream 추가하기', () async {
    //arrange
    when(mockGeoLocationUtilBasicUseCaseInputPort.getUserPositionStream()).thenAnswer((_)=>mockUserPositionStream);
    //act
    userPositionForegroundMonitoringUseCaseInputPort.startUserPositionMonitoringAndUpdateToServer();
    //assert
    verify(mockGeoLocationUtilBasicUseCaseInputPort.getUserPositionStream());
    verify(mockUserPositionStream.listen(any));
  });


}