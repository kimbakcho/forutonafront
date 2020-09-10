import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';

import 'NavBtn/TopNavBtnComponent.dart';
import 'TopNavBtnGroup/INavBtnGroup.dart';
import 'TopNavExpendGroup/TopNavExpendComponent.dart';
import 'TopNavExpendGroup/TopNavExpendGroup.dart';
import 'TopNavRouterType.dart';

abstract class TopNavBtnMediator {
  topNavBtnRegisterComponent(TopNavBtnComponent component);

  topNavBtnUnRegisterComponent(TopNavBtnComponent component);

  topNavExpendRegisterComponent(TopNavExpendComponent component);

  topNavExpendUnRegisterComponent(TopNavExpendComponent component);

  openNavList({@required TopNavRouterType navRouterType});

  closeNavList({@required TopNavRouterType navRouterType});

  set iNavBtnGroup(INavBtnGroup value);

  NavBtnMediatorState aniState;

  TopNavRouterType currentTopNavRouter;

  TopNavExpendGroupViewModel topNavExpendGroupViewModel;

  Duration animationDuration;

  CodeMainViewModelInputPort codeMainViewModelInputPort;

  void onNavBtnAniStatusListener(AnimationStatus status, TopNavRouterType routerType);

  void changeMainPage(CodeState topOnMoveMainPage);
}

class TopNavBtnMediatorImpl implements TopNavBtnMediator {
  List<TopNavBtnComponent> topNavBtnComponents = [];

  List<TopNavExpendComponent> topNavExpendComponents = [];

  Duration animationDuration = Duration(milliseconds: 300);

  TopNavExpendGroupViewModel topNavExpendGroupViewModel;

  TopNavRouterType currentTopNavRouter = TopNavRouterType.H001;

  @override
  NavBtnMediatorState aniState;

  INavBtnGroup _iNavBtnGroup;

  TopNavBtnMediatorImpl() {
    aniState = NavBtnMediatorState.Close;
  }

  set iNavBtnGroup(INavBtnGroup value) {
    _iNavBtnGroup = value;
  }

  @override
  topNavBtnRegisterComponent(TopNavBtnComponent component) {
    this.topNavBtnComponents.add(component);
  }

  @override
  topNavBtnUnRegisterComponent(TopNavBtnComponent component) {
    this.topNavBtnComponents.remove(component);
  }

  openNavList({@required TopNavRouterType navRouterType}) async {
    topNavBtnForwardAnimation();
    closeExpendComponent();
    await Future.delayed(Duration(milliseconds: animationDuration.inMilliseconds + 100));
  }

  void closeExpendComponent() {
    if (topNavExpendComponents.length == 0) {
      return;
    }
    TopNavExpendComponent closeExpendComponent =
        topNavExpendComponents.firstWhere(
            (element) => element.getTopNavRouterType() == currentTopNavRouter);
    if (closeExpendComponent != null) {
      closeExpendComponent.closeExpandNav();
    }
  }

  topNavBtnForwardAnimation() {
    aniState = NavBtnMediatorState.Open;
    this.topNavBtnComponents.forEach((element) {
      element.aniForward();
    });
  }

  @override
  closeNavList({@required TopNavRouterType navRouterType}) {
    this.topNavBtnReverseAnimation();
    if (_iNavBtnGroup != null) {
      _iNavBtnGroup.arrangeBtnIndexStack(top: navRouterType);
    }
    currentTopNavRouter = navRouterType;
    topNavExpendGroupViewModel.changeExpendWidget();
    openExpendComponent();
  }

  void openExpendComponent() {
    if (topNavExpendComponents.length == 0) {
      return;
    }
    var closeExpendComponent = topNavExpendComponents.firstWhere(
        (element) => element.getTopNavRouterType() == currentTopNavRouter,
        orElse: () => null);

    if (closeExpendComponent != null) {
      closeExpendComponent.openExpandNav();
    }
  }

  topNavBtnReverseAnimation() {
    aniState = NavBtnMediatorState.Close;
    this.topNavBtnComponents.forEach((element) {
      element.aniReverse();
    });
  }

  @override
  topNavExpendRegisterComponent(TopNavExpendComponent component) {
    topNavExpendComponents.add(component);
  }

  @override
  topNavExpendUnRegisterComponent(TopNavExpendComponent component) {
    topNavExpendComponents.remove(component);
  }

  @override
  void onNavBtnAniStatusListener(AnimationStatus status,TopNavRouterType routerType) {

  }

  @override
  void changeMainPage(CodeState topOnMoveMainPage) {
    if(codeMainViewModelInputPort != null){
      codeMainViewModelInputPort.jumpToPage(topOnMoveMainPage);
    }
  }

  @override
  CodeMainViewModelInputPort codeMainViewModelInputPort;

}

enum NavBtnMediatorState { Open, Close }
