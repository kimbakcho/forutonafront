import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
@Injectable()
class MapBallMarkerFactory {

  final MapMakerDescriptorContainer _mapMakerDescriptorContainer;

  MapBallMarkerFactory({@required MapMakerDescriptorContainer mapMakerDescriptorContainer})
      :_mapMakerDescriptorContainer= mapMakerDescriptorContainer;

  Marker getBallMaker(FBallType fBallType,String ballUuid, Position position) {
    if (fBallType == FBallType.IssueBall) {
      return Marker(
          markerId: MarkerId("IssueBall"+ballUuid),
          icon: _mapMakerDescriptorContainer
              .getBitmapDescriptor("IssueBallIcon"),
          position: LatLng(
              position.latitude, position.longitude),
          anchor: Offset(0.5, 0.5));
    }else {
      return throw Exception("not support Ball");
    }
  }
}