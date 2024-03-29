import 'package:flutter/material.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import '../TopNavBtnMediator.dart';

abstract class TopNavExpendComponent {
  TopNavBtnMediator? topNavBtnMediator;
  CodeMainPageController? codeMainPageController;
  openExpandNav();
  closeExpandNav();
  getTopNavRouterType();
  getAnimation(BuildContext context);
}