import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';



enum CodeState { H001CODE, H003CODE, X001CODE, X002CODE, I001CODE, G001CODE,G003CODE }

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

class CodeMainPageControllerImpl implements CodeMainPageController {
  List<CodeMainPageChangeListener> _codeMainPageChangeListener = [];

  @override
  CodeState currentState;

  @override
  PageController pageController = new PageController();

  @override
  SwipeGestureRecognizerController swipeGestureRecognizerController;

  TopNavBtnMediator topNavBtnMediator;

  Map<CodeState, CodeMainPageLinkDto> mapCodeMainPageLink;

  CodeMainPageControllerImpl({
    @required this.swipeGestureRecognizerController,
    @required this.topNavBtnMediator,
    @required this.currentState,
    @required this.mapCodeMainPageLink
  });

  addListener(CodeMainPageChangeListener codeMainPageChangeListener) {
    this._codeMainPageChangeListener.add(codeMainPageChangeListener);
  }

  removeListener(CodeMainPageChangeListener codeMainPageChangeListener) {
    this._codeMainPageChangeListener.remove(codeMainPageChangeListener);
  }

  @override
  moveToPage(CodeState pageCode) {
    currentState = pageCode;

    mapCodeMainPageLink[pageCode].gestureFlag
        ?
    swipeGestureRecognizerController.gestureOn()
        : swipeGestureRecognizerController.gestureOff();

    pageController.jumpToPage(mapCodeMainPageLink[currentState].pageNumber);

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

class CodeMainPageLinkDto {
  bool gestureFlag;
  int pageNumber;

  CodeMainPageLinkDto({this.gestureFlag, this.pageNumber});

}

abstract class CodeMainPageChangeListener {
  onChangeMainPage();
}
