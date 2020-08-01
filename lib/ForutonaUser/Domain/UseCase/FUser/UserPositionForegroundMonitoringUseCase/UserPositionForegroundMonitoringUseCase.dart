import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserPositionForegroundMonitoringUseCase
    implements UserPositionForegroundMonitoringUseCaseInputPort {
  final GeoLocationUtilBasicUseCaseInputPort
      _geoLocationUtilBasicUseCaseInputPort;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  UserPositionForegroundMonitoringUseCase(
      {@required
          GeoLocationUtilBasicUseCaseInputPort
              geoLocationUtilBasicUseCaseInputPort,
      @required
          FUserRepository fUserRepository,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
        SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort
      })
      : _geoLocationUtilBasicUseCaseInputPort =
            geoLocationUtilBasicUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort;


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
      FUserInfo fUserInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      fUserInfo.updateUserPosition(LatLng(position.latitude,position.longitude));
    }
  }

  @override
  stopMonitoring() {
    _userPositionStream.cancel();
  }
}
