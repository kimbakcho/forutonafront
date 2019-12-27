import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:intl/intl.dart';

class QuestCubeCard extends StatefulWidget {
  final FcubeExtender1 cubeitem;
  final FcubeTypeMakerImage fcubetypeiamge;
  QuestCubeCard({Key key, @required this.cubeitem, this.fcubetypeiamge})
      : super(key: key);

  @override
  _QuestCubeCardState createState() {
    return _QuestCubeCardState(this.cubeitem,
        fcubetypeiamge: this.fcubetypeiamge);
  }
}

class _QuestCubeCardState extends State<QuestCubeCard> {
  FcubeExtender1 cubeitem;
  FcubeTypeMakerImage fcubetypeiamge;
  _QuestCubeCardState(this.cubeitem, {this.fcubetypeiamge});

  @override
  Widget build(BuildContext context) {
    String makeitme = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(cubeitem.maketime).add(Duration(hours: 9)));
    String activetime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(cubeitem.activationtime.add(Duration(hours: 9)));
    List<String> imagelist = new List();
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
    }
    String mainImage;
    double calcheight = 0;
    if (imagelist.length > 0) {
      mainImage = imagelist.first;
    } else {
      calcheight = 0.25;
    }

    return Container(
      height: MediaQuery.of(context).size.height * (0.6 - calcheight),
      child: FlatButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: "FcubeQuestDetailPage"),
                  builder: (context) {
                    return FcubeQuestDetailPage(fcubeextender1: cubeitem);
                  }));
        },
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  fcubetypeiamge.iconImage[cubeitem.cubetype] == null
                      ? Container()
                      : fcubetypeiamge.iconImage[cubeitem.cubetype],
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment(-1, 0),
                              child: Text(cubeitem.cubename)),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(cubeitem.placeaddress),
                              ),
                              Text("${cubeitem.distancewithme.round()} m")
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(cubeitem.profilepicktureurl),
                    maxRadius: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment(-1, 0),
                          child: Text(cubeitem.nickname),
                        ),
                        Container(
                            alignment: Alignment(-1, 0), child: Text(makeitme)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * (0.25 - calcheight),
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(onPressed: () {}, child: Text("완료 조건")),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(child: Text("${cubeitem.pointreward}")),
                ),
                Expanded(
                    child:
                        Container(child: Text("${cubeitem.influencereward}"))),
                Expanded(
                  child: Container(child: Text("${activetime}")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
