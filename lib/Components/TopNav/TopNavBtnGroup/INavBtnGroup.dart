import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';

abstract class INavBtnGroup {

  List<NavBtn> navBtnList;

  registerBtn(NavBtn iNavBtn);
  arrangeBtnIndexStack({@required CodeState top});
}