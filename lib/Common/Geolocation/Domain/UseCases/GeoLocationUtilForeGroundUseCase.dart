import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Page/ZCodePage/Z004/Z004CodeMainPage.dart';
import 'package:forutonafront/Page/ZCodePage/Z005/Z005CodeMainPage.dart';
import 'package:injectable/injectable.dart';
import 'package:mutex/mutex.dart';

import 'GeoLocationUtilBasicUseCaseInputPort.dart';
import 'GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart'
    as Adapter;

@LazySingleton(as: GeoLocationUtilForeGroundUseCaseInputPort)
class GeoLocationUtilForeGroundUseCase
    implements GeoLocationUtilForeGroundUseCaseInputPort {
  final GeolocatorAdapter geolocatorAdapter;
  final GeoLocationUtilBasicUseCaseInputPort basicUseCaseInputPort;
  final LocationAdapter locationAdapter;
  final SharedPreferencesAdapter sharedPreferencesAdapter;

  Mutex _geoRequestMutex = new Mutex();

  Position? currentWithLastPosition;
  String? currentWithLastAddress;

  GeoLocationUtilForeGroundUseCase(
      {required this.basicUseCaseInputPort,
      required this.geolocatorAdapter,
      required this.sharedPreferencesAdapter,
      required this.locationAdapter});

  @override
  String getCurrentWithLastAddressInMemory() {
    return basicUseCaseInputPort.getCurrentWithLastAddressInMemory()!;
  }

  @override
  Future<Position> getCurrentWithLastPosition() async {
    await _geoRequestMutex.acquire();
    Adapter.PermissionStatus _hasPermisstion;
    _hasPermisstion = await locationAdapter.hasPermission();
    bool positionServiceEnabled = await locationAdapter.serviceEnabled();
    Position resultPosition;
    if (_hasPermisstion != PermissionStatus.granted ||
        !positionServiceEnabled) {
      resultPosition = await getLastKnowPonePosition();
    } else {
      resultPosition = await geolocatorAdapter.getCurrentPosition();
      await sharedPreferencesAdapter.setDouble(
          "currentlong", resultPosition.longitude!);
      await sharedPreferencesAdapter.setDouble(
          "currentlat", resultPosition.latitude!);
    }
    currentWithLastPosition = resultPosition;
    try {
      currentWithLastAddress =
          await getPositionAddress(currentWithLastPosition!);
    } catch (ex) {
      currentWithLastAddress = "";
    }
    _geoRequestMutex.release();
    return resultPosition;
  }

  @override
  Position getCurrentWithLastPositionInMemory() {
    return basicUseCaseInputPort.getCurrentWithLastPositionInMemory()!;
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
  Future<String> reqBallDistanceDisplayText(
      {required
          Position ballLatLng,
          GeoLocationUtilUseForeGroundCaseOutputPort?
              geoLocationUtilUseCaseOp}) async {
    var position = await getLastKnowPonePosition();
    var distance = geolocatorAdapter.distanceBetween(ballLatLng.latitude!,
        ballLatLng.longitude!, position.latitude!, position.longitude!);
    var changeDisplayStr = DistanceDisplayUtil.changeDisplayStr(distance);
    if (geoLocationUtilUseCaseOp != null) {
      geoLocationUtilUseCaseOp.onBallDistanceDisplayText(
          displayDistanceText: changeDisplayStr);
    }
    return changeDisplayStr;
  }

  @override
  Future<bool> useGpsReq() async {
    await _geoRequestMutex.acquire();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _permissionGranted = await locationAdapter.hasPermission();
    if (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await locationAdapter.requestPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _geoRequestMutex.release();
        return false;
      } else if (_permissionGranted == PermissionStatus.deniedForever) {
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

  Future<bool> hasAllPositionPermission() async {
    await _geoRequestMutex.acquire();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _permissionGranted = await locationAdapter.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _geoRequestMutex.release();
      return false;
    }

    _serviceEnabled = await locationAdapter.serviceEnabled();
    if (!_serviceEnabled) {
      _geoRequestMutex.release();
      return false;
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
