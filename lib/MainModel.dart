import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Notification/MessageChanel/Domain/MessageChanelUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'Background/Presentation/MainBackGround.dart';
import 'Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';

class MainModel with ChangeNotifier {
  final MainBackGround _mainBackGround;
  final FireBaseMessageController _fireBaseMessageController;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final FlutterLocalNotificationsPluginAdapter
      _flutterLocalNotificationsPluginAdapter;

  MainModel(
      {@required
          MainBackGround mainBackGround,
      @required
          FireBaseMessageController fireBaseMessageController,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter})
      : _mainBackGround = mainBackGround,
        _fireBaseMessageController = fireBaseMessageController,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter {
    _mainBackGround.startBackGroundService();
    _fireBaseMessageController.controllerStartService();
    _fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
    _flutterLocalNotificationsPluginAdapter.init();

  }
}
