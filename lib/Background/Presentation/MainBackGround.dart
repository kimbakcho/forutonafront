import 'package:flutter/material.dart';
import 'package:forutonafront/Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'package:forutonafront/Background/Domain/UseCase/BaseBackGroundUseCase.dart';

abstract class MainBackGround {
  void startBackGroundService();

  void addBackGroundUserCase(BaseBackGroundUseCaseInputPort useCaseInputPort);

  void backGroundServiceLoop(String taskId);
}

class MainBackGroundImpl implements MainBackGround {

  BackgroundFetchAdapter backgroundFetchAdapter;
  MainBackGroundImpl({@required this.backgroundFetchAdapter})
      : assert(backgroundFetchAdapter != null);
  List<BaseBackGroundUseCaseInputPort> baseBackGroundUseCaseInputPortList = [];

  @override
  void startBackGroundService() {
    backgroundFetchAdapter.configWithLoopFuncRegister(backGroundServiceLoop);
  }

  void backGroundServiceLoop(String taskId) {
    baseBackGroundUseCaseInputPortList.forEach((useCaseItem) {
      if (isUseCaseTask(useCaseItem, taskId)) {
        startBackGroundLoop(useCaseItem, taskId);
      }
    });
  }

  @override
  void addBackGroundUserCase(BaseBackGroundUseCaseInputPort useCaseInputPort) {
    baseBackGroundUseCaseInputPortList.add(useCaseInputPort);
    useCaseInputPort.startServiceSchedule();
  }

  bool isUseCaseTask(
          BaseBackGroundUseCaseInputPort useCaseItem, String taskId) =>
      useCaseItem.getServiceTaskId == taskId;

  void startBackGroundLoop(
      BaseBackGroundUseCaseInputPort backGroundService, String taskId) {
    try {
      backGroundService.loop();
    } catch (e) {
      throw e;
    } finally {
      backgroundFetchAdapter.backgroundFetchFinish(taskId);
    }
  }



}
