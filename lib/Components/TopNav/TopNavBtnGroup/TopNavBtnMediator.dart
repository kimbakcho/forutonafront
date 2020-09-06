import 'package:flutter/cupertino.dart';

import 'INavBtnGroup.dart';
import 'TopNavBtnComponent.dart';

abstract class TopNavBtnMediator {
  registerComponent(TopNavBtnComponent component);

  unRegisterComponent(TopNavBtnComponent component);
  openNavList({@required String navBtnName});
  closeNavList();
  set iNavBtnGroup(INavBtnGroup value);
  NavBtnMediatorState aniState;
}

class TopNavBtnMediatorImpl implements TopNavBtnMediator{

  List<TopNavBtnComponent> components = [];

  @override
  NavBtnMediatorState aniState;

  INavBtnGroup _iNavBtnGroup;

  TopNavBtnMediatorImpl(){
    aniState = NavBtnMediatorState.Close;
  }

  set iNavBtnGroup(INavBtnGroup value) {
    _iNavBtnGroup = value;
  }

  @override
  registerComponent(TopNavBtnComponent component){
    this.components.add(component);
  }

  @override
  unRegisterComponent(TopNavBtnComponent component) {
    this.components.remove(component);
  }

  openNavList({@required String navBtnName}){
    forwardAnimation();
    if(_iNavBtnGroup != null) {
      _iNavBtnGroup.arrangeBtnIndexStack(top: navBtnName);
    }
  }

  forwardAnimation() {
    aniState = NavBtnMediatorState.Open;
    this.components.forEach((element) {
      element.aniForward();
    });
  }

  @override
  closeNavList() {
    this.reverseAnimation();
  }

  reverseAnimation() {
    aniState = NavBtnMediatorState.Close;
    this.components.forEach((element) {
      element.aniReverse();
    });
  }
}
enum NavBtnMediatorState {
  Open,Close
}