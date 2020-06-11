import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'GeoLocationUtilUseCaseOutputPort.dart';

abstract class GeoLocationUtilUseCaseInputPort {
  Future<bool> useGpsReq(BuildContext context);
  Future<Position> getCurrentWithLastPosition();
  Future<Position> getLastKnowPonePosition();
  Future<bool> permissionCheck();
  Future<String> getPositionAddress(Position searchPosition);
  String replacePlacemarkToAddresStr(Placemark placemark);
  void reqBallDistanceDisplayText({@required LatLng ballLatLng,@required  GeoLocationUtilUseCaseOutputPort geoLocationUtilUseCaseOp});
  Position getCurrentWithLastPositionInMemory();
  String getCurrentWithLastAddressInMemory();
}