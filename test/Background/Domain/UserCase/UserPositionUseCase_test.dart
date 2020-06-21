import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Common/FireBaseAdapter/FireBaseAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockGeoLocationUtilUseCase extends Mock implements GeoLocationUtilUseCaseInputPort{}
class MockFUserRepository extends Mock implements FUserRepository{}
class MockFireBaseAdapter extends Mock implements FireBaseAdapter{}
void main(){

  BackgroundUserPositionUseCaseInputPort userPositionUseCase;

  MockGeoLocationUtilUseCase mockGeoLocationUtilUseCase;
  MockFUserRepository mockFUserRepository;
  MockFireBaseAdapter mockFireBaseAdapter;

  setUp((){
    mockGeoLocationUtilUseCase = MockGeoLocationUtilUseCase();
    mockFUserRepository = MockFUserRepository();
    mockFireBaseAdapter = new MockFireBaseAdapter();

    userPositionUseCase =
        BackgroundUserPositionUseCase(geoLocationUtilUseCaseInputPort: mockGeoLocationUtilUseCase,
        fUserRepository: mockFUserRepository,fireBaseAdapter: mockFireBaseAdapter);
  });

  test('로그인 상황 일때 최근 위치값 업데이트 하기', () async {
    //arrange
    when(mockGeoLocationUtilUseCase.getCurrentWithLastPosition()).thenAnswer((_)async =>
        Position(
            latitude: 127.1,
            longitude: 30.1
        )
    );
    when(mockFireBaseAdapter.isLogin()).thenAnswer((_)async => true);
    //act
    await userPositionUseCase.loop();
    //assert
    verify(mockGeoLocationUtilUseCase.getCurrentWithLastPosition());
    verify(mockFUserRepository.updateUserPosition(any));
  });

  test('로그 아웃 에서 위치 정보 실행 하지 않기', () async {
    //arrange
    when(mockGeoLocationUtilUseCase.getCurrentWithLastPosition()).thenAnswer((_)async =>
        Position(
            latitude: 127.1,
            longitude: 30.1
        )
    );
    when(mockFireBaseAdapter.isLogin()).thenAnswer((_)async => false);
    //act
    await userPositionUseCase.loop();
    //assert
    verifyNever(mockGeoLocationUtilUseCase.getCurrentWithLastPosition());
    verifyNever(mockFUserRepository.updateUserPosition(any));
  });

  test('최근 위치값을 서버에 저장', () async {
    //arrange
    when(mockGeoLocationUtilUseCase.getCurrentWithLastPosition()).thenAnswer((realInvocation)async =>
      Position(
        latitude: 127.1,
        longitude: 30.1
      )
    );
    //act
    await userPositionUseCase.loop();
    //assert
    verify(mockFUserRepository.updateUserPosition(LatLng(127.1,30.1)));
  });


}