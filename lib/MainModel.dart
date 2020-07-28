import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';

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

  MainModel(
      {
      @required
          FireBaseMessageController fireBaseMessageController,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter })
      : _fireBaseMessageController = fireBaseMessageController,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter
{
    _fireBaseMessageController.controllerStartService();
    _fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
    _flutterLocalNotificationsPluginAdapter.init();



    //test

  }
}
