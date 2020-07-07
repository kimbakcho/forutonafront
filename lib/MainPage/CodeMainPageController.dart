import 'package:flutter/material.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';

abstract class CodeMainPageController{
  PageController pageController;
  HCodeState currentState;
  moveToPage(HCodeState pageCode);
}
class CodeMainPageControllerImpl implements CodeMainPageController{

  @override
  HCodeState currentState = HCodeState.HCDOE;

  @override
  PageController pageController = new PageController();

  @override
  moveToPage(HCodeState pageCode) {
    currentState = pageCode;
    switch (pageCode) {
      case HCodeState.HCDOE:
        pageController.jumpToPage(0);
        break;
      case HCodeState.ICODE:
        pageController.jumpToPage(1);
        break;
      case HCodeState.BCODE:
        pageController.jumpToPage(2);
        break;
      case HCodeState.KCODE:
        pageController.jumpToPage(3);
        break;
      case HCodeState.GCODE:
        pageController.jumpToPage(4);
        break;
    }
  }


}
