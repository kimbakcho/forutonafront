import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class QuestBallStyle1MarkerWidget {
  static Widget selectBall() {
    return Container(
        height: 90,
        width: 90,
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          child: Icon(
            ForutonaIcon.quest,
            color: Colors.white,
            size: 35,
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/MarkesImages/questselectballmaker.png"),
                  fit: BoxFit.fitWidth)),
        ));
  }

  static Widget unSelectBall() {
    return Container(
        height: 60,
        width: 60,
        child: Icon(ForutonaIcon.quest, color: Colors.white, size: 25),
        decoration: BoxDecoration(
          color: Color(0xff4f72ff),
          border: Border.all(
            width: 0.50,
            color: Color(0xff0032fc),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff454f63).withOpacity(0.23),
              blurRadius: 6,
            ),
          ],
          shape: BoxShape.circle,
        ));
  }
}
