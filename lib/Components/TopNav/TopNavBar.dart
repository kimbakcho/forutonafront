import 'package:flutter/material.dart';

import 'TopNavBtnGroup/TopNavBtnGroup.dart';



class TopNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 3, 16, 10),
      child: Stack(
        children: <Widget>[
          NavBtnGroup()
        ],
      )
    );
  }
}
