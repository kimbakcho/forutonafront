import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/INavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';

abstract class INavBtnGroup {

  List<NavBtn> navBtnList;

  registerBtn(NavBtn iNavBtn);
  arrangeBtnIndexStack({@required String top});
}