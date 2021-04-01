import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class QuestBallStyle2MarkerWidget {
  static selectBall(){
    return Container(
      width: 60,
      height: 60,
      child: Icon(ForutonaIcon.quest, color: Colors.white, size: 30),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle
      ),
    );
  }
}