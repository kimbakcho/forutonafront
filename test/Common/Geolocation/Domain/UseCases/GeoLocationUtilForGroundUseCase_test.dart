import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:mockito/mockito.dart';

class MockSharedPreferencesAdapter extends Mock
    implements SharedPreferencesAdapter {}

class MockGeolocatorAdapter extends Mock implements GeolocatorAdapter {}

class MockLocationAdapter extends Mock implements LocationAdapter {}

class MockPreference extends Mock implements Preference {}

class MockGeoLocationUtilUseCaseOutputPort extends Mock
    implements GeoLocationUtilUseForeGroundCaseOutputPort {}

class MockGeoLocationUtilBasicUseCaseInputPort extends Mock
    implements GeoLocationUtilBasicUseCaseInputPort {}

class MockGeoLocationUtilUseForeGroundCaseOutputPort extends Mock
    implements GeoLocationUtilUseForeGroundCaseOutputPort {}

void main() {
  GeoLocationUtilForeGroundUseCase geoLocationUtilUseCase;

  MockGeolocatorAdapter mockGeolocatorAdapter;
  MockSharedPreferencesAdapter mockSharedPreferencesAdapter;
  MockGeoLocationUtilBasicUseCaseInputPort
      mockGeoLocationUtilBasicUseCaseInputPort;
  MockLocationAdapter mockLocationAdapter;
  MockGeoLocationUtilUseForeGroundCaseOutputPort mockGeoLocationUtilUseForeGroundCaseOutputPort;
  setUp(() {
    mockLocationAdapter = MockLocationAdapter();
    mockGeolocatorAdapter = MockGeolocatorAdapter();
    mockSharedPreferencesAdapter = MockSharedPreferencesAdapter();
    mockGeoLocationUtilBasicUseCaseInputPort =
        MockGeoLocationUtilBasicUseCaseInputPort();
    mockGeoLocationUtilUseForeGroundCaseOutputPort = MockGeoLocationUtilUseForeGroundCaseOutputPort();
    geoLocationUtilUseCase = GeoLocationUtilForeGroundUseCase(
        sharedPreferencesAdapter: mockSharedPreferencesAdapter,
        geolocatorAdapter: mockGeolocatorAdapter,
        basicUseCaseInputPort: mockGeoLocationUtilBasicUseCaseInputPort,
        locationAdapter: mockLocationAdapter);
  });

  test('useGpsReq 위치 정보 허용 -> 서비스 사용가능 return true', () async {
    //arrange
    when(mockLocationAdapter.hasPermission())
        .thenAnswer((_) async => PermissionStatus.granted);

    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => true);
    //act
    var result = await geoLocationUtilUseCase.useGpsReq();
    //assert
    verifyInOrder([
      mockLocationAdapter.hasPermission(),
      mockLocationAdapter.serviceEnabled()
    ]);
    expect(result, true);
  });

  test('useGpsReq 위치 정보 허용 -> 서비스 사용불가 -> 서비스 사용 요청 -> 서비스 사용 허가 return true',
      () async {
    //arrange
    when(mockLocationAdapter.hasPermission())
        .thenAnswer((_) async => PermissionStatus.granted);

    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => false);
    when(mockLocationAdapter.requestService())
        .thenAnswer((realInvocation) async => true);
    //act
    var result = await geoLocationUtilUseCase.useGpsReq();
    //assert
    verifyInOrder([
      mockLocationAdapter.hasPermission(),
      mockLocationAdapter.serviceEnabled(),
      mockLocationAdapter.requestService()
    ]);
    expect(result, true);
  });

  test('useGpsReq 위치 정보 사용 불가 -> 위치 정보 사용 거절 -> 서비스 사용 불가', () async {
    //arrange
    when(mockLocationAdapter.hasPermission())
        .thenAnswer((_) async => PermissionStatus.denied);

    when(mockLocationAdapter.requestPermission())
        .thenAnswer((_) async => PermissionStatus.denied);

    //act
    var result = await geoLocationUtilUseCase.useGpsReq();
    //assert
    verifyInOrder([
      mockLocationAdapter.hasPermission(),
      mockLocationAdapter.requestPermission(),
    ]);
    expect(result, false);
  });

  test('useGpsReq 위치 정보 사용 불가 -> 위치 정보 사용 사용 -> 서비스 사용 불가 -> 서비스 요청- 불가',
      () async {
    //arrange
    when(mockLocationAdapter.hasPermission())
        .thenAnswer((_) async => PermissionStatus.denied);

    when(mockLocationAdapter.requestPermission())
        .thenAnswer((_) async => PermissionStatus.granted);

    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => false);
    when(mockLocationAdapter.requestService())
        .thenAnswer((realInvocation) async => false);

    //act
    var result = await geoLocationUtilUseCase.useGpsReq();
    //assert
    verifyInOrder([
      mockLocationAdapter.hasPermission(),
      mockLocationAdapter.requestPermission(),
      mockLocationAdapter.serviceEnabled(),
      mockLocationAdapter.requestService()
    ]);
    expect(result, false);
  });

  test('GPS 사용이 안될때 Phone 이 알고 있는 가장 최근 위치값 ', () async {
    //arrange
    when(mockLocationAdapter.serviceEnabled()).thenAnswer((_) async => false);
    when(mockGeoLocationUtilBasicUseCaseInputPort.getLastKnowPonePosition())
        .thenAnswer((realInvocation) async =>
            Position(longitude: 127.4, latitude: 31.0));

    when(mockGeoLocationUtilBasicUseCaseInputPort.getPositionAddress(any))
        .thenAnswer((realInvocation) async => "한국");
    //act
    await geoLocationUtilUseCase.getCurrentWithLastPosition();
    //assert
    expect(geoLocationUtilUseCase.currentWithLastAddress, "한국");
    expect(geoLocationUtilUseCase.currentWithLastPosition.longitude, 127.4);
    expect(geoLocationUtilUseCase.currentWithLastPosition.latitude, 31.0);
  });

  test('가장 최근 위치값(gps 서비스 사용이 가능할때) ', () async {
    //arrange
    when(mockLocationAdapter.serviceEnabled()).thenAnswer((_) async => true);

    when(mockGeolocatorAdapter.getCurrentPosition()).thenAnswer(
        (realInvocation) async => Position(longitude: 31.5, latitude: 125.6));

    when(mockGeoLocationUtilBasicUseCaseInputPort.getPositionAddress(any))
        .thenAnswer((realInvocation) async => "한국");
    //act
    var currentWithLastPosition =
        await geoLocationUtilUseCase.getCurrentWithLastPosition();
    //assert
    expect(geoLocationUtilUseCase.currentWithLastAddress, "한국");
    expect(geoLocationUtilUseCase.currentWithLastPosition.longitude, 31.5);
    expect(geoLocationUtilUseCase.currentWithLastPosition.latitude, 125.6);
    expect(currentWithLastPosition.longitude, 31.5);
    expect(currentWithLastPosition.latitude, 125.6);
    verify(mockSharedPreferencesAdapter.setDouble("currentlong", any));
    verify(mockSharedPreferencesAdapter.setDouble("currentlat", any));
  });

  test("상대 거리 Text 형식에 맞춘 Style 로 변환 하여 OutputPort 에 출력 ", () async {
    //arrange
    when(mockGeoLocationUtilBasicUseCaseInputPort.getLastKnowPonePosition())
        .thenAnswer((realInvocation) async =>
        Position(longitude: 127, latitude: 31));

    when(mockGeolocatorAdapter.distanceBetween(any, any, any, any))
        .thenAnswer((realInvocation) async => 1000.0);
    //act
    await geoLocationUtilUseCase.reqBallDistanceDisplayText(
        ballLatLng: Position(latitude: 127, longitude: 31),
        geoLocationUtilUseCaseOp: mockGeoLocationUtilUseForeGroundCaseOutputPort);
    //assert
    verify(mockGeoLocationUtilUseForeGroundCaseOutputPort.onBallDistanceDisplayText(
        displayDistanceText: anyNamed('displayDistanceText')));
  });


}
