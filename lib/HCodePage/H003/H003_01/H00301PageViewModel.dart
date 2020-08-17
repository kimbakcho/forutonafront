import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class H00301PageViewModel extends ChangeNotifier
    implements FBallListUpUseCaseOutputPort {
  final BuildContext context;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  final ScrollController scrollController;

  final FBallListUpUseCaseInputPort _fBallListUpUseCaseInputPort;

  List<BallStyle2Widget> ballListUpWidgets = [];

  PageWrap<FBallResDto> listUpItem = PageWrap<FBallResDto>();

  int _pageCount = 0;
  int _limitSize = 10;
  bool _isInitFinish = false;
  bool _isLoading = false;
  bool _subScrollerTopOver = false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  H00301PageViewModel(
      {@required this.context,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort,
      @required this.scrollController})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _fBallListUpUseCaseInputPort = fBallListUpUseCaseInputPort {
    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await ballListUp();
    }
    _isInitFinish = true;
  }

  isEmptyPage() {
    if (ballListUpWidgets.length == 0 && _isInitFinish) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> ballListUp() async {
    isLoading = true;
//    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
//      await _fBallListUpUseCaseInputPort.searchFBallListUpUserMakerBall(
//          await _fireBaseAuthAdapterForUseCase.userUid(),
//          Pageable(_pageCount, _limitSize, "makeTimeDESCAliveDESC"),
//          outputPort: this);
//    }
    isLoading = false;
  }

  @override
  void searchResult(PageWrap<FBallResDto> result) {
    listUpItem = result;
    if (listUpItem.first) {
      ballListUpWidgets.clear();
    }
    ballListUpWidgets.addAll(listUpItem.content
        .map((x) => BallStyle2Widget.create(fBallResDto: x))
        .toList());
  }

  scrollListener() async {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (listUpItem.last) {
        return;
      } else {
        await ballListUp();
        scrollController.animateTo(
            scrollController.offset + (MediaQuery.of(context).size.height / 2),
            duration: Duration(milliseconds: 300),
            curve: Curves.linear);
      }
    }
    if (_isScrollerTopOver()) {
      setFirstPage();
      await ballListUp();
    }
  }

  int setFirstPage() => _pageCount = 0;

  bool _isScrollerTopOver() {
    if (scrollController.offset <=
        scrollController.position.minScrollExtent - 100) {
      _subScrollerTopOver = true;
    }
    if (_subScrollerTopOver && !scrollController.position.outOfRange) {
      _subScrollerTopOver = false;
      return true;
    } else {
      return false;
    }
  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange;
  }
}
