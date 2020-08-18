import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class BallListMediatorComponent {
  void setMediator(BallListMediator ballListMediator);

  void onBallListUpUpdate();
}

abstract class BallListMediator {
  void registerComponent(BallListMediatorComponent component);

  void unregisterComponent(BallListMediatorComponent component);

  searchNext();

  searchFirst();

  List<FBallResDto> ballList;

  set fBallListUpUseCaseInputPort(FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort);

  set sort(String sort);

  set pageLimit(int value);

  bool get isLastPage;
}

class BallListMediatorImpl implements BallListMediator {
  FBallListUpUseCaseInputPort _fBallListUpUseCaseInputPort;

  List<BallListMediatorComponent> ballListMediatorComponentList = [];

  int _pageCount = 0;

  int _pageLimit = 20;

  String _sort = "";

  PageWrap<FBallResDto> _wrapBallList;


  List<FBallResDto> ballList = [];

  bool loadLast = false;

  BallListMediatorImpl()
  {
    _wrapBallList = PageWrap<FBallResDto>();
  }

  set fBallListUpUseCaseInputPort(FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort){
    _fBallListUpUseCaseInputPort = fBallListUpUseCaseInputPort;
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
    if(_fBallListUpUseCaseInputPort == null){
      throw Exception("don't have searchCaseInputPort for need set FBallListUpUseCaseInputPort");
    }
    this._wrapBallList = await this
        ._fBallListUpUseCaseInputPort
        .search(pageable);
    if (_wrapBallList.first) {
      loadLast = false;
      ballList.clear();
      ballList.addAll(_wrapBallList.content);
    } else if (_wrapBallList.last) {
      ballList.addAll(_wrapBallList.content);
    } else {
      ballList.addAll(_wrapBallList.content);
    }
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
    await search(Pageable(_pageCount,_pageLimit,_sort));
  }

  @override
  set sort(String sort) {
    this._sort = sort;
  }

  @override
  searchFirst() async {
    _pageCount = 0;
    await search(Pageable(_pageCount,_pageLimit,_sort));
  }

  set pageLimit(int value) {
    this._pageLimit = value;
  }

  @override
  bool get isLastPage {
    return _wrapBallList.last;
  }


}
