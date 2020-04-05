import 'package:firebase_auth/firebase_auth.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/LoginPage/A000LoginPageView.dart';
import 'package:forutonafront/MainPage/CodeMainpage.dart';
import 'package:forutonafront/Splash/SplashPageViewModel.dart';
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
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: false);
    return ChangeNotifierProvider(
        create: (_) => SplashPageViewModel(context),
        child: Container(
          color: Colors.white,
          child: Consumer<SplashPageViewModel>(builder: (_, model, child) {
            return FlareActor("assets/Rive/KvuSplash.flr",
                alignment: Alignment.center,
                animation: "initAni", callback: (value) async {
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
                await model.getFUserInfoDto();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings:
                            RouteSettings(isInitialRoute: true, name: "HCODE"),
                        builder: (context) {
                          return CodeMainpage();
                        }));
              }
            });
          }),
        ));
  }
}