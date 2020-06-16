import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';

import 'BaseBackGroundService.dart';

abstract class UserPositionSendService extends BaseBackGroundService {}

class UserPositionSendServiceImpl implements UserPositionSendService {
  String _userPositionServiceTaskId =
      'com.wing.forutonafront.UserPositionService';
  GeoLocationUtilUseCaseInputPort geoLocationUtilUseCaseInputPort;

  UserPositionSendServiceImpl(
      {@required
          this.geoLocationUtilUseCaseInputPort});

  @override
  void startServiceSchedule() {
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: _userPositionServiceTaskId,
        delay: 5000, // milliseconds
        forceAlarmManager: true,
        enableHeadless: true,
        requiredNetworkType: NetworkType.ANY,
        startOnBoot: true,
        stopOnTerminate: false,
        periodic: true));
  }

  @override
  void  loop() async {
    print("UserPositionSendService loop");
    await geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
  }

  @override
  String getUserPositionServiceTaskId() {
    return _userPositionServiceTaskId;
  }
}
