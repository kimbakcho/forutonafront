import 'package:after_init/after_init.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/A000LoginPageView.dart';
import 'package:forutonafront/MainPage/BCD001MainPage.dart';
import 'package:forutonafront/MainPage/HCodeMainpage.dart';
import 'package:forutonafront/globals.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlareActor(
        "assets/Rive/KvuSplash.flr",
        alignment: Alignment.center,
        animation: "initAni",
        callback: (value) async {
          FirebaseUser user = await _auth.currentUser();
          if (user == null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "A000"),
                    builder: (context) {
                      return A000LoginPageView();
                    }));
          } else {
            GlobalStateContainer.of(context).state.userInfoMain =
                await UserInfoMain.getUserInfoMain(user);
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings:
                        RouteSettings(isInitialRoute: true, name: "HCODE"),
                    builder: (context) {
                      return HCodeMainpage();
                    }));
          }
        },
      ),
    );
  }
}
