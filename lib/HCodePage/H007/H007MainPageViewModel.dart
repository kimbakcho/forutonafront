import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/MapGeoPage/MapGeoSearchPage.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class H007MainPageViewModel extends ChangeNotifier {
  final BuildContext context;
  Position initPosition;
  bool flagIdleIgnore = true;

  String address;
  CameraPosition initCameraPosition;
  CameraPosition currentCameraPosition;

  Completer<GoogleMapController> _googleMapController = Completer();
  GeoLocationUtilUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  H007MainPageViewModel(
      {this.initPosition,
      this.address,
      this.context,
      GeoLocationUtilUseCaseInputPort geoLocationUtilUseCaseInputPort})
      : _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    initCameraPosition = CameraPosition(
        target: LatLng(initPosition.latitude, initPosition.longitude),
        zoom: 14.4746);
    currentCameraPosition = initCameraPosition;
  }

  onPlaceSearchTap() async {
    MapSearchGeoDto mapSearchGeoDto = await Navigator.of(context).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "MapGeoSearchPage"),
            builder: (_) => MapGeoSearchPage(
                address,
                Position(
                    latitude: currentCameraPosition.target.latitude,
                    longitude: currentCameraPosition.target.longitude))));
    if (mapSearchGeoDto != null) {
      Navigator.of(context).pop(mapSearchGeoDto);
    }
  }

  onMapCreate(GoogleMapController controller) async {
    flagIdleIgnore = true;
    _googleMapController.complete(controller);
    await controller
        .moveCamera(CameraUpdate.newCameraPosition(initCameraPosition));
    flagIdleIgnore = false;
  }

  onMapIdle() async {
    if (!flagIdleIgnore) {
      this.address = await _geoLocationUtilUseCaseInputPort.getPositionAddress(
          Position(
              latitude: currentCameraPosition.target.latitude,
              longitude: currentCameraPosition.target.longitude));
      notifyListeners();
    }
  }

  onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;
    await _geoLocationUtilUseCaseInputPort.useGpsReq();
    var currentLocation =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.4746)));
  }

  onCameraMove(CameraPosition value) {
    currentCameraPosition = value;
  }

  //H001로 검색한 Position을 Latlng으로 넘겨줌 그러면 H001에서 검색함
  onMapBallSearch(LatLng searchPosition) {
    MapSearchGeoDto mapSearchGeoDto = MapSearchGeoDto();
    mapSearchGeoDto.latLng = searchPosition;
    mapSearchGeoDto.address = address;
    mapSearchGeoDto.descriptionAddress = address;
    Navigator.of(context).pop(mapSearchGeoDto);
  }

  onBackBtnClick() {
    Navigator.of(context).pop();
  }
}
