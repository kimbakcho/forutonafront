import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:injectable/injectable.dart';

abstract class CodeMainPageController {
  PageController pageController;
  CodeState currentState;

  movePageFromTo({CodeState mainTo, CodeState topFrom, CodeState topTo});

  moveToPage(CodeState pageCode);

  addListener(CodeMainPageChangeListener codeMainPageChangeListener);

  removeListener(CodeMainPageChangeListener codeMainPageChangeListener);

  SwipeGestureRecognizerController swipeGestureRecognizerController;

  updateChangeListener();
}

@LazySingleton(as: CodeMainPageController)
class CodeMainPageControllerImpl implements CodeMainPageController {
  List<CodeMainPageChangeListener> _codeMainPageChangeListener = [];

  @override
  CodeState currentState = CodeState.H001CODE;

  @override
  PageController pageController = new PageController();

  @override
  SwipeGestureRecognizerController swipeGestureRecognizerController;

  TopNavBtnMediator topNavBtnMediator;

  CodeMainPageControllerImpl(
      {@required this.swipeGestureRecognizerController,
      @required this.topNavBtnMediator});

  addListener(CodeMainPageChangeListener codeMainPageChangeListener) {
    this._codeMainPageChangeListener.add(codeMainPageChangeListener);
  }

  removeListener(CodeMainPageChangeListener codeMainPageChangeListener) {
    this._codeMainPageChangeListener.remove(codeMainPageChangeListener);
  }

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
    updateChangeListener();
  }

  updateChangeListener() {
    _codeMainPageChangeListener.forEach((element) {
      element.onChangeMainPage();
    });
  }

  movePageFromTo({CodeState mainTo, CodeState topFrom, CodeState topTo}) async {
    await topNavBtnMediator.openNavList(navRouterType: topFrom);
    moveToPage(mainTo);
    topNavBtnMediator.closeNavList(navRouterType: topTo);
  }
}

abstract class CodeMainPageChangeListener {
  onChangeMainPage();
}
