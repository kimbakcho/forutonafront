import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagItemListUpUseCase.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';

class TagContainBallCollectMediator extends BallListMediator<TagItemListUpUseCaseInputPort>{

  TagContainBallCollectMediator(){
    pageLimit =5;
  }

  @override
  Future<PageWrap<FBallResDto>> searchUseCase(Pageable pageable) async {

    PageWrap<FBallTagResDto> response = await this
        .fBallListUpUseCaseInputPort
        .search(pageable);

    var content = response.content;
    //TODO 추후에 여기서 BALL들을 조회 하는 API를 BackEnd 에서 만들고 가져와서 리턴해주기 지금은 임시로 null 로 리턴

    return null;
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