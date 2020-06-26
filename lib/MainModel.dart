import 'package:flutter/material.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/GlobalModel.dart';

import 'Background/Presentation/MainBackGround.dart';

class MainModel with ChangeNotifier {
  final MainBackGround _mainBackGround;
  final FireBaseMessageController _fireBaseMessageController;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final GlobalModel _globalModel;

  MainModel(
      {@required MainBackGround mainBackGround,
      @required FireBaseMessageController fireBaseMessageController,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required GlobalModel globalModel})
      : _mainBackGround = mainBackGround,
        _fireBaseMessageController = fireBaseMessageController,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _globalModel = globalModel {

    _globalModel.setFUserInfoDto();
    _mainBackGround.startBackGroundService();
    _fireBaseMessageController.controllerStartService();
    _fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
  }
}
