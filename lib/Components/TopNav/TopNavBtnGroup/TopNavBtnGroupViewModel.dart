import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'INavBtnGroup.dart';
import '../TopNavBtnMediator.dart';

class TopNavBtnGroupViewModel extends ChangeNotifier implements INavBtnGroup{
  final Duration duration = Duration(milliseconds: 300);

  TopNavBtnGroupViewModel(){
    TopNavBtnMediator topNavBtnMediator = sl();
    topNavBtnMediator.iNavBtnGroup = this;
    navBtnList.add(NavBtn(
      originIndex: 1,
      navBtnSetDto: NavBtnSetDto(
          routerType: TopNavRouterType.X002,
          btnColor: Color(0xffF6F6F6),
          btnIcon: Icon(Icons.account_balance),
          topOnMoveMainPage: CodeState.X002CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 120),
      key: Key("1"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 2,
      navBtnSetDto: NavBtnSetDto(
          routerType: TopNavRouterType.X001,
          btnColor: Color(0xffF6F6F6),
          btnIcon: Icon(Icons.star),
          topOnMoveMainPage: CodeState.X001CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 80),
      key: Key("2"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 3,
      navBtnSetDto: NavBtnSetDto(
          routerType: TopNavRouterType.H003,
          btnColor: Color(0xffCCCCFF),
          btnIcon: Icon(Icons.playlist_add),
          topOnMoveMainPage: CodeState.H003CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 40),
      key: Key("3"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 4,
      navBtnSetDto: NavBtnSetDto(
          routerType: TopNavRouterType.H001,
          btnColor: Color(0xff88D4F1),
          btnIcon: Icon(Icons.sort),
          topOnMoveMainPage: CodeState.H001CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 0),
      key: Key("4"),
    ));
    notifyListeners();
  }

  @override
  List<NavBtn> navBtnList = [];

  @override
  arrangeBtnIndexStack({TopNavRouterType top}) {
    navBtnList.sort((a, b) {
      return a.originIndex > b.originIndex ? 1 : -1;
    });
    var indexWhere = navBtnList.indexWhere((element) => element.routerType == top);
    var tempNavBtn = navBtnList[indexWhere];
    navBtnList.removeAt(indexWhere);
    navBtnList.add(tempNavBtn);
    notifyListeners();
  }

  @override
  registerBtn(NavBtn iNavBtn) {
    navBtnList.add(iNavBtn);
  }

}