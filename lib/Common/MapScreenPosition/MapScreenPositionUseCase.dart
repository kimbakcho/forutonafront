import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class MapScreenPositionUseCase implements MapScreenPositionUseCaseInputPort {
  @override
  Future<LatLng> mapScreenOffsetToLatLng(RenderBox mapRenderBoxRed,
      GoogleMapController controller, double offsetX, double offsetY) async {
    //지도를 그리는 Box Size
    Size size = mapRenderBoxRed.size;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate southwestPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.southwest.latitude,
            visibleRegion.southwest.longitude));

    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate northeastPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.northeast.latitude,
            visibleRegion.northeast.longitude));

    //위젯의 스케일 받기
    var yScale = southwestPoint.y / mapRenderBoxRed.size.height;
    var xScale = northeastPoint.x / mapRenderBoxRed.size.width;

    return await controller.getLatLng(ScreenCoordinate(
        x: (offsetX * xScale).toInt(), y: (offsetY * yScale).toInt()));
  }

  @override
  Future<Point> mapLatLngToScreenOffset(
      RenderBox mapRenderBoxRed,
      GoogleMapController controller,
      LatLng latLng,
      double widgetWidth,
      double widgetHeight) async {
    ScreenCoordinate screenCoordinate = await controller
        .getScreenCoordinate(LatLng(latLng.latitude, latLng.longitude));
    //지도를 그리는 Box Size
    Size size = mapRenderBoxRed.size;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate southwestPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.southwest.latitude,
            visibleRegion.southwest.longitude));

    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate northeastPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.northeast.latitude,
            visibleRegion.northeast.longitude));

    //위젯의 스케일 받기
    var yScale = southwestPoint.y / mapRenderBoxRed.size.height;
    var xScale = northeastPoint.x / mapRenderBoxRed.size.width;
    double offsetX = screenCoordinate.x / xScale;
    offsetX -= (widgetWidth / 2);
    double offsetY = screenCoordinate.y / yScale;
    offsetY -= (widgetHeight / 2);
    return Point(offsetX, offsetY);
  }
}
