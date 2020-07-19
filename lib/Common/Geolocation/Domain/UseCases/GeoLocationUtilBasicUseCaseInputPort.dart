import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'GeoLocationUtilUseForeGroundCaseOutputPort.dart';

abstract class GeoLocationUtilBasicUseCaseInputPort {
  Future<Position> getCurrentWithLastPosition();
  Future<Position> getLastKnowPonePosition();
  Future<String> getPositionAddress(Position searchPosition);
  String replacePlacemarkToAddresStr(Placemark placemark);
  Position getCurrentWithLastPositionInMemory();
  String getCurrentWithLastAddressInMemory();
}
