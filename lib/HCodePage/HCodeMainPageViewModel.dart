import 'package:flutter/cupertino.dart';
import 'package:forutonafront/HCodePage/HCodePageState.dart';

class HCodeMainPageViewModel extends ChangeNotifier {
  HCodePageState currentState;
  PageController hCodePagecontroller = new PageController();
  HCodeMainPageViewModel(){
    currentState = HCodePageState.H001Page;
    hCodePagecontroller.addListener(onhCodePageChangeListners);

  }
  jumpTopPage(HCodePageState hcode){
    currentState = hcode;
    if(hcode == HCodePageState.H001Page){
      hCodePagecontroller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }else if(hcode == HCodePageState.H003Page){
      hCodePagecontroller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }
    notifyListeners();
  }
  onhCodePageChangeListners(){
    if(hCodePagecontroller.page == 0.0){
      currentState = HCodePageState.H001Page;
      notifyListeners();
    }else if(hCodePagecontroller.page == 1.0){
      currentState = HCodePageState.H003Page;
      notifyListeners();
    }
  }
}