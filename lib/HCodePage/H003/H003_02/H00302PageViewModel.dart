import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakerBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakerBallSelectReqDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetInter.dart';
import 'package:provider/provider.dart';

import '../../../GlobalModel.dart';

class H00302PageViewModel extends ChangeNotifier implements BallStyle2WidgetInter{
  final BuildContext context;

  ScrollController scrollController = ScrollController();
  List<BallStyle2Widget> ballListUpWidgets = [];
  bool _isInitFinish = false;

  bool _isLoading = false;
  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
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
    _setIsLoading(true);
    await ballListUp();
    _setIsLoading(false);
    _isInitFinish= false;
  }
  isEmptyPage(){
    GlobalModel globalModel = Provider.of(context,listen:  false);
    if(globalModel.fUserInfoDto != null && _isInitFinish && ballListUpWidgets.length == 0){
      return true;
    }else {
      return false;
    }
  }

  Future ballListUp() async {
    FBallRepository _fballRepository = FBallRepository();
    var globalModel = Provider.of<GlobalModel>(context, listen: false);
    MultiSorts searchOrder = _makeSearchOrder();
    var userToMakerBallReqDto = UserToMakerBallReqDto(
        globalModel.fUserInfoDto.uid,
        _pageCount,
        _limitSize,
        searchOrder.toQureyJson());
    if (_isFirstPage()) {
      ballListUpWidgets.clear();
    }
    var userToMakerBallList =
        await _fballRepository.getUserToMakerBalls(userToMakerBallReqDto);
    ballListUpWidgets.addAll(userToMakerBallList.contents
        .map((x) => BallStyle2Widget.create(x.fBallType,BallStyle2WidgetController(x,this) ))
        .toList());
    notifyListeners();
  }

  MultiSorts _makeSearchOrder() {
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
        ballListUp();
      }
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
  onRequestReFreshBall(UserBallResDto p1) async{
    _setIsLoading(true);
    var ballStyle2ReFreshBallUtil = BallStyle2ReFreshBallUtil();
    ballStyle2ReFreshBallUtil.reFreshBallAndUiUpdate(ballListUpWidgets, p1, this);
    _setIsLoading(false);
  }
}
