import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:injectable/injectable.dart';
import 'package:mutex/mutex.dart';

import 'GeoLocationUtilBasicUseCaseInputPort.dart';
import 'GeoLocationUtilForeGroundUseCaseInputPort.dart';

@LazySingleton(as: GeoLocationUtilForeGroundUseCaseInputPort)
class GeoLocationUtilForeGroundUseCase
    implements GeoLocationUtilForeGroundUseCaseInputPort {
  final GeolocatorAdapter geolocatorAdapter;
  final GeoLocationUtilBasicUseCaseInputPort basicUseCaseInputPort;
  final LocationAdapter locationAdapter;
  final SharedPreferencesAdapter sharedPreferencesAdapter;

  Mutex _geoRequestMutex = new Mutex();

  Position currentWithLastPosition;
  String currentWithLastAddress;

  GeoLocationUtilForeGroundUseCase(
      {@required this.basicUseCaseInputPort,
        @required this.geolocatorAdapter,
        @required this.sharedPreferencesAdapter,
        @required this.locationAdapter
      });

  @override
  String getCurrentWithLastAddressInMemory() {
    return basicUseCaseInputPort.getCurrentWithLastAddressInMemory();
  }

  @override
  Future<Position> getCurrentWithLastPosition()async {
    bool _serviceEnabled;
    _serviceEnabled = await locationAdapter.serviceEnabled();
    Position resultPosition;
    if (!_serviceEnabled) {
      resultPosition = await getLastKnowPonePosition();
    } else {
      resultPosition = await geolocatorAdapter.getCurrentPosition();
      await sharedPreferencesAdapter.setDouble("currentlong", resultPosition.longitude);
      await sharedPreferencesAdapter.setDouble("currentlat", resultPosition.latitude);
    }
    currentWithLastPosition = resultPosition;
    currentWithLastAddress =
        await getPositionAddress(currentWithLastPosition);
    return resultPosition;
  }

  @override
  Position getCurrentWithLastPositionInMemory() {
    return basicUseCaseInputPort.getCurrentWithLastPositionInMemory();
  }

  @override
  Future<Position> getLastKnowPonePosition() async {
    return await basicUseCaseInputPort.getLastKnowPonePosition();
  }

  @override
  Future<String> getPositionAddress(Position searchPosition) async {
    return await basicUseCaseInputPort.getPositionAddress(searchPosition);
  }

  @override
  String replacePlacemarkToAddresStr(Placemark placemark) {
    return basicUseCaseInputPort.replacePlacemarkToAddresStr(placemark);
  }

  @override
  Future<void> reqBallDistanceDisplayText({@required Position ballLatLng,
    @required GeoLocationUtilUseForeGroundCaseOutputPort geoLocationUtilUseCaseOp}) async {
    var position = await getLastKnowPonePosition();
    var distance = await geolocatorAdapter.distanceBetween(ballLatLng.latitude,
        ballLatLng.longitude, position.latitude, position.longitude);
    geoLocationUtilUseCaseOp.onBallDistanceDisplayText(
        displayDistanceText: DistanceDisplayUtil.changeDisplayStr(distance));
  }

  @override
  Future<bool> useGpsReq() async {
    await _geoRequestMutex.acquire();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _permissionGranted = await locationAdapter.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationAdapter.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _geoRequestMutex.release();
        return false;
      }
    }

    _serviceEnabled = await locationAdapter.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationAdapter.requestService();
      if (!_serviceEnabled) {
        _geoRequestMutex.release();
        return false;
      }
    }
    _geoRequestMutex.release();
    return true;
  }

  @override
  Stream<Position> getUserPositionStream() {
    return basicUseCaseInputPort.getUserPositionStream();
  }

  @override
  startStreamCurrentPosition() {
    basicUseCaseInputPort.startStreamCurrentPosition();
  }
}
