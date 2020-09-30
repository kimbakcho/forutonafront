import "package:flare_flutter/flare_actor.dart";
import 'package:flutter/material.dart';
import 'package:forutonafront/MainPage/CodeMainpage.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return FlareActor("assets/Rive/KvuSplash.flr",
        alignment: Alignment.center,
        animation: "initAni", callback: (value) async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "MAIN"),
              builder: (context) {
                return CodeMainPage();
              }));
    });
  }
}
