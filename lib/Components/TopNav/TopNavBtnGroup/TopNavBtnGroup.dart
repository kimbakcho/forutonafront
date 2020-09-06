import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/INavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'INavBtnGroup.dart';

// ignore: must_be_immutable
class NavBtnGroup extends StatelessWidget implements INavBtnGroup{

  final Duration _duration = Duration(milliseconds: 300);

  NavBtnGroup({Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: navBtnList as dynamic,
      ),
    );
  }

  @override
  arrangeBtnIndexStack({@required String top}) {
    navBtnList.sort((a,b){
      return a.originIndex > b.originIndex ? 1 : -1;
    });
    var indexWhere = navBtnList.indexWhere((element) => element.btnName == top);
    var tempNavBtn = navBtnList[indexWhere];
    navBtnList.removeAt(indexWhere);
    navBtnList.add(tempNavBtn);
  }

  @override
  registerBtn(NavBtn iNavBtn) {
    navBtnList.add(iNavBtn);
  }

  @override
  List<NavBtn> navBtnList = [] ;

}
