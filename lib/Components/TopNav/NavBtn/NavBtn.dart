import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnComponent.dart';

import 'INavBtn.dart';
import 'NavBtnSetDto.dart';

// ignore: must_be_immutable
class NavBtn extends StatelessWidget implements INavBtn {
  final NavBtnSetDto navBtnSetDto;

  @override
  get routerType {
    return navBtnSetDto.routerType;
  }

  @override
  int originIndex;

  NavBtn({Key key,
    this.navBtnSetDto,
    this.originIndex})
      : super(key: Key(originIndex.toString()));

  @override
  Widget build(BuildContext context) {
    return NavBtnComponent(
      navBtnSetDto: navBtnSetDto
    );
  }

}
