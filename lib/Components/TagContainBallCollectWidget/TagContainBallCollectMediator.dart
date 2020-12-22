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

    PageWrap<FBallResDto> changePage = new PageWrap(
      pageable: response.pageable,
      sort: response.sort,
      totalElements: response.totalElements,
      totalPages: response.totalPages,
      size: response.size,
      empty: response.empty,
      last: response.last,
      first: response.first,
      number: response.number,
      numberOfElements: response.numberOfElements,
      content: response.content.map((e) => e.ballUuid).toList()
    );

    return changePage;
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