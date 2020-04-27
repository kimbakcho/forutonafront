import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class IssueBallStyle2MarkerWidget {
  static selectBall() {
    return Container(
      width: 60,
      height: 60,
      child: Icon(ForutonaIcon.issue, color: Colors.white, size: 30),
      decoration: BoxDecoration(
        color: Color(0xffDC3E57),
        shape: BoxShape.circle
      ),
    );
  }
}
