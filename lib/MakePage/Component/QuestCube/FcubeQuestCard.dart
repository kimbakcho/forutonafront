import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:zefyr/zefyr.dart';

class FcubeQuestStartCubeDialog extends StatefulWidget {
  final Fcubecontent startCubecontent;
  FcubeQuestStartCubeDialog({Key key, @required this.startCubecontent})
      : super(key: key);

  @override
  _FcubeQuestStartCubeDialogState createState() {
    return _FcubeQuestStartCubeDialogState(this.startCubecontent);
  }
}

class _FcubeQuestStartCubeDialogState extends State<FcubeQuestStartCubeDialog> {
  Fcubecontent startCubecontent;
  _FcubeQuestStartCubeDialogState(this.startCubecontent);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(StartCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("스타팅 큐브"),
              ),
              Container(
                child: Text("스타팅 큐브 설명"),
              ),
              Container(
                  child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              )),
            ])));
  }
}

class FcubeQuestFinishcubeDialog extends StatefulWidget {
  final Fcubecontent finishCubecontent;
  FcubeQuestFinishcubeDialog({Key key, @required this.finishCubecontent})
      : super(key: key);

  @override
  _FcubeQuestFinishcubeDialogState createState() {
    return _FcubeQuestFinishcubeDialogState(this.finishCubecontent);
  }
}

class _FcubeQuestFinishcubeDialogState
    extends State<FcubeQuestFinishcubeDialog> {
  Fcubecontent finishCubecontent;
  _FcubeQuestFinishcubeDialogState(this.finishCubecontent);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(FinishCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("피니싱 큐브"),
              ),
              Container(
                child: Text("피니싱 큐브 설명"),
              ),
              Container(
                  child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              )),
            ])));
  }
}

class FcubeQuestMesssagecubeDialog extends StatefulWidget {
  final String messageCubecontent;
  FcubeQuestMesssagecubeDialog({Key key, @required this.messageCubecontent})
      : super(key: key);

  @override
  _FcubeQuestMesssagecubeDialogState createState() {
    return _FcubeQuestMesssagecubeDialogState(this.messageCubecontent);
  }
}

class _FcubeQuestMesssagecubeDialogState
    extends State<FcubeQuestMesssagecubeDialog> {
  _FcubeQuestMesssagecubeDialogState(this.messageCubecontent);
  String messageCubecontent;
  CubeMakeRichTextEdit richtextview;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
      jsondata: messageCubecontent,
      zefyrMode: ZefyrMode.view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(MessageCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("메세지 큐브"),
              ),
              Container(
                child: Text("메시지 큐브 설명"),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      int result = await showDialog(
                          context: (context),
                          barrierDismissible: false,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: richtextview,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.undo),
                                          onPressed: () {
                                            Navigator.pop(context, 0);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context, 1);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          });
                      if (result == 1) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.library_books),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              )),
            ])));
    ;
  }
}

class FcubeQuestCheckincubeDialog extends StatefulWidget {
  FcubeQuestCheckincubeDialog({Key key, @required this.checkinCubecontent})
      : super(key: key);
  final String checkinCubecontent;
  @override
  _FcubeQuestCheckincubeDialogState createState() {
    return _FcubeQuestCheckincubeDialogState(this.checkinCubecontent);
  }
}

class _FcubeQuestCheckincubeDialogState
    extends State<FcubeQuestCheckincubeDialog> {
  _FcubeQuestCheckincubeDialogState(this.checkinCubecontent);
  String checkinCubecontent;
  CubeMakeRichTextEdit richtextview;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
      jsondata: checkinCubecontent,
      zefyrMode: ZefyrMode.view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(CheckinCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("체크인 큐브"),
              ),
              Container(
                child: Text("체크인 큐브 설명"),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      int result = await showDialog(
                          context: (context),
                          barrierDismissible: false,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: richtextview,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.undo),
                                          onPressed: () {
                                            Navigator.pop(context, 0);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context, 1);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          });
                      if (result == 1) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.library_books),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              )),
            ])));
  }
}
