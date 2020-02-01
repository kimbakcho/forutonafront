import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:intl/intl.dart';

class QuestCollapsed extends StatefulWidget {
  final FcubeExtender1 cubeitem;
  final Function cubeclickevent;
  QuestCollapsed({Key key, @required this.cubeitem, this.cubeclickevent})
      : super(key: key);

  @override
  _QuestCollapsedState createState() {
    return _QuestCollapsedState(this.cubeitem, this.cubeclickevent);
  }
}

class _QuestCollapsedState extends State<QuestCollapsed> {
  FcubeExtender1 cubeitem;
  Function cubeclickevent;
  _QuestCollapsedState(this.cubeitem, this.cubeclickevent);

  @override
  Widget build(BuildContext context) {
    String makeitme = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(cubeitem.maketime).add(Duration(hours: 9)));
    return Container(
        margin: EdgeInsets.all(20),
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: FlatButton(
          onPressed: () async {
            cubeclickevent(cubeitem);
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
                child: Text("${cubeitem.cubename}"),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("${cubeitem.nickname}"),
                    ),
                  ),
                  Container(
                    child: Text(makeitme),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("${cubeitem.influencereward}"),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
