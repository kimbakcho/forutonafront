import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserExpPointHistroy.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';

class IssueCubeResultView extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  IssueCubeResultView({Key key, this.fcubeextender1}) : super(key: key);

  @override
  _IssueCubeResultViewState createState() {
    return _IssueCubeResultViewState(fcubeextender1: fcubeextender1);
  }
}

class _IssueCubeResultViewState extends State<IssueCubeResultView>
    with AfterInitMixin {
  FcubeExtender1 fcubeextender1;
  _IssueCubeResultViewState({this.fcubeextender1});

  bool isloading = false;
  double makercubegetreviewpoint = 0;

  @override
  void didInitState() async {
    // TODO: implement didInitState
    isloading = true;
    setState(() {});
    makercubegetreviewpoint = await UserExpPointHistroy.getCubeuuidGetPoint(
        fcubeextender1.cubeuuid, "ReviewPoint");
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isloading
            ? CircularProgressIndicator()
            : Container(
                child: ListView(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text("조회수 = ${fcubeextender1.cubehits}"),
                        ),
                        Container(
                          child: Text(
                              "총 획득 경험치 = ${fcubeextender1.makeexp + makercubegetreviewpoint}"),
                        ),
                        Container(
                          child: Text("제작 경험치 = ${fcubeextender1.makeexp}"),
                        ),
                        Container(
                          child: Text("평가 경험치 = ${makercubegetreviewpoint}"),
                        )
                      ],
                    ),
                  )
                ],
              )));
  }
}
