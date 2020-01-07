import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:forutonafront/MainPage.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlareActor(
        "assets/Rive/KvuSplash.flr",
        alignment: Alignment.center,
        animation: "initAni",
        callback: (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(isInitialRoute: true, name: "/"),
                  builder: (context) {
                    return MainPage();
                  }));
        },
      ),
    );
  }
}
