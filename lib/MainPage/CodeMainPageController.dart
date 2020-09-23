import 'package:flutter/material.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:injectable/injectable.dart';

abstract class CodeMainPageController{
  PageController pageController;
  CodeState currentState;
  moveToPage(CodeState pageCode);
}
@LazySingleton(as: CodeMainPageController)
class CodeMainPageControllerImpl implements CodeMainPageController{

  @override
  CodeState currentState = CodeState.H001CODE;

  @override
  PageController pageController = new PageController();

  @override
  moveToPage(CodeState pageCode) {
    currentState = pageCode;
    switch (pageCode) {
      case CodeState.H001CODE:
        pageController.jumpToPage(0);
        break;
      case CodeState.H003CODE:
        pageController.jumpToPage(1);
        break;
      case CodeState.X001CODE:
        pageController.jumpToPage(2);
        break;
      case CodeState.X002CODE:
        pageController.jumpToPage(3);
        break;
    }
  }


}
