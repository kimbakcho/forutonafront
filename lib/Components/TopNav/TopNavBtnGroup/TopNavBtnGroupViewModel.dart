import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';


import '../TopNavBtnMediator.dart';
import 'INavBtnGroup.dart';

class TopNavBtnGroupViewModel extends ChangeNotifier implements INavBtnGroup {
  final Duration duration = Duration(milliseconds: 300);
  final TopNavBtnMediator topNavBtnMediator;

  TopNavBtnGroupViewModel({@required this.topNavBtnMediator,this.navBtnList}) {
    topNavBtnMediator.iNavBtnGroup = this;

    notifyListeners();
  }

  @override
  List<NavBtn> navBtnList;

  @override
  arrangeBtnIndexStack({CodeState top}) {
    navBtnList.sort((a, b) {
      return a.originIndex > b.originIndex ? 1 : -1;
    });
    var indexWhere =
        navBtnList.indexWhere((element) => element.routerType == top);
    var tempNavBtn = navBtnList[indexWhere];
    navBtnList.removeAt(indexWhere);
    navBtnList.add(tempNavBtn);
    notifyListeners();
  }

}
