import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResWrapDto.dart';
import 'package:forutonafront/FBall/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class H00301PageViewModel extends ChangeNotifier {
  final BuildContext context;
  FBallPlayerRepository _fBallPlayerRepository = FBallPlayerRepository();
  UserToPlayBallResWrapDto userToPlayBallList;
  ScrollController scrollController = ScrollController();
  int _pageCount = 0;
  int _limitSize = 10;

  bool _isLoading = false;
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
    userToPlayBallList = new UserToPlayBallResWrapDto(DateTime.now(), []);
    scrollController.addListener(scrollListener);
    _setIsLoading(true);
    await ballListUp();
    _setIsLoading(false);
  }

  Future ballListUp() async {
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
    if (_isFirstPage()) {
      this.userToPlayBallList = await _fBallPlayerRepository
          .getUserToPlayBallList(userToPlayBallReqDto);
    } else {
      var userToPlayBallResWrapDto = await _fBallPlayerRepository
          .getUserToPlayBallList(userToPlayBallReqDto);
      this
          .userToPlayBallList
          .contents
          .addAll(userToPlayBallResWrapDto.contents);
    }
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
    return !(_pageCount * _limitSize > userToPlayBallList.contents.length);

  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange;
  }
}
