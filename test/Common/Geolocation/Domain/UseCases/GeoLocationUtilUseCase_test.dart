import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseOutputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:mockito/mockito.dart';

class MockGeolocatorAdapter extends Mock implements GeolocatorAdapter {}

class MockLocationAdapter extends Mock implements LocationAdapter {}

class MockSharedPreferencesAdapter extends Mock
    implements SharedPreferencesAdapter {}

class MockPreference extends Mock implements Preference {}

class MockGeoLocationUtilUseCaseOutputPort extends Mock
    implements GeoLocationUtilUseCaseOutputPort {}

void main() {
  MockGeolocatorAdapter mockGeolocatorAdapter;
  MockLocationAdapter mockLocationAdapter;
  MockSharedPreferencesAdapter mockSharedPreferencesAdapter;
  MockPreference mockPreference;
  MockGeoLocationUtilUseCaseOutputPort mockGeoLocationUtilUseCaseOutputPort;
  GeoLocationUtilUseCase geoLocationUtilUseCase;

  setUp(() {
    mockGeolocatorAdapter = MockGeolocatorAdapter();
    mockLocationAdapter = MockLocationAdapter();
    mockSharedPreferencesAdapter = MockSharedPreferencesAdapter();
    mockPreference = MockPreference();
    mockGeoLocationUtilUseCaseOutputPort =
        MockGeoLocationUtilUseCaseOutputPort();

    geoLocationUtilUseCase = GeoLocationUtilUseCase(
        geolocatorAdapter: mockGeolocatorAdapter,
        locationAdapter: mockLocationAdapter,
        sharedPreferencesAdapter: mockSharedPreferencesAdapter,
        preference: mockPreference);
  });

  test('useGpsReq 위치 정보 거절되어 있음->사용자 허용->서비스 사용가능 return true', () async {
    //arrange
    when(mockLocationAdapter.hasPermission())
        .thenAnswer((_) async => PermissionStatus.denied);
    when(mockLocationAdapter.requestPermission())
        .thenAnswer((realInvocation) async => PermissionStatus.granted);
    when(mockLocationAdapter.serviceEnabled())
        .thenAnswer((realInvocation) async => true);
    //act
    var result = await geoLocationUtilUseCase.useGpsReq();
    //assert
    verifyInOrder([
      mockLocationAdapter.hasPermission(),
      mockLocationAdapter.requestPermission(),
      mockLocationAdapter.serviceEnabled()
    ]);
    expect(result, true);
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

  test('최근 위치 값 메모리에서 불러오기(메모리에 값 없을때)', () async {
    //arrange

    when(mockPreference.initPosition)
        .thenReturn(Position(longitude: 127.4, latitude: 31.1));
    //act
    var currentWithLastPositionInMemory =
        geoLocationUtilUseCase.getCurrentWithLastPositionInMemory();
    //assert
    expect(currentWithLastPositionInMemory.longitude, 127.4);
    expect(currentWithLastPositionInMemory.latitude, 31.1);
  });

  test('최근 위치 값 메모리에서 불러오기(메모리에 값 있을때)', () async {
    //arrange
    geoLocationUtilUseCase.currentWithLastPosition =
        Position(longitude: 126.2, latitude: 31);
    when(mockPreference.initPosition)
        .thenReturn(Position(longitude: 127.4, latitude: 31.1));
    //act
    var currentWithLastPositionInMemory =
        geoLocationUtilUseCase.getCurrentWithLastPositionInMemory();
    //assert
    expect(currentWithLastPositionInMemory.longitude, 126.2);
    expect(currentWithLastPositionInMemory.latitude, 31);
  });

  test('최근 주소 값 메모리에서 불러오기(메모리에 값 없을때)', () async {
    //arrange

    when(mockPreference.initAddress).thenReturn("테스트지역");
    //act
    var currentWithLastAddressInMemory =
        geoLocationUtilUseCase.getCurrentWithLastAddressInMemory();
    //assert
    expect(currentWithLastAddressInMemory, "테스트지역");
  });

  test('최근 주소 값 메모리에서 불러오기(메모리에 값 있을때)', () async {
    //arrange
    geoLocationUtilUseCase.currentWithLastAddress = "서울";
    when(mockPreference.initAddress).thenReturn("테스트지역");
    //act
    var currentWithLastAddressInMemory =
        geoLocationUtilUseCase.getCurrentWithLastAddressInMemory();
    //assert
    expect(currentWithLastAddressInMemory, "서울");
  });

  test('가장 최근 위치값(gps 서비스 사용이 안될때,저장 장치에는 저장되어 있을때) ', () async {
    //arrange
    when(mockLocationAdapter.serviceEnabled()).thenAnswer((_) async => false);
    when(mockSharedPreferencesAdapter.getDouble("currentlong"))
        .thenAnswer((_) async => 127.4);
    when(mockSharedPreferencesAdapter.getDouble("currentlat"))
        .thenAnswer((_) async => 31.0);
    when(mockGeolocatorAdapter.placemarkFromPosition(any,
            localeIdentifier: anyNamed('localeIdentifier')))
        .thenAnswer((realInvocation) async => [
              Placemark(
                administrativeArea: "한국",
              )
            ]);
    //act
    var currentWithLastPosition =
        await geoLocationUtilUseCase.getCurrentWithLastPosition();
    //assert
    expect(geoLocationUtilUseCase.currentWithLastAddress, "한국");
    expect(geoLocationUtilUseCase.currentWithLastPosition.longitude, 127.4);
    expect(geoLocationUtilUseCase.currentWithLastPosition.latitude, 31.0);
  });

  test('가장 최근 위치값(gps 서비스 사용이 안될때,저장 장치에도 저장 된것이 없을때) ', () async {
    //arrange
    when(mockLocationAdapter.serviceEnabled()).thenAnswer((_) async => false);
    when(mockSharedPreferencesAdapter.getDouble("currentlong"))
        .thenAnswer((_) async => null);
    when(mockSharedPreferencesAdapter.getDouble("currentlat"))
        .thenAnswer((_) async => null);
    when(mockPreference.initPosition)
        .thenReturn(Position(longitude: 125.4, latitude: 30.1));

    when(mockGeolocatorAdapter.placemarkFromPosition(any,
            localeIdentifier: anyNamed('localeIdentifier')))
        .thenAnswer((realInvocation) async => [
              Placemark(
                administrativeArea: "한국",
              )
            ]);
    //act
    var currentWithLastPosition =
        await geoLocationUtilUseCase.getCurrentWithLastPosition();
    //assert
    expect(geoLocationUtilUseCase.currentWithLastAddress, "한국");
    expect(geoLocationUtilUseCase.currentWithLastPosition.longitude, 125.4);
    expect(geoLocationUtilUseCase.currentWithLastPosition.latitude, 30.1);
    expect(currentWithLastPosition.longitude, 125.4);
    expect(currentWithLastPosition.latitude, 30.1);
  });

  test('가장 최근 위치값(gps 서비스 사용이 가능할때) ', () async {
    //arrange
    when(mockLocationAdapter.serviceEnabled()).thenAnswer((_) async => true);

    when(mockGeolocatorAdapter.getCurrentPosition())
        .thenAnswer((_) => Position(latitude: 125.6, longitude: 31.5));

    when(mockPreference.initPosition)
        .thenReturn(Position(longitude: 125.4, latitude: 30.1));

    when(mockGeolocatorAdapter.placemarkFromPosition(any,
            localeIdentifier: anyNamed('localeIdentifier')))
        .thenAnswer((realInvocation) async => [
              Placemark(
                administrativeArea: "한국",
              )
            ]);
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

  test('저장 장치에 저장된 폰의 마지막 위치', () async {
    //arrange
    when(mockSharedPreferencesAdapter.getDouble("currentlong"))
        .thenAnswer((_) async => 127.4);
    when(mockSharedPreferencesAdapter.getDouble("currentlat"))
        .thenAnswer((_) async => 31.0);
    //act
    var position = await geoLocationUtilUseCase.getLastKnowPonePosition();
    //assert
    verify(mockSharedPreferencesAdapter.getDouble("currentlong"));
    verify(mockSharedPreferencesAdapter.getDouble("currentlat"));
    expect(position.latitude, 31.0);
    expect(position.longitude, 127.4);
  });

  test("상대 거리 Text 형식에 맞춘 Style 로 변환 하여 OutputPort 에 출력 ", () async {
    //arrange
    when(mockSharedPreferencesAdapter.getDouble("currentlong"))
        .thenAnswer((_) async => 127.4);
    when(mockSharedPreferencesAdapter.getDouble("currentlat"))
        .thenAnswer((_) async => 31.0);
    when(mockGeolocatorAdapter.distanceBetween(any, any, any, any)).thenAnswer((realInvocation) async => 1000.0);
    //act
    await geoLocationUtilUseCase.reqBallDistanceDisplayText(
        ballLatLng: Position(latitude: 127, longitude: 31),
        geoLocationUtilUseCaseOp: mockGeoLocationUtilUseCaseOutputPort);
    //assert
    verify(mockGeoLocationUtilUseCaseOutputPort.onBallDistanceDisplayText(
        displayDistanceText: anyNamed('displayDistanceText')));
  });

  test('Position의 주소값 획득', () async {
    //arrange
    when(mockGeolocatorAdapter.placemarkFromPosition(any,
        localeIdentifier: anyNamed('localeIdentifier')))
        .thenAnswer((realInvocation) async => [
      Placemark(
        administrativeArea: "한국",
      )
    ]);
    //act
    var address = await geoLocationUtilUseCase.getPositionAddress(Position(longitude: 127.4,latitude: 31.0));
    //assert
    verify(mockGeolocatorAdapter.placemarkFromPosition(any,localeIdentifier: anyNamed('localeIdentifier')));
    expect(address, "한국");
  });

  test('주소 변환 테스트', () async {
    //act
    var administrativeArea = geoLocationUtilUseCase.replacePlacemarkToAddresStr(Placemark(
      administrativeArea: "한국"
    ));

    var subLocality = geoLocationUtilUseCase.replacePlacemarkToAddresStr(Placemark(
        administrativeArea: "한국",
        subLocality: "경기도"
    ));
    var thoroughfare = geoLocationUtilUseCase.replacePlacemarkToAddresStr(Placemark(
        administrativeArea: "한국",
        subLocality: "경기도",
        thoroughfare:"오산시"
    ));
    var subThoroughfare = geoLocationUtilUseCase.replacePlacemarkToAddresStr(Placemark(
        administrativeArea: "한국",
        subLocality: "경기도",
        thoroughfare:"오산시",
        subThoroughfare:"58-2"
    ));
    //then
    expect(administrativeArea, "한국");

    expect(subLocality, "한국 경기도");

    expect(thoroughfare, "한국 경기도 오산시");

    expect(subThoroughfare, "한국 경기도 오산시 58-2");

  });

}
