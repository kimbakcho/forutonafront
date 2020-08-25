import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:mockito/mockito.dart';

class MockGeolocatorAdapter extends Mock implements GeolocatorAdapter {}

class MockSharedPreferencesAdapter extends Mock
    implements SharedPreferencesAdapter {}

class MockPreference extends Mock implements Preference {}

class MockGeoLocationUtilUseCaseOutputPort extends Mock
    implements GeoLocationUtilUseForeGroundCaseOutputPort {}

void main() {
  MockGeolocatorAdapter mockGeolocatorAdapter;
  MockSharedPreferencesAdapter mockSharedPreferencesAdapter;
  MockPreference mockPreference;

  GeoLocationUtilBasicUseCase geoLocationUtilUseCase;
  StreamController _fUserCurrentPositionStreamController;
  setUp(() {
    mockGeolocatorAdapter = MockGeolocatorAdapter();
    mockSharedPreferencesAdapter = MockSharedPreferencesAdapter();
    mockPreference = MockPreference();
    _fUserCurrentPositionStreamController =
        StreamController<Position>.broadcast();
    when(mockGeolocatorAdapter.userPosition)
        .thenAnswer((_)=>_fUserCurrentPositionStreamController.stream);
    geoLocationUtilUseCase = GeoLocationUtilBasicUseCase(
        geolocatorAdapter: mockGeolocatorAdapter,
        sharedPreferencesAdapter: mockSharedPreferencesAdapter,
        preference: mockPreference);
  });

  tearDown(() {
    _fUserCurrentPositionStreamController.close();
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
    when(mockGeolocatorAdapter.getCurrentPosition())
        .thenThrow(Exception("Time Out"));
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

    await geoLocationUtilUseCase.getCurrentWithLastPosition();
    //assert
    expect(geoLocationUtilUseCase.currentWithLastAddress, "한국");
    expect(geoLocationUtilUseCase.currentWithLastPosition.longitude, 127.4);
    expect(geoLocationUtilUseCase.currentWithLastPosition.latitude, 31.0);
  });

  test('가장 최근 위치값(gps 서비스 사용이 안될때,저장 장치에도 저장 된것이 없을때) ', () async {
    //arrange
    when(mockGeolocatorAdapter.getCurrentPosition())
        .thenThrow(Exception("Time Out"));
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
    when(mockGeolocatorAdapter.getCurrentPosition())
        .thenThrow(Exception("Time Out"));

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
    var address = await geoLocationUtilUseCase
        .getPositionAddress(Position(longitude: 127.4, latitude: 31.0));
    //assert
    verify(mockGeolocatorAdapter.placemarkFromPosition(any,
        localeIdentifier: anyNamed('localeIdentifier')));
    expect(address, "한국");
  });

  test('주소 변환 테스트', () async {
    //act
    var administrativeArea = geoLocationUtilUseCase
        .replacePlacemarkToAddresStr(Placemark(administrativeArea: "한국"));

    var subLocality = geoLocationUtilUseCase.replacePlacemarkToAddresStr(
        Placemark(administrativeArea: "한국", subLocality: "경기도"));
    var thoroughfare = geoLocationUtilUseCase.replacePlacemarkToAddresStr(
        Placemark(
            administrativeArea: "한국", subLocality: "경기도", thoroughfare: "오산시"));
    var subThoroughfare = geoLocationUtilUseCase.replacePlacemarkToAddresStr(
        Placemark(
            administrativeArea: "한국",
            subLocality: "경기도",
            thoroughfare: "오산시",
            subThoroughfare: "58-2"));
    //then
    expect(administrativeArea, "한국");

    expect(subLocality, "한국 경기도");

    expect(thoroughfare, "한국 경기도 오산시");

    expect(subThoroughfare, "한국 경기도 오산시 58-2");
  });
}
