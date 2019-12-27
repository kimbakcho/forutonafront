import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:intl/intl.dart';

class IssueCubeCard extends StatefulWidget {
  final FcubeExtender1 cubeitem;
  final FcubeTypeMakerImage fcubetypeiamge;
  IssueCubeCard({Key key, this.cubeitem, this.fcubetypeiamge})
      : super(key: key);

  @override
  _IssueCubeCardState createState() {
    return _IssueCubeCardState(this.cubeitem, this.fcubetypeiamge);
  }
}

class _IssueCubeCardState extends State<IssueCubeCard> {
  FcubeExtender1 cubeitem;
  FcubeTypeMakerImage fcubetypeiamge;
  _IssueCubeCardState(this.cubeitem, this.fcubetypeiamge);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(child: Text(cubeitem.cubename)),
          Row(children: <Widget>[
            Container(
              child: Text(cubeitem.nickname),
            ),
            Container(
              child: Text("${cubeitem.userlevel}"),
            )
          ]),
          Row(
            children: <Widget>[
              Container(
                child: Text("${cubeitem.cubelikes}"),
              ),
              Container(
                child: Text("${cubeitem.cubedislikes}"),
              ),
              Container(
                child: Text("댓글수"),
              ),
              Container(
                child: Text("${cubeitem.remindActiveTimetoString()}"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
