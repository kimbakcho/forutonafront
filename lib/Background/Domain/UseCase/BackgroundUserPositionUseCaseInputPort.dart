import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FireBaseAdapter/FireBaseAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'BaseBackGroundUseCase.dart';

abstract class BackgroundUserPositionUseCaseInputPort
    extends BaseBackGroundUseCaseInputPort {}

class BackgroundUserPositionUseCase
    implements BackgroundUserPositionUseCaseInputPort {
  String getServiceTaskId = 'com.wing.forutonafront.UserPositionService';

  GeoLocationUtilUseCaseInputPort geoLocationUtilUseCaseInputPort;

  FUserRepository fUserRepository;

  FireBaseAdapter fireBaseAdapter;

  BackgroundUserPositionUseCase(
      {@required this.geoLocationUtilUseCaseInputPort,
      @required this.fUserRepository,
      @required this.fireBaseAdapter})
      : assert(geoLocationUtilUseCaseInputPort != null),
        assert(fUserRepository != null),
        assert(fireBaseAdapter != null);

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
    if(await fireBaseAdapter.isLogin()){
      var position =
      await geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
      fUserRepository
          .updateUserPosition(LatLng(position.latitude, position.longitude));
    }
  }
}
