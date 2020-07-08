import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/FSort.dart';
import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';

class H00301PageViewModel extends ChangeNotifier
    implements UserPlayBallListUpUseCaseOutputPort, AuthUserCaseOutputPort {
  final BuildContext context;
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final UserPlayBallListUpUseCaseInputPort _userPlayBallListUpUseCaseInputPort;
  final ScrollController scrollController;

  List<BallStyle2Widget> ballListUpWidgets = [];
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
      {
        @required this.context,
      @required AuthUserCaseInputPort authUserCaseInputPort,
      @required UserPlayBallListUpUseCaseInputPort userPlayBallListUpUseCaseInputPort,
        @required this.scrollController})
      : _authUserCaseInputPort = authUserCaseInputPort,
        _userPlayBallListUpUseCaseInputPort =
            userPlayBallListUpUseCaseInputPort {
    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);
    if (await _authUserCaseInputPort.isLogin(authUserCaseOutputPort: this)) {
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
    if (await _authUserCaseInputPort.isLogin(authUserCaseOutputPort: this)) {
      FSorts fSort = new FSorts();
      fSort.sorts.add(FSort("Alive", QueryOrders.DESC));
      //startTime이 참여한 시작시간이다.
      fSort.sorts.add(FSort("startTime", QueryOrders.DESC));

      var userToPlayBallReqDto = UserToPlayBallReqDto(
          await _authUserCaseInputPort.myUid(),
          _pageCount,
          _limitSize,
          fSort.toQueryJson());
      await _userPlayBallListUpUseCaseInputPort.userPlayBallListUp(
          reqDto: userToPlayBallReqDto, outputPort: this);
    }

    isLoading = false;
  }

  @override
  onBallPlayerListUp(List<UserToPlayBallResDto> userToPlayBallResDtos) {
    if (_isFirstPage()) {
      ballListUpWidgets.clear();
    }
    ballListUpWidgets.addAll(userToPlayBallResDtos
        .map((x) => BallStyle2Widget.create(fBallResDto: x))
        .toList());
  }

  bool _isFirstPage() => _pageCount == 0;

  scrollListener() async {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (!_hasBalls()) {
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

  bool _hasBalls() {
    return !(_pageCount * _limitSize > ballListUpWidgets.length);
  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange;
  }

  @override
  onLoginCheck(bool isLogin) {
    notifyListeners();
  }
}
