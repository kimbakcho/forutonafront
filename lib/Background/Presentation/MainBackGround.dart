import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Background/Domain/UseCase/BaseBackGroundUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;

abstract class MainBackGround {
  void startBackGroundService();

  List<BaseBackGroundUseCaseInputPort> _baseBackGroundUseCaseInputPortList;

  void _startBackGroundLoop(
      BaseBackGroundUseCaseInputPort backGroundService, String taskId);
}

class MainBackGroundImpl implements MainBackGround {
  final BackgroundFetchAdapter _backgroundFetchAdapter;

  List<BaseBackGroundUseCaseInputPort> _baseBackGroundUseCaseInputPortList = [];

  MainBackGroundImpl({@required BackgroundFetchAdapter backgroundFetchAdapter})
      : _backgroundFetchAdapter = backgroundFetchAdapter {
    print("Create MainBackGroundImpl");
    initServiceList();
  }

  void initServiceList() {
    final BackgroundUserPositionUseCaseInputPort
        _backgroundUserPositionUseCaseInputPort = sl();
    _baseBackGroundUseCaseInputPortList
        .add(_backgroundUserPositionUseCaseInputPort);
  }

  @override
  void startBackGroundService() {
    _backgroundFetchAdapter.registerHeadlessTask(headlessBackGroundServiceLoop);
    _backgroundFetchAdapter.configWithLoopFuncRegister(backGroundServiceLoop);
    _baseBackGroundUseCaseInputPortList.forEach((element) {
      element.startServiceSchedule();
    });
  }

  static void headlessBackGroundServiceLoop(String taskId) {
    print("headlessBackGroundServiceLoop");
    initServiceLocator();
    MainBackGround mainBackGround = sl();
    mainBackGround._baseBackGroundUseCaseInputPortList.forEach((useCaseItem) {
      if (_isUseCaseTask(useCaseItem, taskId)) {
        mainBackGround._startBackGroundLoop(useCaseItem, taskId);
      }
    });
  }

  static void initServiceLocator() {
    MainBackGround mainBackGround;
    try {
      mainBackGround = sl();
    } catch (ex) {
      di.init();
      mainBackGround = sl();
    }
  }

  void backGroundServiceLoop(String taskId) {
    print("backGroundServiceLoop");
    _baseBackGroundUseCaseInputPortList.forEach((useCaseItem) {
      if (_isUseCaseTask(useCaseItem, taskId)) {
        _startBackGroundLoop(useCaseItem, taskId);
      }
    });
  }


  static bool _isUseCaseTask(
          BaseBackGroundUseCaseInputPort useCaseItem, String taskId) =>
      useCaseItem.getServiceTaskId == taskId;

  void _startBackGroundLoop(
      BaseBackGroundUseCaseInputPort backGroundService, String taskId) {
    try {
      backGroundService.loop();
    } catch (e) {
      throw e;
    } finally {
      print(taskId + "FINISH");
      _backgroundFetchAdapter.backgroundFetchFinish(taskId);
    }
  }
}
