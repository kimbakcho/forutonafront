import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'Background/Presentation/MainBackGround.dart';

class MainModel with ChangeNotifier {
  final BuildContext _context;
  MainModel(this._context){
    init();
  }
  init() async {
    GlobalModel globalModel = Provider.of(_context);
    globalModel.setFUserInfoDto();
    startBackGroundService();
    startFireBaseMessageService();
    startFireBaseAuthAdapterForUseCaseService();
  }

  void startBackGroundService() {
    MainBackGround mainBackGround = sl();
    mainBackGround.startBackGroundService();
    BackgroundUserPositionUseCaseInputPort backgroundUserPositionUseCaseInputPort = sl();
    mainBackGround.addBackGroundUserCase(backgroundUserPositionUseCaseInputPort);
  }

  void startFireBaseMessageService() {
    FireBaseMessageController fireBaseMessageController = sl();
    fireBaseMessageController.controllerStartService();
  }

  void startFireBaseAuthAdapterForUseCaseService(){
    FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase = sl();
    fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
  }

}