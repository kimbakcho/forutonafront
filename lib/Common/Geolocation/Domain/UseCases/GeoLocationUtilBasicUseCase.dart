import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Preference.dart';

import 'GeoLocationUtilBasicUseCaseInputPort.dart';

class GeoLocationUtilBasicUseCase
    implements GeoLocationUtilBasicUseCaseInputPort {
  GeolocatorAdapter _geolocatorAdapter;

  SharedPreferencesAdapter _sharedPreferencesAdapter;
  Preference _preference;

  GeoLocationUtilBasicUseCase(
      {@required GeolocatorAdapter geolocatorAdapter,
      @required SharedPreferencesAdapter sharedPreferencesAdapter,
      @required Preference preference})
      : _geolocatorAdapter = geolocatorAdapter,
        _sharedPreferencesAdapter = sharedPreferencesAdapter,
        _preference = preference;

  Position currentWithLastPosition;
  String currentWithLastAddress;

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
    Position resultPosition;
    try {
      resultPosition = await _geolocatorAdapter.getCurrentPosition();
      print("getCurrentWithLastPosition");
      print(resultPosition);
    } catch (Ex) {
      print(Ex);
      resultPosition = await getLastKnowPonePosition();
    }
    await _sharedPreferencesAdapter.setDouble(
        "currentlong", resultPosition.longitude);
    await _sharedPreferencesAdapter.setDouble(
        "currentlat", resultPosition.latitude);
    currentWithLastPosition = resultPosition;
    currentWithLastAddress = await getPositionAddress(currentWithLastPosition);
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
