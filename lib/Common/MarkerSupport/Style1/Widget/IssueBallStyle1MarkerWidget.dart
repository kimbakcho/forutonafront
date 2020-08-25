import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class IssueBallStyle1MarkerWidget {
  static Widget selectBall() {
    return Container(
        height: 120,
        width: 120,
        child: Container(
          padding: EdgeInsets.only(left: 7,bottom: 22),
          child: Icon(
            ForutonaIcon.issue,
            color: Colors.white,
            size: 50,
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/MarkesImages/issueselectballmaker.png"),
                  fit: BoxFit.fitWidth)),
        ));
  }
  static Widget unSelectBall() {
    return Container(
        height: 60,
        width: 60,
        child: Icon(ForutonaIcon.issue, color: Colors.white, size: 30),
        decoration: BoxDecoration(
          color: Color(0xffdc3e57),
          border: Border.all(
            width: 0.50,
            color: Color(0xffab3245),
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
