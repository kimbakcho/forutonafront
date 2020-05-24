import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';
import 'package:forutonafront/FBall/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetInter.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class H00301PageViewModel extends ChangeNotifier implements BallStyle2WidgetInter{
  final BuildContext _context;
  List<BallStyle2Widget> ballListUpWidgets = [];
  ScrollController scrollController = ScrollController();
  int _pageCount = 0;
  int _limitSize = 10;
  bool _isInitFinish = false;
  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  H00301PageViewModel(this._context) {
    this.init();
  }

  init() async {
    scrollController.addListener(scrollListener);

    await ballListUp();

    _isInitFinish = true;
  }
  isEmptyPage(){
    GlobalModel globalModel = Provider.of(_context,listen:  false);
    if(globalModel.fUserInfoDto != null && _isInitFinish && ballListUpWidgets.length == 0){
      return true;
    }else {
      return false;
    }
  }

  Future ballListUp() async {
    _setIsLoading(true);
    FBallPlayerRepository _fBallPlayerRepository = FBallPlayerRepository();
    var globalModel = Provider.of<GlobalModel>(_context, listen: false);
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
        .map((x) => BallStyle2Widget.create(x.fballResDto.ballType,BallStyle2WidgetController(x,this)))
        .toList());
    _setIsLoading(false);
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
  }

  bool _hasBalls() {
    return !(_pageCount * _limitSize > ballListUpWidgets.length);

  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange;
  }

  @override
  onRequestReFreshBall(UserBallResDto p1) async {
//    _setIsLoading(true);
    var ballStyle2ReFreshBallUtil = BallStyle2ReFreshBallUtil();
    await ballStyle2ReFreshBallUtil.reFreshBallAndUiUpdate(ballListUpWidgets, p1, this);
    notifyListeners();
//    _setIsLoading(false);

  }

}
