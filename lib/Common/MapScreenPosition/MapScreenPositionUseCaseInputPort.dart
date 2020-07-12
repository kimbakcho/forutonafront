import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapScreenPositionUseCaseInputPort {
  Future<LatLng> mapScreenOffsetToLatLng(RenderBox mapRenderBoxRed,
      GoogleMapController controller, double offsetX, double offsetY);
  Future<Point> mapLatLngToScreenOffset(RenderBox mapRenderBoxRed,
      GoogleMapController controller,
      LatLng latLng,
      double widgetWidth,
      double widgetHeight);
}
