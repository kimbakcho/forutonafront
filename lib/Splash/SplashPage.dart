import 'package:firebase_auth/firebase_auth.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:flutter/material.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/LoginPage/A000LoginPageView.dart';
import 'package:forutonafront/MainPage/BCD001MainPage.dart';
import 'package:forutonafront/Splash/SplashPageModel.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashPageModel(),
      child: Container(
        color: Colors.white,
        child: Consumer<SplashPageModel>(builder: (_, model, child) {
          return FlareActor(
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
                Provider.of<GlobalModel>(context,listen: false).fUserInfoDto = await model.getFUserInfoDto();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings:
                            RouteSettings(isInitialRoute: true, name: "HCODE"),
                        builder: (context) {
                          return BCD001MainPage();
                        }));
              }
            },
          );
        }),
      ),
    );
  }
}
