import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/Fcubecontent.dart';

class FcubeMakeDetail1View extends StatefulWidget {
  final Fcube selectionfcube;
  FcubeMakeDetail1View({Key key, this.selectionfcube}) : super(key: key);

  @override
  _FcubeMakeDetail1ViewState createState() {
    return _FcubeMakeDetail1ViewState(selectionfcube);
  }
}

class _FcubeMakeDetail1ViewState extends State<FcubeMakeDetail1View> {
  final Fcube selectionfcube;
  _FcubeMakeDetail1ViewState(this.selectionfcube);
  TextEditingController cubenamecontroller = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  var _fcubeMakeDetail1ViewState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _fcubeMakeDetail1ViewState,
        appBar: AppBar(
          title: Text("Cube 작성"),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value.length < 2) {
                      return "제목이 너무 짧습니다.";
                    }
                    return null;
                  },
                  controller: cubenamecontroller,
                  decoration: InputDecoration(hintText: "제목을 입력해주세요"),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value.length < 2) {
                      return "메세지가 너무 짧습니다..";
                    }
                    return null;
                  },
                  controller: messagecontroller,
                  decoration: InputDecoration(hintText: "메세지를 입력해주세요."),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: RaisedButton(
                    onPressed: () async {
                      selectionfcube.cubestate = 1;
                      if (_formkey.currentState.validate()) {
                        selectionfcube.cubename = cubenamecontroller.text;
                        int result = await selectionfcube.makecube();
                        if (result == 0) {
                          SnackBar snackBar = SnackBar(
                            content: Text("설치에 실패 했습니다."),
                            duration: Duration(seconds: 1),
                          );
                          _fcubeMakeDetail1ViewState.currentState
                              .showSnackBar(snackBar);
                          return;
                        }
                        List<Fcubecontent> contents = List<Fcubecontent>();
                        contents.add(Fcubecontent(
                            cubeuuid: selectionfcube.cubeuuid,
                            contentvalue: messagecontroller.text,
                            contenttype: "Message"));
                        int reslutconent =
                            await Fcubecontent.makecubecontents(contents);
                        if (reslutconent == 1) {
                          SnackBar snackBar = SnackBar(
                            content: Text("설치에 성공."),
                            duration: Duration(seconds: 1),
                          );
                          _fcubeMakeDetail1ViewState.currentState
                              .showSnackBar(snackBar);
                          Navigator.popUntil(context,
                              ModalRoute.withName('/GoogleMapsMakeView'));
                        } else {
                          SnackBar snackBar = SnackBar(
                            content: Text("설치에 실패."),
                            duration: Duration(seconds: 1),
                          );
                          _fcubeMakeDetail1ViewState.currentState
                              .showSnackBar(snackBar);
                          Navigator.popUntil(context,
                              ModalRoute.withName('/GoogleMapsMakeView'));
                        }
                      }
                    },
                    child: Text("박스 추가"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
