import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H001/TopH001NavExpendAniContent.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:mockito/mockito.dart';

class MockGeoLocationUtilForeGroundUseCaseInputPort extends Mock
    implements GeoLocationUtilForeGroundUseCaseInputPort {}

class MockLocationAdapter extends Mock implements LocationAdapter {}

class MockFluttertoastAdapter extends Mock implements FluttertoastAdapter {}
class MockH001Listener extends Mock implements H001Listener{}
void main() {
  TopH001NavExpendAniContentViewModel topH001NavExpendAniContentViewModel;
  MockGeoLocationUtilForeGroundUseCaseInputPort
      mockGeoLocationUtilForeGroundUseCaseInputPort;
  MockLocationAdapter mockLocationAdapter;
  MockFluttertoastAdapter mockFluttertoastAdapter;
  setUp(() {
    di.init();
    sl.allowReassignment = true;

    mockLocationAdapter = MockLocationAdapter();
    sl.registerSingleton<LocationAdapter>(mockLocationAdapter);

    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => true);

    mockFluttertoastAdapter = MockFluttertoastAdapter();
    sl.registerSingleton<FluttertoastAdapter>(mockFluttertoastAdapter);

    mockGeoLocationUtilForeGroundUseCaseInputPort =
        new MockGeoLocationUtilForeGroundUseCaseInputPort();
    sl.registerSingleton<GeoLocationUtilForeGroundUseCaseInputPort>(
        mockGeoLocationUtilForeGroundUseCaseInputPort);

    when(mockGeoLocationUtilForeGroundUseCaseInputPort.useGpsReq()).thenAnswer((realInvocation) async => true);

    topH001NavExpendAniContentViewModel = TopH001NavExpendAniContentViewModel(
        geoLocationUtilForeGroundUseCaseInputPort: sl(),
        locationAdapter: sl(),
        fluttertoastAdapter: sl());
  });

  test('초기화 시에 주소 초기화 하기', () async {
    //arrange

    when(mockGeoLocationUtilForeGroundUseCaseInputPort
            .getCurrentWithLastPosition())
        .thenAnswer((realInvocation) async =>
            Position(latitude: 127.0, longitude: 37.1));

    when(mockGeoLocationUtilForeGroundUseCaseInputPort.getPositionAddress(any))
        .thenAnswer((realInvocation) async => "경기도 신도림역 44-2");
    //act
    await topH001NavExpendAniContentViewModel.init();
    //assert
    verify(mockFluttertoastAdapter.showToast(msg: "위치를 확인 중입니다."));
    expect(topH001NavExpendAniContentViewModel.searchAddress,
        equals("경기도 신도림역 44-2"));
  });

  test('초기화 시에 주소 못 찼을때.', () async {
    //arrange
    when(mockGeoLocationUtilForeGroundUseCaseInputPort
            .getCurrentWithLastPosition())
        .thenAnswer((realInvocation) async =>
            Position(latitude: 127.0, longitude: 37.1));

    when(mockGeoLocationUtilForeGroundUseCaseInputPort.getPositionAddress(any))
        .thenThrow(FlutterError("주소를 찾을수가 없습니다"));
    //act
    await topH001NavExpendAniContentViewModel.init();
    //assert
    verify(mockFluttertoastAdapter.showToast(msg: "주소를 찾을수가 없습니다"));
    expect(topH001NavExpendAniContentViewModel.searchAddress,
        equals("주소를 찾을수가 없습니다"));
  });

  test('위치 정보를 사용하지 못할때.', () async {
    //arrange
    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => false);
    //act
    await topH001NavExpendAniContentViewModel.init();
    //assert
    expect(topH001NavExpendAniContentViewModel.searchAddress,
        equals("위치정보를 사용수가 없습니다."));
    verify(mockFluttertoastAdapter.showToast(msg: "위치정보를 사용수가 없습니다."));
  });

  test('Position Load 시에 H001에 찾기 명령 내리기',() async {
    //arrange
    H001Manager h001manager = sl();
    MockH001Listener mockH001Listener = MockH001Listener();
    h001manager.subscribe(mockH001Listener);
    Position position = Position(latitude: 37.1,longitude: 127.1);
    //act
    await topH001NavExpendAniContentViewModel.loadPosition(position);
    //assert
    verify(mockH001Listener.search(position));

  });

}
