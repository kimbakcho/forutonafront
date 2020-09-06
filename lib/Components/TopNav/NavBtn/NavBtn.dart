import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavComponent.dart';

import 'INavBtn.dart';
import 'NavBtnSetDto.dart';

// ignore: must_be_immutable
class NavBtn extends StatelessWidget implements INavBtn {
  final NavBtnSetDto navBtnSetDto;

  @override
  String btnName;

  @override
  int originIndex;

  NavBtn({Key key,
    this.navBtnSetDto,
    this.btnName,
    this.originIndex})
      : super(key: Key(originIndex.toString()));

  @override
  Widget build(BuildContext context) {
    return NavComponent(
      navBtnSetDto: navBtnSetDto
    );
  }

}
