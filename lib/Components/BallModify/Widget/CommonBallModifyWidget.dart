import 'package:flutter/material.dart';
import 'CommonBallModifyWidgetResultType.dart';
import 'DeletePopupWidget.dart';

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
                          onPressed: () async {
                            CommonBallModifyWidgetResultType commandResult = await showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                transitionDuration: Duration(milliseconds: 300),
                                barrierColor: Colors.black.withOpacity(0.3),
                                barrierLabel:
                                MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                pageBuilder:
                                    (_context, Animation animation, Animation secondaryAnimation) {
                                  return DeletePopupWidget();
                                });
                            Navigator.of(context).pop(commandResult);
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
