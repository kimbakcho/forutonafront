import 'package:flutter/cupertino.dart';
import 'package:forutonafront/GCodePage/GCodePageState.dart';
import 'package:forutonafront/HCodePage/HCodePageState.dart';

class GCodeMainPageViewModel extends ChangeNotifier {
  GCodePageState currentState;
  PageController gCodePagecontroller = new PageController();
  GCodeMainPageViewModel(){
    currentState = GCodePageState.G001Page;
    gCodePagecontroller.addListener(onhCodePageChangeListners);

  }
  void jumpTopPage(GCodePageState gcode) {
    currentState = gcode;
    if(gcode == GCodePageState.G001Page){
      gCodePagecontroller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }else if(gcode == GCodePageState.G003Page){
      gCodePagecontroller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }
    notifyListeners();
  }
  onhCodePageChangeListners(){
    if(gCodePagecontroller.page == 0.0){
      currentState = GCodePageState.G001Page;
      notifyListeners();
    }else if(gCodePagecontroller.page == 1.0){
      currentState = GCodePageState.G003Page;
      notifyListeners();
    }
  }


}