import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/HCodePage/H008/PlaceListFromSearchTextWidget.dart';
import 'package:forutonafront/MapGeoPage/MapGeoSearchPage.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class H007MainPageViewModel extends ChangeNotifier
    implements PlaceListFromSearchTextWidgetListener {
  final BuildContext context;

  Position initPosition;

  String address;
  CameraPosition initCameraPosition;
  CameraPosition currentCameraPosition;
  bool cameraMoveFlag = false;

  Completer<GoogleMapController> _googleMapController = Completer();
  GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;
  H007Listener h007listener;

  H007MainPageViewModel(
      {this.initPosition,
      this.address,
      this.context,
      this.h007listener,
      GeoLocationUtilForeGroundUseCaseInputPort
          geoLocationUtilUseCaseInputPort})
      : _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    initCameraPosition = CameraPosition(
        target: LatLng(initPosition.latitude, initPosition.longitude),
        zoom: 14.4746);
    currentCameraPosition = initCameraPosition;
  }

  onSearch() {
    if(this.h007listener != null ){
      this.h007listener.onH007SearchPosition(
          Position(
              longitude: currentCameraPosition.target.longitude,
              latitude: currentCameraPosition.target.latitude),context);
    }
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
    _googleMapController.complete(controller);
    await controller
        .moveCamera(CameraUpdate.newCameraPosition(initCameraPosition));
  }

  onMapIdle() async {
    this.address = await _geoLocationUtilUseCaseInputPort.getPositionAddress(
        Position(
            latitude: currentCameraPosition.target.latitude,
            longitude: currentCameraPosition.target.longitude));
    notifyListeners();
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
    cameraMoveFlag = true;
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

  //FROM H008
  @override
  onPlaceListTabPosition(Position position ) async {
    Navigator.popUntil(context, (route) => route.settings.name == "H007");
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14.4746)));
    notifyListeners();
  }
}
