import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnComponent.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import '../TopNavBtnMediator.dart';
import 'INavBtn.dart';
import 'NavBtnSetDto.dart';

// ignore: must_be_immutable
class NavBtn extends StatelessWidget implements INavBtn {
  final NavBtnSetDto? navBtnSetDto;
  final TopNavBtnMediator? navBtnMediator;
  final CodeMainPageController? codeMainPageController;

  @override
  get routerType {
    return navBtnSetDto!.topOnMoveMainPage;
  }

  @override
  int? originIndex;

  NavBtn(
      {Key? key,
      required this.navBtnSetDto,
      required this.originIndex,
      required this.navBtnMediator,
      required this.codeMainPageController})
      : super(key: Key(originIndex.toString()));

  @override
  Widget build(BuildContext context) {
    return NavBtnComponent(
      codeMainPageController: codeMainPageController,
      navBtnSetDto: navBtnSetDto,
      navBtnMediator: navBtnMediator,
    );
  }
}
