import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/HCodePage/H002/H002_01/H002_01Page.dart';
import 'package:geolocator/geolocator.dart';
class H002PageViewModel extends ChangeNotifier {
  final BuildContext _context;
  H002PageViewModel(this._context);

  void goAddIssueBall() async{
    GeoLocationUtil _geoLocationUtil =new GeoLocationUtil();
    _geoLocationUtil.useGpsReq();
    Geolocator _geoLocator = new Geolocator();
    Position currentPosition;
    if(await _geoLocator.isLocationServiceEnabled()){
      currentPosition = await  Geolocator().getCurrentPosition();
    }else {
      _geoLocationUtil.useGpsReq();
    }



    String address = await GeolocationRepository().getPositionAddress(currentPosition);
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (_) => H002_01Page(currentPosition,address)
    ));
  }
}