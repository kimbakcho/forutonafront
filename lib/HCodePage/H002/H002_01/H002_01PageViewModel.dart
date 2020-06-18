import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';

import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/MapGeoPage/MapGeoSearchPage.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class H002_01PageViewModel extends ChangeNotifier {
  final BuildContext _context;

  String address;
  CameraPosition initCameraPosition;
  CameraPosition currentCameraPosition;
  bool isBallPinUp = false;
  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  Position _initPosition;
  Completer<GoogleMapController> _googleMapController = Completer();

  H002_01PageViewModel(this._initPosition, this.address, this._context) {
    initCameraPosition = CameraPosition(
        target: LatLng(_initPosition.latitude, _initPosition.longitude),
        zoom: 14.4746);
    currentCameraPosition = initCameraPosition;
    FlutterStatusbarcolor.setStatusBarColor(Colors.white.withOpacity(0), animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }

  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    await controller
        .moveCamera(CameraUpdate.newCameraPosition(initCameraPosition));
  }

  void onMoveMap(CameraPosition position) {
    currentCameraPosition = position;
  }

  void onMoveStartMap() {
    isBallPinUp = true;
    notifyListeners();
  }

  void onMapIdle() async{

    _setIsLoading(true);
      this.address = await GeoLocationUtilUseCase().getPositionAddress(Position(
          latitude: currentCameraPosition.target.latitude,
          longitude: currentCameraPosition.target.longitude));
      isBallPinUp = false;
      notifyListeners();
    _setIsLoading(false);
  }

  void onBackBtnClick() {
    Navigator.of(_context).pop();
  }

  void onPlaceSearchTap() async {
    final GoogleMapController controller = await _googleMapController.future;
    MapSearchGeoDto mapSearchGeoDto = await Navigator.of(_context).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "MapGeoSearchPage"),
            builder: (_) => MapGeoSearchPage(
                address,
                Position(
                    latitude: currentCameraPosition.target.latitude,
                    longitude: currentCameraPosition.target.longitude))));
    if(mapSearchGeoDto != null ){
      await controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: mapSearchGeoDto.latLng, zoom: 14.4746)));
    }
    notifyListeners();
  }

  void onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;
    await GeoLocationUtilUseCase().useGpsReq(_context);
    var currentLocation = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.4746)));
  }

  void onMapBallAdd(LatLng target,String address) {
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (_)=>IM001MainPage(target,address,null,IM001MainPageEnterMode.Insert),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
}
