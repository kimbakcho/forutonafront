import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:injectable/injectable.dart';

enum BallListMediatorState {
  Empty,HasBall,Error
}

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

  hideBall(String ballUuid);

  bool get isLastPage;

  Position searchPosition();

  BallListMediatorState currentState;

  bool isLoading;
}


@Injectable(as: BallListMediator)
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
    isLoading = true;
    onPageListUpdate();
    if(fBallListUpUseCaseInputPort == null){
      currentState = BallListMediatorState.Error;
      onPageListUpdate();
      throw Exception("don't have searchCaseInputPort for need set FBallListUpUseCaseInputPort");
    }
    if(isLastPage){
      if(_pageCount == 0 && ballList.length == 0){
        currentState = BallListMediatorState.Empty;
      }
      onPageListUpdate();
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

    if(_pageCount == 0 && ballList.length == 0){
      currentState = BallListMediatorState.Empty;
    }else {
      currentState = BallListMediatorState.HasBall;
    }
    isLoading = false;
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

  @override
  hideBall(String ballUuid) {
    this.ballList.removeWhere((element) => element.ballUuid == ballUuid);
    onPageListUpdate();
  }

  @override
  BallListMediatorState currentState = BallListMediatorState.HasBall;

  @override
  bool isLoading = false;


}
