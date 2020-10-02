import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';

abstract class NavBtnAction {
  onOpenClick();
  onCloseClick();
}

class H001NavBtnAction implements NavBtnAction{

  final GeoViewSearchManagerInputPort geoViewSearchManager;

  H001NavBtnAction({@required this.geoViewSearchManager});

  @override
  onCloseClick() {
    // geoViewSearchManager.search(geoViewSearchManager.currentSearchPosition);
  }

  @override
  onOpenClick() {
    print("onOpenClick");
  }

}