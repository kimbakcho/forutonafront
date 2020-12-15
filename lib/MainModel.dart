import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';

class MainModel with ChangeNotifier {
  final FireBaseMessageController _fireBaseMessageController;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final FlutterLocalNotificationsPluginAdapter
      _flutterLocalNotificationsPluginAdapter;
  final MapMakerDescriptorContainer _mapMakerDescriptorContainer;

  MainModel(
      {@required
          FireBaseMessageController fireBaseMessageController,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter,
      @required
          MapMakerDescriptorContainer mapMakerDescriptorContainer})
      : _fireBaseMessageController = fireBaseMessageController,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter,
        _mapMakerDescriptorContainer = mapMakerDescriptorContainer {
    _fireBaseMessageController.controllerStartService();
    _fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
    _flutterLocalNotificationsPluginAdapter.init();
    _mapMakerDescriptorContainer.init();
  }
}
