import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

import '../ID001MainPage2ViewModel.dart';

class ID001AppBar extends StatelessWidget {
  const ID001AppBar({Key key, this.model}) : super(key: key);

  final ID001MainPage2ViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          IconButton(
            icon: Icon(ForutonaIcon.pointdash),
            iconSize: 13.0,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}