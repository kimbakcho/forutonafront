import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';

import 'package:provider/provider.dart';

import 'FBallReplyModifyViewModel.dart';
import 'FBallReplyPopupUseCaseInputPort.dart';

class FBallReplyModifyView extends StatelessWidget {
  final FBallReply _fBallReply;
  final FBallReplyMediator _fBallReplyMediator;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;
  FBallReplyModifyView(this._fBallReply,this._fBallReplyMediator,this._fBallReplyPopupUseCaseInputPort);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallReplyModifyViewModel(
          context: context,
          fBallReplyMediator: _fBallReplyMediator,
          fBallReply: _fBallReply,
          fBallReplyPopupUseCaseInputPort: _fBallReplyPopupUseCaseInputPort
        ),
        child: Consumer<FBallReplyModifyViewModel>(builder: (_, model, child) {
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
                              model.replyUpdatePopup();
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
                                model.deleteAction();
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
          ));
        }));
  }
}
