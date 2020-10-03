import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

enum BallMarkerSize { Small, Normal }

@LazySingleton()
class MapBallMarkerFactory {
  final MapMakerDescriptorContainer _mapMakerDescriptorContainer;

  MapBallMarkerFactory(
      {@required MapMakerDescriptorContainer mapMakerDescriptorContainer})
      : _mapMakerDescriptorContainer = mapMakerDescriptorContainer;

  // ignore: missing_return
  Marker getBallMaker(FBallType fBallType, String ballUuid, Position position,
      {Function onTap,
      bool select = false,
      BallMarkerSize ballMarkerSize = BallMarkerSize.Normal}) {
    if (fBallType == FBallType.IssueBall) {
      if (!select) {
        if (ballMarkerSize == BallMarkerSize.Normal) {
          return Marker(
              markerId: MarkerId("IssueBall" + ballUuid),
              icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
                  MapMakerDescriptorType.IssueBallIconUnSelectNormal),
              onTap: onTap,
              zIndex: 0,
              position: LatLng(position.latitude, position.longitude),
              anchor: Offset(0.5, 0.5));
        } else if (ballMarkerSize == BallMarkerSize.Small) {
          return Marker(
              markerId: MarkerId("IssueBall" + ballUuid),
              icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
                  MapMakerDescriptorType.IssueBallIconUnSelectSmall),
              onTap: onTap,
              zIndex: 0,
              position: LatLng(position.latitude, position.longitude),
              anchor: Offset(0.5, 0.5));
        }
      } else {
        if (ballMarkerSize == BallMarkerSize.Normal) {
          return Marker(
              markerId: MarkerId("IssueBall" + ballUuid),
              icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
                  MapMakerDescriptorType.IssueBallIconSelectNormal),
              onTap: onTap,
              zIndex: 1,
              position: LatLng(position.latitude, position.longitude),
              anchor: Offset(0.5, 0.5));
        } else if (ballMarkerSize == BallMarkerSize.Small) {
          return Marker(
              markerId: MarkerId("IssueBall" + ballUuid),
              icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
                  MapMakerDescriptorType.IssueBallIconSelectSmall),
              onTap: onTap,
              zIndex: 1,
              position: LatLng(position.latitude, position.longitude),
              anchor: Offset(0.5, 0.5));
        }
      }
    } else {
      return throw Exception("not support Ball");
    }
  }
}
