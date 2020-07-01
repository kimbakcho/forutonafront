import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutex/mutex.dart';
import 'package:permission_handler/permission_handler.dart' as Permit;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GeoLocationUtilUseCaseInputPort.dart';
import 'GeoLocationUtilUseCaseOutputPort.dart';

class GeoLocationUtilUseCase implements GeoLocationUtilUseCaseInputPort {
  GeolocatorAdapter _geolocatorAdapter;
  LocationAdapter _locationAdapter;
  SharedPreferencesAdapter _sharedPreferencesAdapter;
  Preference _preference;
  Mutex _geoRequestMutex = new Mutex();

  GeoLocationUtilUseCase(
      {@required GeolocatorAdapter geolocatorAdapter,
        @required  LocationAdapter locationAdapter,
        @required  SharedPreferencesAdapter sharedPreferencesAdapter,
        @required Preference preference
      })
      : _geolocatorAdapter = geolocatorAdapter,
        _locationAdapter = locationAdapter,
        _sharedPreferencesAdapter = sharedPreferencesAdapter,
        _preference = preference;

  Position currentWithLastPosition;
  String currentWithLastAddress;

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

  Position getCurrentWithLastPositionInMemory() {
    if (currentWithLastPosition == null) {
      return Position(
          latitude: _preference.initPosition.latitude,
          longitude: _preference.initPosition.longitude);
    } else {
      return currentWithLastPosition;
    }
  }

  String getCurrentWithLastAddressInMemory() {
    if (currentWithLastAddress == null) {
      return _preference.initAddress;
    } else {
      return currentWithLastAddress;
    }
  }

  Future<Position> getCurrentWithLastPosition() async {

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

  Future<Position> getLastKnowPonePosition() async {
    var currentlong = await _sharedPreferencesAdapter.getDouble("currentlong");
    var currentlat = await _sharedPreferencesAdapter.getDouble("currentlat");
    Position knowPosition;
    if (currentlong != null && currentlat != null) {
      knowPosition = Position(longitude: currentlong, latitude: currentlat);
    } else {
      knowPosition = Position(
          longitude: _preference.initPosition.longitude,
          latitude: _preference.initPosition.latitude);
    }
    return knowPosition;
  }


  Future<void> reqBallDistanceDisplayText(
      {@required
          Position ballLatLng,
      @required
          GeoLocationUtilUseCaseOutputPort geoLocationUtilUseCaseOp}) async {
    var position = await getLastKnowPonePosition();
    var distance = await _geolocatorAdapter.distanceBetween(ballLatLng.latitude,
        ballLatLng.longitude, position.latitude, position.longitude);
    geoLocationUtilUseCaseOp.onBallDistanceDisplayText(
        displayDistanceText: DistanceDisplayUtil.changeDisplayStr(distance));
  }

  Future<String> getPositionAddress(Position searchPosition) async {
    var placeMarkList = await _geolocatorAdapter
        .placemarkFromPosition(searchPosition, localeIdentifier: "ko");
    if (placeMarkList.length > 0) {
      return replacePlacemarkToAddresStr(placeMarkList[0]);
    } else {
      return "주소를 알 수 없습니다";
    }
  }

  String replacePlacemarkToAddresStr(Placemark placemark) {
    String resultAddress = "";
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea.length != 0) {
      resultAddress += placemark.administrativeArea;
    } else {
      resultAddress = "";
    }

    if (placemark.subLocality != null && placemark.subLocality.length != 0) {
      resultAddress += (" " + placemark.subLocality);
    }

    if (placemark.thoroughfare != null && placemark.thoroughfare.length != 0) {
      resultAddress += (" " + placemark.thoroughfare);
    }

    if (placemark.subThoroughfare != null &&
        placemark.subThoroughfare.length != 0) {
      resultAddress += (" " + placemark.subThoroughfare);
    }

    return resultAddress;
  }
}
