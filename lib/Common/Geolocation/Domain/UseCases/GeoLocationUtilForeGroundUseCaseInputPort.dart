import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';

import 'GeoLocationUtilBasicUseCaseInputPort.dart';
import 'GeoLocationUtilUseForeGroundCaseOutputPort.dart';

abstract class GeoLocationUtilForeGroundUseCaseInputPort extends GeoLocationUtilBasicUseCaseInputPort{
  Future<bool> useGpsReq();
  Future<String> reqBallDistanceDisplayText({@required Position ballLatLng,@required  GeoLocationUtilUseForeGroundCaseOutputPort geoLocationUtilUseCaseOp});
}