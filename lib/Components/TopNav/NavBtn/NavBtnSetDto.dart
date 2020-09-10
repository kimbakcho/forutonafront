import 'package:flutter/material.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';

import '../TopNavRouterType.dart';

class NavBtnSetDto {
  final double startOffset;
  final double endOffset;
  final double btnSize;
  final Color btnColor;
  final Icon btnIcon;
  final TopNavRouterType routerType;
  final CodeState topOnMoveMainPage;

  NavBtnSetDto(
      {this.startOffset,
      this.endOffset,
      this.btnSize,
      this.btnColor,
      this.btnIcon,
      this.routerType,
      this.topOnMoveMainPage});
}
