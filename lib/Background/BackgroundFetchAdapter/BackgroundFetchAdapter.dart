import 'package:background_fetch/background_fetch.dart';

//cmd jobscheduler run -f co.kr.forutonafront 999

class BackgroundFetchAdapter {
  configWithLoopFuncRegister(Function(String taskid) serviceLoop){
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      startOnBoot: true,
      enableHeadless:true,
      stopOnTerminate: false,
      requiredNetworkType:NetworkType.ANY,
    ), (String taskId) async {
      serviceLoop(taskId);
    });
  }
  backgroundFetchFinish(String taskId){
    BackgroundFetch.finish(taskId);
  }
}