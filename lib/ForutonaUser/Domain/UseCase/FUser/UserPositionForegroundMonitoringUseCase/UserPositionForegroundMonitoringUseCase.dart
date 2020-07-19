import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserPositionForegroundMonitoringUseCase
    implements UserPositionForegroundMonitoringUseCaseInputPort {
  final GeoLocationUtilBasicUseCaseInputPort
      _geoLocationUtilBasicUseCaseInputPort;
  final FUserRepository _fUserRepository;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  UserPositionForegroundMonitoringUseCase(
      {@required
          GeoLocationUtilBasicUseCaseInputPort
              geoLocationUtilBasicUseCaseInputPort,
      @required
          FUserRepository fUserRepository,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _geoLocationUtilBasicUseCaseInputPort =
            geoLocationUtilBasicUseCaseInputPort,
        _fUserRepository = fUserRepository,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  StreamSubscription _userPositionStream;

  @override
  startUserPositionMonitoringAndUpdateToServer() {
    _userPositionStream = _geoLocationUtilBasicUseCaseInputPort
        .getUserPositionStream()
        .listen(_userPositionStreamFunc);
  }

  _userPositionStreamFunc(Position position) async {
    if(await _fireBaseAuthAdapterForUseCase.isLogin()){
      print("_userPositionStreamFunc");
      await _fUserRepository.updateUserPosition(LatLng(position.latitude,position.longitude));
    }
  }

  @override
  stopMonitoring() {
    _userPositionStream.cancel();
  }
}
