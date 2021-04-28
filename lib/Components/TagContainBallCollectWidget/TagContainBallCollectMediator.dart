import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';

import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagItemListUpUseCase.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';

class TagContainBallCollectMediator extends BallListMediator<TagItemListUpUseCaseInputPort>{

  final SelectBallUseCaseInputPort? _selectBallUseCaseInputPort;

  TagContainBallCollectMediator(this._selectBallUseCaseInputPort){
    pageLimit =5;
  }

  @override
  Future<PageWrap<FBallResDto>> searchUseCase(Pageable pageable) async {

    PageWrap<FBallTagResDto> response = await this
        .fBallListUpUseCaseInputPort!
        .search(pageable);

    var ballUuidList = response.content!.map((e) => e.ballUuid).toList().cast<String>();

    var fBallResDtoList = await this._selectBallUseCaseInputPort!.selectBalls(ballUuidList);
    PageWrap<FBallResDto> ballsResponse2 = PageWrap<FBallResDto>(
      content: fBallResDtoList,
      size: response.size,
      empty: response.empty,
      first: response.first,
      last: response.last,
      number: response.number,
      numberOfElements: response.numberOfElements,
      pageable: response.pageable,
      sort: response.sort,
      totalElements: response.totalElements,
      totalPages: response.totalPages
    );

    return ballsResponse2;
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
  Position? searchPosition(){
    if(fBallListUpUseCaseInputPort != null){
      return fBallListUpUseCaseInputPort!.searchPosition!;
    }else {
      return null;
    }
  }

  @override
  hideBall(String ballUuid) {
    this.itemList!.removeWhere((element) => element.ballUuid == ballUuid);
    onPageListUpdate();
  }


}