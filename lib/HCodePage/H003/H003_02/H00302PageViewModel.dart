import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakerBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakerBallResWrapDto.dart';

import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:provider/provider.dart';

import '../../../GlobalModel.dart';

class H00302PageViewModel extends ChangeNotifier {
  final BuildContext context;
  UserToMakerBallResWrapDto userToMakerBallList;
  ScrollController scrollController =  ScrollController();
  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
  FBallRepository _fballRepository =  FBallRepository();
  int _pageCount = 0;
  int _limitSize = 10;

  H00302PageViewModel(this.context){

    this.init();
  }
  init() async {
    userToMakerBallList = new UserToMakerBallResWrapDto(DateTime.now(),[]);
    scrollController.addListener(scrollListener);
    _setIsLoading(true);
    await ballListUp();
    _setIsLoading(false);
  }

  Future ballListUp() async {
    var globalModel = Provider.of<GlobalModel>(context,listen: false);
    List<MultiSort> sorts = new List<MultiSort>();
    sorts.add(MultiSort("Alive",QueryOrders.DESC));
    //start가 Join sartTime
    sorts.add(MultiSort("makeTime",QueryOrders.DESC));
    MultiSorts wrapsorts = new MultiSorts(sorts) ;
    var userToMakerBallReqDto = UserToMakerBallReqDto(globalModel.fUserInfoDto.uid,_pageCount,_limitSize,wrapsorts.toQureyJson());
    if(_pageCount == 0){
      this.userToMakerBallList = await _fballRepository.getUserToMakerBalls(userToMakerBallReqDto);
    }else {
      var userToPlayBallResWrapDto = await _fballRepository.getUserToMakerBalls(userToMakerBallReqDto);
      this.userToMakerBallList.contents.addAll(userToPlayBallResWrapDto.contents);
    }
    notifyListeners();

  }
  scrollListener() async{
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
    return !(_pageCount * _limitSize >
        userToMakerBallList.contents.length);
  }

  bool _isScrollerMoveBottomOver() {
    return scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange;
  }

}