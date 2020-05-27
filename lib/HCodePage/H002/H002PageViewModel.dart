import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/HCodePage/H002/H002_01/H002_01Page.dart';
import 'package:geolocator/geolocator.dart';
class H002PageViewModel extends ChangeNotifier {
  final BuildContext _context;
  H002PageViewModel(this._context);

  void goAddIssueBall() async{
    Position currentPosition;
    await GeoLocationUtil().useGpsReq(_context);
    currentPosition = await GeoLocationUtil().getCurrentWithLastPosition();
    String address = await GeolocationRepository().getPositionAddress(currentPosition);
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (_) => H002_01Page(currentPosition,address)
    ));
  }
}