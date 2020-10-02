import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendAniContent.dart';


import 'package:mockito/mockito.dart';

class MockGeoLocationUtilForeGroundUseCaseInputPort extends Mock
    implements GeoLocationUtilForeGroundUseCaseInputPort {}

class MockLocationAdapter extends Mock implements LocationAdapter {}

class MockFluttertoastAdapter extends Mock implements FluttertoastAdapter {}
class MockH001Listener extends Mock implements GeoViewSearchListener{}
void main() {
  TopH_I_001NavExpendAniContentViewModel topH001NavExpendAniContentViewModel;
  MockGeoLocationUtilForeGroundUseCaseInputPort
      mockGeoLocationUtilForeGroundUseCaseInputPort;
  MockLocationAdapter mockLocationAdapter;
  MockFluttertoastAdapter mockFluttertoastAdapter;
  GeoViewSearchManagerInputPort geoViewSearchManager;
  setUp(() {

    geoViewSearchManager= GeoViewSearchManager();
    mockLocationAdapter = MockLocationAdapter();


    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => true);

    mockFluttertoastAdapter = MockFluttertoastAdapter();


    mockGeoLocationUtilForeGroundUseCaseInputPort =
        new MockGeoLocationUtilForeGroundUseCaseInputPort();


    when(mockGeoLocationUtilForeGroundUseCaseInputPort.useGpsReq()).thenAnswer((realInvocation) async => true);

    topH001NavExpendAniContentViewModel = TopH_I_001NavExpendAniContentViewModel(
        geoLocationUtilForeGroundUseCaseInputPort: mockGeoLocationUtilForeGroundUseCaseInputPort,
        locationAdapter: mockLocationAdapter,
        geoViewSearchManager: geoViewSearchManager,
        fluttertoastAdapter: mockFluttertoastAdapter);
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

    MockH001Listener mockH001Listener = MockH001Listener();
    geoViewSearchManager.subscribe(mockH001Listener);
    Position position = Position(latitude: 37.1,longitude: 127.1);
    //act
    await topH001NavExpendAniContentViewModel.loadPosition(position);
    //assert
    verify(mockH001Listener.search(position));

  });

}
