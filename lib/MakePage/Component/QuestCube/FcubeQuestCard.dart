import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';

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
