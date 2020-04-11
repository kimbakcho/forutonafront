import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class H007MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  Position _initPosition;


  String address;
  CameraPosition initCameraPosition;
  CameraPosition currentCameraPosition;


  Completer<GoogleMapController> _googleMapController = Completer();

  H007MainPageViewModel(this._initPosition, this.address,this._context){
    initCameraPosition = CameraPosition(
        target: LatLng(_initPosition.latitude,
        _initPosition.longitude),zoom: 14.4746);
    currentCameraPosition = initCameraPosition;
  }

  onMapCreate(GoogleMapController controller){
    _googleMapController.complete(controller);

  }
  onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;
    GeoLocationUtil.useGpsReq();
    var currentLocation = await Geolocator().getCurrentPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.4746)));
  }

  onCameraMove(CameraPosition value){
    currentCameraPosition = value;
  }

  //H001의 Search 메소드를 실행 시킴.
  onMapBallSearch(LatLng searchPosition) async{
    var h001ViewModel = Provider.of<H001ViewModel>(_context,listen: false);
    h001ViewModel.onFromH007Serach(searchPosition);
    Navigator.of(_context).pop();
  }
}