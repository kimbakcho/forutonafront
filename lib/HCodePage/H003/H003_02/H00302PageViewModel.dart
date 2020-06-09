import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserMakeBallListUp/UserMakeBallListUpUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserMakeBallListUp/UserMakeBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserMakeBallListUp/UserMakeBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';

class H00302PageViewModel extends ChangeNotifier implements UserMakeBallListUpUseCaseOutputPort,AuthUserCaseOutputPort{
  final BuildContext context;

  ScrollController scrollController = ScrollController();
  List<BallStyle2Widget> ballListUpWidgets = [];
  bool _isInitFinish = false;
  bool _isLoading = false;
  bool _subScrollerTopOver = false;
  AuthUserCaseInputPort _authUserCaseInputPort = FireBaseAuthUseCase();
  UserMakeBallListUpUseCaseInputPort _userMakeBallListUpUseCaseInputPort = UserMakeBallListUpUseCase();



  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _pageCount = 0;
  int _limitSize = 10;

  H00302PageViewModel(this.context) {
    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);
    if(await _authUserCaseInputPort.checkLogin()){
      await ballListUp();
    }
    _isInitFinish= true;
  }


  Future ballListUp() async {
    isLoading = true;
    MultiSorts searchOrder = _makeAliveMakeTimeOrder();
    var userToMakerBallReqDto = UserToMakeBallReqDto(
        await _authUserCaseInputPort.userUid(),
        _pageCount,
        _limitSize,
        searchOrder.toQueryJson());
    if (_isFirstPage()) {
      ballListUpWidgets.clear();
    }
    await _userMakeBallListUpUseCaseInputPort.userMakeBallListUp(reqDto: userToMakerBallReqDto,outputPort: this);
    isLoading =false;
  }

  MultiSorts _makeAliveMakeTimeOrder() {
    List<MultiSort> sorts = new List<MultiSort>();
    sorts.add(MultiSort("Alive", QueryOrders.DESC));
    //start가 Join sartTime
    sorts.add(MultiSort("makeTime", QueryOrders.DESC));
    MultiSorts wrapsorts = new MultiSorts(sorts);
    return wrapsorts;
  }

  bool _isFirstPage() => _pageCount == 0;

  scrollListener() async {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (!_hasBalls()) {
        return;
      } else {
        await ballListUp();
        scrollController.animateTo(scrollController.offset+(MediaQuery.of(context).size.height/2),
            duration: Duration(milliseconds: 300), curve: Curves.linear );
      }
    }
    if(_isScrollerTopOver()){
      setFirstPage();
      await ballListUp();
    }
  }

  int setFirstPage() => _pageCount = 0;

  bool _isScrollerTopOver(){
    if(scrollController.offset <= scrollController.position.minScrollExtent-100){
      _subScrollerTopOver = true;
    }
    if(_subScrollerTopOver &&
        !scrollController.position.outOfRange){
      _subScrollerTopOver = false;
      return true;
    }else {
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
  onUserMakeBallListUp(List<UserToMakeBallResDto> userToMakerBallResDtos) {
    ballListUpWidgets.addAll(userToMakerBallResDtos
        .map((x) => BallStyle2Widget.create(fBallResDto: x))
        .toList());
    notifyListeners();
  }

  isEmptyPage(){
    if(ballListUpWidgets.length == 0 && _isInitFinish){
      return true;
    }else {
      return false;
    }
  }

  @override
  onLoginCheck(bool isLogin) {
    notifyListeners();
  }
}
