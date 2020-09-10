import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';

import '../TopNavRouterType.dart';

abstract class INavBtnGroup {

  List<NavBtn> navBtnList;

  registerBtn(NavBtn iNavBtn);
  arrangeBtnIndexStack({@required TopNavRouterType top});
}