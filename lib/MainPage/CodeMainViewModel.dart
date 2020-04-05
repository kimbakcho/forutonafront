import 'package:flutter/material.dart';

enum HCodeState { HCDOE, ICODE, JCODE, KCODE, LCODE }

class CodeMainViewModel with ChangeNotifier {
  PageController pageController;
  HCodeState currentState;

  CodeMainViewModel(){
    pageController = new PageController();
    currentState = HCodeState.HCDOE;
  }

  jumpToPage(HCodeState pageCode){
    currentState = pageCode;
    switch(currentState){
      case HCodeState.HCDOE:
        pageController.jumpToPage(0);
        break;
      case HCodeState.ICODE:
        pageController.jumpToPage(1);
        break;
      case HCodeState.JCODE:
        pageController.jumpToPage(2);
        break;
      case HCodeState.KCODE:
        pageController.jumpToPage(3);
        break;
      case HCodeState.LCODE:
        pageController.jumpToPage(4);
        break;
    }
    notifyListeners();
  }

}