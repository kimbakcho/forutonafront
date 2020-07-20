import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/HCodePageState.dart';

class HCodeMainPageViewModel extends ChangeNotifier {
  HCodePageState currentState;
  PageController hCodePageController = new PageController();

  HCodeMainPageViewModel(){
    currentState = HCodePageState.H001Page;
    hCodePageController.addListener(onhCodePageChangeListners);
  }
  jumpTopPage(HCodePageState hcode){
    currentState = hcode;
    if(hcode == HCodePageState.H001Page){
      hCodePageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }else if(hcode == HCodePageState.H003Page){
      hCodePageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }
    notifyListeners();
  }

  onhCodePageChangeListners(){
    if(hCodePageController.page == 0.0){
      currentState = HCodePageState.H001Page;
      notifyListeners();
    }else if(hCodePageController.page == 1.0){
      currentState = HCodePageState.H003Page;
      notifyListeners();
    }
  }

}