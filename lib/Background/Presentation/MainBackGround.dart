import 'package:flutter/material.dart';
import 'package:forutonafront/Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Background/Domain/UseCase/BaseBackGroundUseCaseInputPort.dart';

abstract class MainBackGround {
  void startBackGroundService();

  void backGroundServiceLoop(String taskId);
}

class MainBackGroundImpl implements MainBackGround {

  final BackgroundUserPositionUseCaseInputPort
      _backgroundUserPositionUseCaseInputPort;

  final BackgroundFetchAdapter _backgroundFetchAdapter;

  MainBackGroundImpl(
      {@required
          BackgroundFetchAdapter backgroundFetchAdapter,
      @required
          BackgroundUserPositionUseCaseInputPort
              backgroundUserPositionUseCaseInputPort})
      : _backgroundFetchAdapter = backgroundFetchAdapter,
        _backgroundUserPositionUseCaseInputPort =
            backgroundUserPositionUseCaseInputPort;

  List<BaseBackGroundUseCaseInputPort> _baseBackGroundUseCaseInputPortList = [];

  @override
  void startBackGroundService() {
    _backgroundFetchAdapter.configWithLoopFuncRegister(backGroundServiceLoop);
    _addBackGroundUserCase(_backgroundUserPositionUseCaseInputPort);
  }

  void backGroundServiceLoop(String taskId) {
    _baseBackGroundUseCaseInputPortList.forEach((useCaseItem) {
      if (_isUseCaseTask(useCaseItem, taskId)) {
        _startBackGroundLoop(useCaseItem, taskId);
      }
    });
  }

  void _addBackGroundUserCase(BaseBackGroundUseCaseInputPort useCaseInputPort) {
    _baseBackGroundUseCaseInputPortList.add(useCaseInputPort);
    useCaseInputPort.startServiceSchedule();
  }

  bool _isUseCaseTask(
          BaseBackGroundUseCaseInputPort useCaseItem, String taskId) =>
      useCaseItem.getServiceTaskId == taskId;

  void _startBackGroundLoop(
      BaseBackGroundUseCaseInputPort backGroundService, String taskId) {
    try {
      backGroundService.loop();
    } catch (e) {
      throw e;
    } finally {
      _backgroundFetchAdapter.backgroundFetchFinish(taskId);
    }
  }
}
