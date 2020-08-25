
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FBallResForMarkerStyle2Dto {
  FBallType ballType;
  LatLng target;
  String ballUuid;

  FBallResForMarkerStyle2Dto(this.ballType, this.target, this.ballUuid);
}