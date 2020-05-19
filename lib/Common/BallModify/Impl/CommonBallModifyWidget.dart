import 'package:flutter/material.dart';
import 'package:forutonafront/Common/BallModify/Impl/CommonBallModifyWidgetResultType.dart';

class CommonBallModifyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  color: Colors.white,
                  child: Column(children: <Widget>[
                    Container(
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        onPressed: () {
                          Navigator.of(context).pop(CommonBallModifyWidgetResultType.Update);
                        },
                        child: Row(children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          Container(child: Text("수정하기"))
                        ]),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffF5F5F5), width: 1))),
                    ),
                    Container(
                      child: FlatButton(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          onPressed: () {
                            Navigator.of(context).pop(CommonBallModifyWidgetResultType.Delete);
                          },
                          child: Row(children: <Widget>[
                            Icon(Icons.delete, color: Colors.black),
                            Container(
                              child: Text("삭제하기"),
                            )
                          ])),
                    )
                  ])))
        ],
      ),
    );
  }
}
