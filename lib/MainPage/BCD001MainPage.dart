import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MainPage/Component/BCD001NaviAnimationController.dart';
import 'package:forutonafront/globals.dart';

class BCD001MainPage extends StatefulWidget {
  BCD001MainPage({Key key}) : super(key: key);

  @override
  _BCD001MainPageState createState() => _BCD001MainPageState();
}

class _BCD001MainPageState extends State<BCD001MainPage> {
  BCD001NaviAnimationController navicontroller;
  Widget loginButton() {
    if (GlobalStateContainer.of(context).state.userInfoMain == null) {
      return FlatButton(
        onPressed: () {
          navicontroller.processValue = navicontroller.processValue - 0.5;
        },
        child: Text(
          "Log in",
          style: TextStyle(fontSize: 15),
        ),
      );
    } else {
      return Container(
          child: CircleAvatar(
        backgroundImage: GlobalStateContainer.of(context)
                    .state
                    .userInfoMain
                    .profilepicktureurl
                    .length ==
                0
            ? AssetImage("assets/basicprofileimage.png")
            : NetworkImage(GlobalStateContainer.of(context)
                .state
                .userInfoMain
                .profilepicktureurl),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    navicontroller = BCD001NaviAnimationController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: loginButton(),
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.satellite),
            onPressed: () {
              navicontroller.processValue = navicontroller.processValue + 0.5;
              print(navicontroller.processValue);
            },
          )
        ],
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 42,
          child: FlareActor(
            "assets/Rive/navi.flr",
            fit: BoxFit.contain,
            animation: "play",
            artboard: "navi",
            controller: navicontroller,
          ),
        ),
      ),
    );
  }
}
