import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class H00301PageViewModel extends ChangeNotifier implements UserPlayBallListUpUseCaseOutputPort,AuthUserCaseOutputPort{
  final BuildContext _context;
  List<BallStyle2Widget> ballListUpWidgets = [];
  ScrollController scrollController = ScrollController();
  int _pageCount = 0;
  int _limitSize = 10;
  bool _isInitFinish = false;
  bool _isLoading = false;
  get isLoading {
    return _isLoading;
  }
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  AuthUserCaseInputPort _authUserCaseInputPort = FireBaseAuthUseCase();
  UserPlayBallListUpUseCaseInputPort _fBallPlayerListUpUseCaseIp = UserPlayBallListUpUseCase();


  H00301PageViewModel(this._context) {

    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);
    if(await _authUserCaseInputPort.checkLogin(authUserCaseOutputPort: this)){
      await ballListUp();
    }
    _isInitFinish = true;
  }

  isEmptyPage(){
    if(ballListUpWidgets.length == 0 && _isInitFinish){
      return true;
    }else {
      return false;
    }
  }

  Future<void> ballListUp() async {
    isLoading = true;
    if(await _authUserCaseInputPort.checkLogin(authUserCaseOutputPort: this)){
      isLoading = false;
      return ;
    }
    List<MultiSort> sorts = new List<MultiSort>();
    sorts.add(MultiSort("Alive", QueryOrders.DESC));
    //startTime이 참여한 시작시간이다.
    sorts.add(MultiSort("startTime", QueryOrders.DESC));
    MultiSorts wrapsorts = new MultiSorts(sorts);
    var userToPlayBallReqDto = UserToPlayBallReqDto(
        await _authUserCaseInputPort.userUid(),
        _pageCount,
        _limitSize,
        wrapsorts.toQueryJson());
    await _fBallPlayerListUpUseCaseIp.userPlayBallListUp(reqDto: userToPlayBallReqDto);
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
        scrollController.animateTo(scrollController.offset+(MediaQuery.of(_context).size.height/2),
            duration: Duration(milliseconds: 300), curve: Curves.linear );
      }
    }
    if(isScrollerTopOver()){
      setFirstPage();
      await ballListUp();
    }
  }

  int setFirstPage() => _pageCount = 0;

  bool isScrollerTopOver(){
    return scrollController.offset <= scrollController.position.minScrollExtent-100;
  }


  bool _hasBalls() {
    return !(_pageCount * _limitSize > ballListUpWidgets.length);

  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange;
  }

  @override
  onLoginCheck(bool isLogin) {
    notifyListeners();
  }
}
