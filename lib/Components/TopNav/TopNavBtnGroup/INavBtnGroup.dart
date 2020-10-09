import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';


abstract class INavBtnGroup {

  List<NavBtn> navBtnList;

  arrangeBtnIndexStack({@required CodeState top});
}