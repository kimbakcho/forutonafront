abstract class BaseBackGroundUseCaseInputPort {
  void startServiceSchedule();
  Future<void>   loop();
  String getServiceTaskId;
}