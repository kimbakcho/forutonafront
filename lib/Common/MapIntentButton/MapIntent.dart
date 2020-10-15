import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter_package_manager/flutter_package_manager.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';

abstract class MapIntent {
  Future<bool> canLunch();

  Future<void> lunch();
}

class MapIntentNaverImpl implements MapIntent {
  final Position _dstPosition;
  final String _dstAddress;
  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCaseInputPort;

  MapIntentNaverImpl(
      {@required
          Position dstPosition,
        @required
        String dstAddress,
      @required
          GeoLocationUtilForeGroundUseCaseInputPort
              geoLocationUtilForeGroundUseCaseInputPort})
      : _geoLocationUtilForeGroundUseCaseInputPort =
            geoLocationUtilForeGroundUseCaseInputPort,
        _dstAddress =dstAddress,
        _dstPosition = dstPosition;

  @override
  Future<void> lunch() async {
    Position userPosition = _geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPositionInMemory();
    AndroidIntentAdapter androidIntentAdapter = AndroidIntentAdapterImpl();
    androidIntentAdapter.createIntent(
      action: "action_view",
      flags: [AndroidIntentAdapter.FLAG_ACTIVITY_NEW_TASK],
      data:
          "nmap://route/public?slat=${userPosition.latitude}"
              "&slng=${userPosition.longitude}"
              "&sname=${Uri.encodeComponent("현재위치")}"
              "&dlat=${_dstPosition.latitude}"
              "&dlng=${_dstPosition.longitude}"
              "&dname=$_dstAddress"
              "&appname=co.kr.forutonafront",
    );
    await androidIntentAdapter.launch();
  }

  @override
  Future<bool> canLunch() async {
    final PackageInfo info =
        await FlutterPackageManager.getPackageInfo('com.nhn.android.nmap');

    if (info != null) {
      return true;
    } else {
      return false;
    }
  }
}

class MapIntentKakaoImpl implements MapIntent {
  final Position _dstPosition;
  final GeoLocationUtilForeGroundUseCaseInputPort
  _geoLocationUtilForeGroundUseCaseInputPort;

  MapIntentKakaoImpl(
      {@required
      Position dstPosition,
        @required
        GeoLocationUtilForeGroundUseCaseInputPort
        geoLocationUtilForeGroundUseCaseInputPort})
      : _geoLocationUtilForeGroundUseCaseInputPort =
      geoLocationUtilForeGroundUseCaseInputPort,
        _dstPosition = dstPosition;

  @override
  Future<void> lunch() async {
    Position userPosition = _geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPositionInMemory();
    AndroidIntentAdapter androidIntentAdapter = AndroidIntentAdapterImpl();
    androidIntentAdapter.createIntent(
      action: "action_view",
      flags: [AndroidIntentAdapter.FLAG_ACTIVITY_NEW_TASK],
      data:
      "kakaomap://route?sp=${userPosition.latitude},${userPosition.longitude}"
          "&ep=${_dstPosition.latitude},${_dstPosition.longitude}"
          "&by=PUBLICTRANSIT",
    );
    await androidIntentAdapter.launch();
  }

  @override
  Future<bool> canLunch() async {
    final PackageInfo info =
    await FlutterPackageManager.getPackageInfo('net.daum.android.map');
    if (info != null) {
      return true;
    } else {
      return false;
    }
  }
}

class MapIntentGoogleImpl implements MapIntent {
  final Position _dstPosition;
  final GeoLocationUtilForeGroundUseCaseInputPort
  _geoLocationUtilForeGroundUseCaseInputPort;

  MapIntentGoogleImpl(
      {@required
      Position dstPosition,
        @required
        GeoLocationUtilForeGroundUseCaseInputPort
        geoLocationUtilForeGroundUseCaseInputPort})
      : _geoLocationUtilForeGroundUseCaseInputPort =
      geoLocationUtilForeGroundUseCaseInputPort,
        _dstPosition = dstPosition;

  @override
  Future<void> lunch() async {
    Position userPosition = _geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPositionInMemory();
    AndroidIntentAdapter androidIntentAdapter = AndroidIntentAdapterImpl();
    androidIntentAdapter.createIntent(
      action: "action_view",
      flags: [AndroidIntentAdapter.FLAG_ACTIVITY_NEW_TASK],
      data:
      "http://maps.google.com/maps?"
          "saddr=${userPosition.latitude},${userPosition.longitude}"
          "&daddr=${_dstPosition.latitude},${_dstPosition.longitude}&hl=ko",
    );
    await androidIntentAdapter.launch();
  }

  @override
  Future<bool> canLunch() async {
    final PackageInfo info =
    await FlutterPackageManager.getPackageInfo('com.google.android.apps.maps');

    if (info != null) {
      return true;
    } else {
      return false;
    }
  }
}