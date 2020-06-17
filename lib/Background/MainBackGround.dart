import 'package:background_fetch/background_fetch.dart';
import 'package:forutonafront/Background/BaseBackGroundService.dart';
import 'package:forutonafront/Background/UserPositionSendService.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';

abstract class MainBackGround {
  void startBackGroundService();
  void startUserPositionSendService();
}
class MainBackGroundImpl implements MainBackGround{

  UserPositionSendService _userPositionSendService;

  @override
  void startBackGroundService() {
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      startOnBoot: true,
        enableHeadless:true,
      stopOnTerminate: false,
      requiredNetworkType:NetworkType.ANY,
    ), (String taskId) async {
      _backGroundServiceLoop(taskId);
    });
  }

  void _backGroundServiceLoop(String taskId) {
    initInstance();
    BaseBackGroundService backGroundService;
    if(_userPositionSendService.getUserPositionServiceTaskId() == taskId){
      backGroundService = _userPositionSendService;
    }
    try{
      if(hasService(backGroundService))
        backGroundService.loop();
    }catch (e){
      throw e;
    }finally{
      BackgroundFetch.finish(taskId);
    }
  }
  void initInstance() {
    _createInstanceUserPositionSendService();

  }
  void _createInstanceUserPositionSendService() {
    if(_userPositionSendService == null){
      _userPositionSendService = UserPositionSendServiceImpl(
          geoLocationUtilUseCaseInputPort: GeoLocationUtilUseCase()
      );
    }
  }


  @override
  void startUserPositionSendService() {
    _createInstanceUserPositionSendService();
    _userPositionSendService.startServiceSchedule();
  }

  bool hasService(BaseBackGroundService backGroundService) {
    return backGroundService != null;
  }




}