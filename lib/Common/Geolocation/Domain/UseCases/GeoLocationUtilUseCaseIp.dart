import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'GeoLocationUtilUseCaseOp.dart';

abstract class GeoLocationUtilUseCaseIp {
  Future<bool> useGpsReq(BuildContext context);
  Future<Position> getCurrentWithLastPosition();
  Future<Position> getLastKnowPonePosition();
  Future<bool> permissionCheck();
  Future<String> getPositionAddress(Position searchPosition);
  String replacePlacemarkToAddresStr(Placemark placemark);
  void reqBallDistanceDisplayText({@required double lat,@required  double lng,@required  GeoLocationUtilUseCaseOp geoLocationUtilUseCaseOp});
}