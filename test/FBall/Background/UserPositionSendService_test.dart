import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Background/MainBackGround.dart';
import 'package:forutonafront/Background/UserPositionSendService.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

class MockGeoLocationUtilUseCase extends Mock implements GeoLocationUtilUseCaseInputPort{}
void main(){

  setUp(body){

  }

  test('최근 위치값을 사용하는가?', () async {
    //arrange
    GeoLocationUtilUseCaseInputPort mockGeoLocationUtilUseCase = MockGeoLocationUtilUseCase();
    UserPositionSendService userPositionSendService =
        UserPositionSendServiceImpl(geoLocationUtilUseCaseInputPort: mockGeoLocationUtilUseCase);
    //act
    userPositionSendService.loop();
    //assert
    verify(mockGeoLocationUtilUseCase.getCurrentWithLastPosition());
  });


}