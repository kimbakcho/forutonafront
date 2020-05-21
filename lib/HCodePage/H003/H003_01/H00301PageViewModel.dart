import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';
import 'package:forutonafront/FBall/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class H00301PageViewModel extends ChangeNotifier {
  final BuildContext context;
  List<BallStyle2Widget> ballListUpWidgets = [];
  ScrollController scrollController = ScrollController();
  int _pageCount = 0;
  int _limitSize = 10;
  bool _isLoading = false;
  bool _isinitFinish = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  H00301PageViewModel(this.context) {
    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);
    _setIsLoading(true);
    await ballListUp();
    _setIsLoading(false);
    _isinitFinish = true;
  }
  isEmptyPage(){
    GlobalModel globalModel = Provider.of(context,listen:  false);
    if(globalModel.fUserInfoDto != null && _isinitFinish && ballListUpWidgets.length == 0){
      return true;
    }else {
      return false;
    }
  }

  Future ballListUp() async {
    FBallPlayerRepository _fBallPlayerRepository = FBallPlayerRepository();
    var globalModel = Provider.of<GlobalModel>(context, listen: false);
    List<MultiSort> sorts = new List<MultiSort>();
    sorts.add(MultiSort("Alive", QueryOrders.DESC));
    //startTime이 참여한 시작시간이다.
    sorts.add(MultiSort("startTime", QueryOrders.DESC));
    MultiSorts wrapsorts = new MultiSorts(sorts);
    var userToPlayBallReqDto = UserToPlayBallReqDto(
        globalModel.fUserInfoDto.uid,
        _pageCount,
        _limitSize,
        wrapsorts.toQureyJson());
    var userToPlayBallList = await _fBallPlayerRepository
        .getUserToPlayBallList(userToPlayBallReqDto);

    if (_isFirstPage()) {
      ballListUpWidgets.clear();
    }
    ballListUpWidgets.addAll(userToPlayBallList.contents
        .map((x) => BallStyle2Widget.create(x, onRequestReFreshBall))
        .toList());
    notifyListeners();
  }

  bool _isFirstPage() => _pageCount == 0;

  scrollListener() async {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (!_hasBalls()) {
        return;
      } else {
        ballListUp();
      }
    }
  }

  bool _hasBalls() {
    return !(_pageCount * _limitSize > ballListUpWidgets.length);

  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange;
  }

  onRequestReFreshBall(UserBallResDto p1) async {
    _setIsLoading(true);
    FBallPlayerRepository _fBallPlayerRepository = FBallPlayerRepository();
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var userToPlayBall = await _fBallPlayerRepository.getUserToPlayBall(UserToPlayBallSelectReqDto(firebaseUser.uid,p1.fBallUuid));
    var indexWhere = this
        .ballListUpWidgets
        .indexWhere((element) => element.getUserBallResDto().fBallUuid == p1.fBallUuid);
    this.ballListUpWidgets[indexWhere] = BallStyle2Widget.create(userToPlayBall, onRequestReFreshBall);
    _setIsLoading(false);
  }
}
