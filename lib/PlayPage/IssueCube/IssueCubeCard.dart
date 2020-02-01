import 'dart:convert';

import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';

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

class _IssueCubeCardState extends State<IssueCubeCard> with AfterInitMixin {
  FcubeExtender1 cubeitem;
  FcubeTypeMakerImage fcubetypeiamge;
  _IssueCubeCardState(this.cubeitem, this.fcubetypeiamge);
  List<String> imagelist = new List();
  String mainImage;
  double calcheight = 0;

  @override
  void didInitState() {
    if (cubeitem.contenttype == FcubecontentType.description) {
      String descriptionjson =
          json.decode(cubeitem.contentvalue)["description"];
      List<dynamic> description = json.decode(descriptionjson);
      description.forEach((value) {
        Map values = value as Map;
        values.keys.forEach((key) {
          if (key == "attributes") {
            if (value[key]["embed"]["type"] == "image") {
              imagelist.add(value[key]["embed"]["source"]);
            }
          }
        });
      });
      if (imagelist.length > 0) {
        mainImage = imagelist.first;
      } else {
        calcheight = 0.25;
      }
    }
  }

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
              Container(
                height:
                    MediaQuery.of(context).size.height * (0.25 - calcheight),
                child: Stack(
                  children: <Widget>[
                    mainImage != null
                        ? Image(image: NetworkImage(mainImage))
                        : Container(),
                    imagelist.length > 2
                        ? Positioned(
                            bottom: 0,
                            right: 10,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text("+ ${imagelist.length - 1}"),
                            ),
                          )
                        : Container()
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
