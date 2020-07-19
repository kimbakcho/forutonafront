import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';

import 'package:forutonafront/HCodePage/H002/H002_01/H002_01Page.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class H002PageViewModel extends ChangeNotifier {
  final BuildContext context;
  final GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  get isLoading {
    return _isLoading;
  }

  H002PageViewModel({
    @required this.context,
    @required GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort
  }) : _geoLocationUtilUseCaseInputPort =geoLocationUtilUseCaseInputPort ;



  void goAddIssueBall() async{
    isLoading = true;
    Position currentPosition;
    await _geoLocationUtilUseCaseInputPort.useGpsReq();
    currentPosition = await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
    String address = await _geoLocationUtilUseCaseInputPort.getPositionAddress(currentPosition);
    isLoading = false;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => H002_01Page(currentPosition,address)
    ));

  }
}