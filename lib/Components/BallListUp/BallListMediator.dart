import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

enum BallListMediatorState {
  Empty,HasBall,Error
}


abstract class BallListMediator extends SearchCollectMediator<FBallResDto>{

  FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort;

  hideBall(String ballUuid);

  Position searchPosition();

}

@Injectable(as: BallListMediator)
class BallListMediatorImpl extends BallListMediator {

  @override
  Future<void> searchUseCase(Pageable pageable) async {
    this.wrapItemList = await this
        .fBallListUpUseCaseInputPort
        .search(pageable);
  }

  @override
  bool isNullSearchUseCase(){
    if(fBallListUpUseCaseInputPort == null) {
      return true;
    }else {
      return false;
    }
  }

  @override
  Position searchPosition(){
    if(fBallListUpUseCaseInputPort != null){
      return fBallListUpUseCaseInputPort.searchPosition;
    }else {
      return null;
    }
  }

  @override
  hideBall(String ballUuid) {
    this.itemList.removeWhere((element) => element.ballUuid == ballUuid);
    onPageListUpdate();
  }


}
