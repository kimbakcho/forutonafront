import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnAction.dart';

import 'package:forutonafront/MainPage/CodeMainPageController.dart';


class NavBtnSetDto {
  final double? startOffset;
  final double? endOffset;
  final double? btnSize;
  final Color? btnColor;
  final Icon? btnIcon;
  final CodeState? topOnMoveMainPage;
  final NavBtnAction? navBtnAction;

  NavBtnSetDto(
      {this.startOffset,
      this.endOffset,
      this.btnSize,
      this.btnColor,
      this.btnIcon,
      this.topOnMoveMainPage,
      this.navBtnAction});
}
