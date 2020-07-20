import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

import 'Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'ServiceLocator/ServiceLocator.dart';

class MainModel with ChangeNotifier {

  final FireBaseMessageController _fireBaseMessageController;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final FlutterLocalNotificationsPluginAdapter
      _flutterLocalNotificationsPluginAdapter;
  final UserPositionForegroundMonitoringUseCaseInputPort
      _userPositionForegroundMonitoringUseCaseInputPort;
  final GeoLocationUtilBasicUseCaseInputPort
      _geoLocationUtilBasicUseCaseInputPort;

  MainModel(
      {
      @required
          FireBaseMessageController fireBaseMessageController,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter,
      @required
          UserPositionForegroundMonitoringUseCaseInputPort
              userPositionForegroundMonitoringUseCaseInputPort,
      @required
          GeoLocationUtilBasicUseCaseInputPort
              geoLocationUtilBasicUseCaseInputPort})
      : _fireBaseMessageController = fireBaseMessageController,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter,
        _userPositionForegroundMonitoringUseCaseInputPort =
            userPositionForegroundMonitoringUseCaseInputPort,
        _geoLocationUtilBasicUseCaseInputPort =
            geoLocationUtilBasicUseCaseInputPort {
    _fireBaseMessageController.controllerStartService();
    _fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
    _flutterLocalNotificationsPluginAdapter.init();
    _userPositionForegroundMonitoringUseCaseInputPort
        .startUserPositionMonitoringAndUpdateToServer();
    _geoLocationUtilBasicUseCaseInputPort.startStreamCurrentPosition();

    //test

  }
}
