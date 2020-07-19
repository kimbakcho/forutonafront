import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';

import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'BaseBackGroundUseCaseInputPort.dart';

abstract class BackgroundUserPositionUseCaseInputPort
    extends BaseBackGroundUseCaseInputPort {}

class BackgroundUserPositionUseCase
    implements BackgroundUserPositionUseCaseInputPort {

  String getServiceTaskId = 'com.wing.forutonafront.UserPositionService';

  final GeoLocationUtilBasicUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  final FUserRepository _fUserRepository;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  BackgroundUserPositionUseCase(
      {@required GeoLocationUtilBasicUseCaseInputPort geoLocationUtilUseCaseInputPort,
      @required FUserRepository fUserRepository,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort,
        _fUserRepository = fUserRepository,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  void startServiceSchedule() {
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: getServiceTaskId,
        delay: 5000,
        // milliseconds
        forceAlarmManager: true,
        enableHeadless: true,
        requiredNetworkType: NetworkType.ANY,
        startOnBoot: true,
        stopOnTerminate: false,
        periodic: true));
  }

  @override
  Future<void> loop() async {
    print("UserPositionSendService loop");
    if(await _fireBaseAuthAdapterForUseCase.isLogin()){
      var position =
      await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
      _fUserRepository
          .updateUserPosition(LatLng(position.latitude, position.longitude));
    }
  }

}
