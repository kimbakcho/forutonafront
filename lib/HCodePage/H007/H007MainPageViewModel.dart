import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';


import 'package:forutonafront/MapGeoPage/MapGeoSearchPage.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class H007MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  Position _initPosition;
  bool _flagIdleIgnore = true;

  String address;
  CameraPosition initCameraPosition;
  CameraPosition currentCameraPosition;

  Completer<GoogleMapController> _googleMapController = Completer();

  H007MainPageViewModel(this._initPosition, this.address, this._context) {
    initCameraPosition = CameraPosition(
        target: LatLng(_initPosition.latitude, _initPosition.longitude),
        zoom: 14.4746);
    currentCameraPosition = initCameraPosition;
  }

  ///Return 으로는 MapSearchGeoDto 받는다.
  onPlaceSearchTap() async {
    MapSearchGeoDto mapSearchGeoDto = await Navigator.of(_context).push(MaterialPageRoute(
        settings: RouteSettings(name: "MapGeoSearchPage"),
        builder: (_) => MapGeoSearchPage(
            address,
            Position(
                latitude: currentCameraPosition.target.latitude,
                longitude: currentCameraPosition.target.longitude))));
    if(mapSearchGeoDto != null){
      Navigator.of(_context).pop(mapSearchGeoDto);
    }
  }

  onMapCreate(GoogleMapController controller) async {
    _flagIdleIgnore = true;
    _googleMapController.complete(controller);
    await controller.moveCamera(CameraUpdate.newCameraPosition(initCameraPosition));
    _flagIdleIgnore = false;
  }

  onMapIdle() async {
    if (!_flagIdleIgnore) {

      this.address = await GeoLocationUtilUseCase().getPositionAddress(Position(
          latitude: currentCameraPosition.target.latitude,
          longitude: currentCameraPosition.target.longitude));
      notifyListeners();
    }

  }

  onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;

    await GeoLocationUtilUseCase().useGpsReq(_context);
    var currentLocation = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
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
    Navigator.of(_context).pop(mapSearchGeoDto);
  }

  onBackBtnClick() {
    Navigator.of(_context).pop();
  }
}
