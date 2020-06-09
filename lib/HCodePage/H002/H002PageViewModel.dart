import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';

import 'package:forutonafront/HCodePage/H002/H002_01/H002_01Page.dart';
import 'package:geolocator/geolocator.dart';
class H002PageViewModel extends ChangeNotifier {
  final BuildContext _context;
  H002PageViewModel(this._context);

  void goAddIssueBall() async{
    Position currentPosition;
    await GeoLocationUtilUseCase().useGpsReq(_context);
    currentPosition = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
    String address = await GeoLocationUtilUseCase().getPositionAddress(currentPosition);
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (_) => H002_01Page(currentPosition,address)
    ));
  }
}