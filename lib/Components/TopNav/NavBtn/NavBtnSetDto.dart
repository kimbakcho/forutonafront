import 'package:flutter/material.dart';

import '../TopNavRouterType.dart';

class NavBtnSetDto {
  final double startOffset;
  final double endOffset;
  final double btnSize;
  final Duration duration;
  final Color btnColor;
  final Icon btnIcon;
  final TopNavRouterType routerType;

  NavBtnSetDto(
      {this.startOffset, this.endOffset, this.btnSize, this.duration, this.btnColor, this.btnIcon,this.routerType});
}