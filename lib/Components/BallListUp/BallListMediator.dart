import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class BallListMediatorComponent {

  void onBallListUpUpdate();
}

abstract class BallListMediator {
  FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort;

  void registerComponent(BallListMediatorComponent component);

  void unregisterComponent(BallListMediatorComponent component);

  int componentSize();

  searchNext();

  searchFirst();

  List<FBallResDto> ballList;

  bool get isLastPage;

  Position searchPosition();
}

class BallListMediatorImpl implements BallListMediator {
  FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort;

  List<BallListMediatorComponent> ballListMediatorComponentList = [];

  int _pageCount = 0;

  int _pageLimit = 40;

  PageWrap<FBallResDto> _wrapBallList;

  List<FBallResDto> ballList = [];

  bool loadLast = false;

  BallListMediatorImpl()
  {
    _wrapBallList = PageWrap<FBallResDto>();
  }


  @override
  void registerComponent(BallListMediatorComponent component) {
    ballListMediatorComponentList.add(component);
  }

  @override
  void unregisterComponent(BallListMediatorComponent component) {
    ballListMediatorComponentList.remove(component);
  }

  search(Pageable pageable ) async {
    if(fBallListUpUseCaseInputPort == null){
      throw Exception("don't have searchCaseInputPort for need set FBallListUpUseCaseInputPort");
    }
    if(isLastPage){
      return ;
    }
    this._wrapBallList = await this
        .fBallListUpUseCaseInputPort
        .search(pageable);
    if (_wrapBallList.first) {
      ballList.clear();
    }
    ballList.addAll(_wrapBallList.content);
    _pageCount = pageable.page;
    onPageListUpdate();
  }

  onPageListUpdate() {
    ballListMediatorComponentList.forEach((element) {
      element.onBallListUpUpdate();
    });
  }

  @override
  searchNext() async{
    _pageCount++;
    await search(Pageable(page:_pageCount,size:_pageLimit));
  }


  @override
  searchFirst() async {
    _pageCount = 0;
    _wrapBallList = PageWrap<FBallResDto>();
    await search(Pageable(page:_pageCount,size:_pageLimit));
  }

  set pageLimit(int value) {
    this._pageLimit = value;
  }

  @override
  bool get isLastPage {
    return _wrapBallList.last;
  }

  @override
  int componentSize() {
    return ballListMediatorComponentList.length;
  }


  Position searchPosition(){
    if(fBallListUpUseCaseInputPort != null){
      return fBallListUpUseCaseInputPort.searchPosition;
    }else {
      return null;
    }
  }


}
