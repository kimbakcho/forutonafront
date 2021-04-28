import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:injectable/injectable.dart';

import 'GeoLocationUtilBasicUseCaseInputPort.dart';

@LazySingleton(as: GeoLocationUtilBasicUseCaseInputPort)
class GeoLocationUtilBasicUseCase
    implements GeoLocationUtilBasicUseCaseInputPort {
  GeolocatorAdapter? _geolocatorAdapter;

  SharedPreferencesAdapter? _sharedPreferencesAdapter;

  StreamSubscription<Position>? _userPositionStream;

  GeoLocationUtilBasicUseCase(
      {required GeolocatorAdapter geolocatorAdapter,
      required SharedPreferencesAdapter sharedPreferencesAdapter})
      : _geolocatorAdapter = geolocatorAdapter,
        _sharedPreferencesAdapter = sharedPreferencesAdapter {
    _userPositionStream =
        this.getUserPositionStream().listen(_userPositionStreamFunc);
  }

  Position? currentWithLastPosition;
  String? currentWithLastAddress;

  Position? getCurrentWithLastPositionInMemory() {
    if (currentWithLastPosition == null) {
      return Position(
          latitude: Preference.initPosition.latitude,
          longitude: Preference.initPosition.longitude);
    } else {
      return currentWithLastPosition;
    }
  }

  String? getCurrentWithLastAddressInMemory() {
    if (currentWithLastAddress == null) {
      return Preference.initAddress;
    } else {
      return currentWithLastAddress;
    }
  }

  Future<Position> getCurrentWithLastPosition() async {
    Position resultPosition;
    try {
      resultPosition = await _geolocatorAdapter!.getCurrentPosition();
    } catch (Ex) {
      print(Ex);
      resultPosition = await getLastKnowPonePosition();
    }
    try {
      await _saveUserPositionClient(resultPosition);
    } catch (Ex) {
      print(Ex);
    }

    return resultPosition;
  }

  Future _saveUserPositionClient(Position resultPosition) async {
    currentWithLastPosition = resultPosition;

    currentWithLastAddress = await getPositionAddress(currentWithLastPosition!);

    await _sharedPreferencesAdapter!
        .setDouble("currentlong", resultPosition.longitude!);
    await _sharedPreferencesAdapter!
        .setDouble("currentlat", resultPosition.latitude!);
  }

  Future<Position> getLastKnowPonePosition() async {
    var currentlong = await _sharedPreferencesAdapter!.getDouble("currentlong");
    var currentlat = await _sharedPreferencesAdapter!.getDouble("currentlat");
    Position knowPosition;
    if (currentlong != null && currentlat != null) {
      knowPosition = Position(longitude: currentlong, latitude: currentlat);
    } else {
      knowPosition = Position(
          longitude: Preference.initPosition.longitude,
          latitude: Preference.initPosition.latitude);
    }
    return knowPosition;
  }

  Future<String> getPositionAddress(Position searchPosition) async {
    var placeMarkList = [];
    try {
      placeMarkList = await _geolocatorAdapter!
          .placemarkFromPosition(searchPosition, localeIdentifier: "ko");
    } catch (ex) {
      debugPrint(ex.toString());
    }

    if (placeMarkList.length > 0) {
      return replacePlacemarkToAddresStr(placeMarkList[0]);
    } else {
      throw FlutterError("주소를 알 수 없습니다");
    }
  }

  String replacePlacemarkToAddresStr(Placemark placemark) {
    String resultAddress = "";
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.length != 0) {
      resultAddress += placemark.administrativeArea!;
    } else {
      resultAddress = "";
    }

    if (placemark.subLocality != null && placemark.subLocality!.length != 0) {
      resultAddress += (" " + placemark.subLocality!);
    }

    if (placemark.thoroughfare != null && placemark.thoroughfare!.length != 0) {
      resultAddress += (" " + placemark.thoroughfare!);
    }

    if (placemark.subThoroughfare != null &&
        placemark.subThoroughfare!.length != 0) {
      resultAddress += (" " + placemark.subThoroughfare!);
    }

    return resultAddress;
  }

  _userPositionStreamFunc(Position position) async {
    await _saveUserPositionClient(position);
  }

  @override
  Stream<Position> getUserPositionStream() {
    return _geolocatorAdapter!.userPosition!;
  }

  dispose() {
    _userPositionStream!.cancel();
  }

  @override
  startStreamCurrentPosition() {
    _geolocatorAdapter!.startStreamCurrentPosition();
  }
}
