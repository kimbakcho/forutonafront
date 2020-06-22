import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';

import 'package:forutonafront/HCodePage/H002/H002_01/H002_01Page.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:geolocator/geolocator.dart';
class H002PageViewModel extends ChangeNotifier {
  final BuildContext _context;
  H002PageViewModel(this._context);

  GeoLocationUtilUseCaseInputPort _geoLocationUtilUseCaseInputPort = sl();

  void goAddIssueBall() async{
    Position currentPosition;
    await _geoLocationUtilUseCaseInputPort.useGpsReq(_context);
    currentPosition = await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
    String address = await _geoLocationUtilUseCaseInputPort.getPositionAddress(currentPosition);
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (_) => H002_01Page(currentPosition,address)
    ));

  }
}