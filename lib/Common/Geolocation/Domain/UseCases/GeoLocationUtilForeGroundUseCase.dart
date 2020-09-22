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

@Injectable(as: GeoLocationUtilForeGroundUseCaseInputPort)
class GeoLocationUtilForeGroundUseCase
    implements GeoLocationUtilForeGroundUseCaseInputPort {
  final GeolocatorAdapter _geolocatorAdapter;
  final GeoLocationUtilBasicUseCaseInputPort _basicUseCaseInputPort;
  final LocationAdapter _locationAdapter;
  final SharedPreferencesAdapter _sharedPreferencesAdapter;

  Mutex _geoRequestMutex = new Mutex();

  Position currentWithLastPosition;
  String currentWithLastAddress;

  GeoLocationUtilForeGroundUseCase(
      {@required GeoLocationUtilBasicUseCaseInputPort basicUseCaseInputPort,
        @required GeolocatorAdapter geolocatorAdapter,
        @required SharedPreferencesAdapter sharedPreferencesAdapter,
        @required LocationAdapter locationAdapter
      })
      : _basicUseCaseInputPort = basicUseCaseInputPort,
        _geolocatorAdapter = geolocatorAdapter,
        _sharedPreferencesAdapter = sharedPreferencesAdapter,
        _locationAdapter=locationAdapter;

  @override
  String getCurrentWithLastAddressInMemory() {
    return _basicUseCaseInputPort.getCurrentWithLastAddressInMemory();
  }

  @override
  Future<Position> getCurrentWithLastPosition()async {
    bool _serviceEnabled;
    _serviceEnabled = await _locationAdapter.serviceEnabled();
    Position resultPosition;
    if (!_serviceEnabled) {
      resultPosition = await getLastKnowPonePosition();
    } else {
      resultPosition = await _geolocatorAdapter.getCurrentPosition();
      await _sharedPreferencesAdapter.setDouble("currentlong", resultPosition.longitude);
      await _sharedPreferencesAdapter.setDouble("currentlat", resultPosition.latitude);
    }
    currentWithLastPosition = resultPosition;
    currentWithLastAddress =
        await getPositionAddress(currentWithLastPosition);
    return resultPosition;
  }

  @override
  Position getCurrentWithLastPositionInMemory() {
    return _basicUseCaseInputPort.getCurrentWithLastPositionInMemory();
  }

  @override
  Future<Position> getLastKnowPonePosition() async {
    return await _basicUseCaseInputPort.getLastKnowPonePosition();
  }

  @override
  Future<String> getPositionAddress(Position searchPosition) async {
    return await _basicUseCaseInputPort.getPositionAddress(searchPosition);
  }

  @override
  String replacePlacemarkToAddresStr(Placemark placemark) {
    return _basicUseCaseInputPort.replacePlacemarkToAddresStr(placemark);
  }

  @override
  Future<void> reqBallDistanceDisplayText({@required Position ballLatLng,
    @required GeoLocationUtilUseForeGroundCaseOutputPort geoLocationUtilUseCaseOp}) async {
    var position = await getLastKnowPonePosition();
    var distance = await _geolocatorAdapter.distanceBetween(ballLatLng.latitude,
        ballLatLng.longitude, position.latitude, position.longitude);
    geoLocationUtilUseCaseOp.onBallDistanceDisplayText(
        displayDistanceText: DistanceDisplayUtil.changeDisplayStr(distance));
  }

  @override
  Future<bool> useGpsReq() async {
    await _geoRequestMutex.acquire();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _permissionGranted = await _locationAdapter.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationAdapter.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _geoRequestMutex.release();
        return false;
      }
    }

    _serviceEnabled = await _locationAdapter.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationAdapter.requestService();
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
    return _basicUseCaseInputPort.getUserPositionStream();
  }

  @override
  startStreamCurrentPosition() {
    _basicUseCaseInputPort.startStreamCurrentPosition();
  }
}
