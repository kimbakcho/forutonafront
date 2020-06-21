import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';

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
  }

  void startBackGroundService() {
    MainBackGround mainBackGround = sl();
    mainBackGround.startBackGroundService();
    BackgroundUserPositionUseCaseInputPort backgroundUserPositionUseCaseInputPort = sl();
    mainBackGround.addBackGroundUserCase(backgroundUserPositionUseCaseInputPort);
  }
}