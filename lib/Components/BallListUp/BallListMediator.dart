import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'package:injectable/injectable.dart';


abstract class BallListMediator<T> extends SearchCollectMediator<FBallResDto>{

  T fBallListUpUseCaseInputPort;

  hideBall(String ballUuid);

  Position searchPosition();

}

class BallListMediatorImpl extends BallListMediator<FBallListUpUseCaseInputPort> {

  @override
  Future<PageWrap<FBallResDto>> searchUseCase(Pageable pageable) async {
    return await this
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
