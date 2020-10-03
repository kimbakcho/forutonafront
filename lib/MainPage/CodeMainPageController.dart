import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:injectable/injectable.dart';

abstract class CodeMainPageController{
  PageController pageController;
  CodeState currentState;
  moveToPage(CodeState pageCode);
  SwipeGestureRecognizerController swipeGestureRecognizerController;
}

@LazySingleton(as: CodeMainPageController)
class CodeMainPageControllerImpl implements CodeMainPageController{

  @override
  CodeState currentState = CodeState.H001CODE;

  @override
  PageController pageController = new PageController();

  @override
  SwipeGestureRecognizerController swipeGestureRecognizerController;

  CodeMainPageControllerImpl({@required this.swipeGestureRecognizerController});

  @override
  moveToPage(CodeState pageCode) {
    currentState = pageCode;
    switch (pageCode) {
      case CodeState.H001CODE:
        swipeGestureRecognizerController.gestureOn();
        pageController.jumpToPage(0);
        break;
      case CodeState.H003CODE:
        swipeGestureRecognizerController.gestureOn();
        pageController.jumpToPage(1);
        break;
      case CodeState.X001CODE:
        swipeGestureRecognizerController.gestureOn();
        pageController.jumpToPage(2);
        break;
      case CodeState.X002CODE:
        swipeGestureRecognizerController.gestureOn();
        pageController.jumpToPage(3);
        break;
      case CodeState.I001CODE:
        swipeGestureRecognizerController.gestureOff();
        pageController.jumpToPage(4);
        break;
    }
  }






}
