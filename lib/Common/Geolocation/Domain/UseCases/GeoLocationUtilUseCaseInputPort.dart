import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'GeoLocationUtilUseCaseOutputPort.dart';

abstract class GeoLocationUtilUseCaseInputPort {
  Future<bool> useGpsReq();
  Future<Position> getCurrentWithLastPosition();
  Future<Position> getLastKnowPonePosition();
  Future<String> getPositionAddress(Position searchPosition);
  String replacePlacemarkToAddresStr(Placemark placemark);
  Future<void> reqBallDistanceDisplayText({@required Position ballLatLng,@required  GeoLocationUtilUseCaseOutputPort geoLocationUtilUseCaseOp});
  Position getCurrentWithLastPositionInMemory();
  String getCurrentWithLastAddressInMemory();
}