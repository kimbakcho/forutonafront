import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/MainPage/CodeMainpage.dart';
import 'package:provider/provider.dart';

abstract class NavBtnAction {
  onOpenClick();
  onCloseClick();
}

class H001NavBtnAction implements NavBtnAction{

  final GeoViewSearchManagerInputPort geoViewSearchManager;

  H001NavBtnAction({@required this.geoViewSearchManager});

  @override
  onCloseClick() {
  }

  @override
  onOpenClick() {
    print("onOpenClick");
  }

}