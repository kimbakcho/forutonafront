import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/IssueCubeDetailPage.dart';
class IssueCollapsed extends StatefulWidget {
  final FcubeExtender1 cubeitem;
  final Function cubeclickevent;
  IssueCollapsed({Key key, this.cubeitem, this.cubeclickevent})
      : super(key: key);

  @override
  _IssueCollapsedState createState() {
    return _IssueCollapsedState(this.cubeitem, this.cubeclickevent);
  }
}

class _IssueCollapsedState extends State<IssueCollapsed> {
  FcubeExtender1 cubeitem;
  Function cubeclickevent;
  _IssueCollapsedState(this.cubeitem, this.cubeclickevent);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: FlatButton(
        onPressed: () {
          cubeclickevent(cubeitem);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return IssueCubeDetailPage(fcubeextender1: cubeitem);
          }));
        },
        child: Column(
          children: <Widget>[
            Container(child: Text(cubeitem.cubename)),
            Row(children: <Widget>[
              Container(
                child: Text("닉네임 = ${cubeitem.nickname}"),
              ),
              Container(
                child: Text("레벨 = ${cubeitem.userlevel}"),
              )
            ]),
            Row(
              children: <Widget>[
                Container(
                  child: Text("좋아요 = ${cubeitem.cubelikes}"),
                ),
                Container(
                  child: Text("싫어요 = ${cubeitem.cubedislikes}"),
                ),
                Container(
                  child: Text("댓글수"),
                ),
              ],
            ),
            Container(
              child: Text("남은 시간 = ${cubeitem.remindActiveTimetoString()}"),
            ),
          ],
        ),
      ),
    );
  }
}
