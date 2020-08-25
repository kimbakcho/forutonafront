import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Components/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class H00302PageViewModel extends ChangeNotifier implements FBallListUpUseCaseOutputPort{
  final BuildContext context;
  final ScrollController scrollController;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  List<BallStyle2Widget> ballListUpWidgets = [];
  PageWrap<FBallResDto> listUpItem = PageWrap<FBallResDto>();
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


  H00302PageViewModel(
      {@required this.context,
      @required this.scrollController,
      @required FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase{
    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await ballListUp();
    }
    _isInitFinish = true;
  }

  Future ballListUp() async {
    isLoading = true;
//    _fBallListUpUseCaseInputPort.searchFBallListUpUserPlayBall(
//        await _fireBaseAuthAdapterForUseCase.userUid()
//    , Pageable(_pageCount,_limitSize,"startTimeDESCAliveDESC"),outputPort: this);
    isLoading = false;
  }


  scrollListener() async {
    if (_isScrollerMoveBottomOver()) {

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

      await ballListUp();
    }
  }


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

  @override
  void searchResult(PageWrap<FBallResDto> result) {
    listUpItem = result;
    ballListUpWidgets.addAll(listUpItem.content
        .map((x) => BallStyle2Widget.create(fBallResDto: x))
        .toList());
    notifyListeners();
  }

  isEmptyPage() {
    if (listUpItem.totalElements == 0 && _isInitFinish) {
      return true;
    } else {
      return false;
    }
  }



}
