import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserPositionForegroundMonitoringUseCaseInputPort)
class UserPositionForegroundMonitoringUseCase
    implements UserPositionForegroundMonitoringUseCaseInputPort {
  final GeoLocationUtilBasicUseCaseInputPort
      _geoLocationUtilBasicUseCaseInputPort;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  final UpdateUserPositionUseCaseInputPort _updateUserPositionUseCaseInputPort;

  UserPositionForegroundMonitoringUseCase(
      {required GeoLocationUtilBasicUseCaseInputPort
          geoLocationUtilBasicUseCaseInputPort,
      required FUserRepository fUserRepository,
      required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      required UpdateUserPositionUseCaseInputPort
          updateUserPositionUseCaseInputPort})
      : _geoLocationUtilBasicUseCaseInputPort =
            geoLocationUtilBasicUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _updateUserPositionUseCaseInputPort =
            updateUserPositionUseCaseInputPort;

  StreamSubscription? _userPositionStream;

  @override
  startUserPositionMonitoringAndUpdateToServer() {
    _userPositionStream = _geoLocationUtilBasicUseCaseInputPort
        .getUserPositionStream()
        .listen(_userPositionStreamFunc);
  }

  _userPositionStreamFunc(Position position) async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      print("_userPositionStreamFunc");
      _updateUserPositionUseCaseInputPort
          .updateUserPosition(LatLng(position.latitude!, position.longitude!));
    }
  }

  @override
  stopMonitoring() {
    _userPositionStream!.cancel();
  }
}
