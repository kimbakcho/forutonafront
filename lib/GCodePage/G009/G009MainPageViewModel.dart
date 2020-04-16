import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/GCodePage/G010/G010MainPage.dart';
import 'package:forutonafront/GCodePage/G011/G011MainPage.dart';
import 'package:forutonafront/GCodePage/G015/G015MainPage.dart';

class G009MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;

  G009MainPageViewModel(this._context);

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void goAccountSettingPage() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => G010MainPage(), settings: RouteSettings(name: "G010")));
  }

  void goSecurityPage() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => G011MainPage(), settings: RouteSettings(name: "G011")));
  }

  void logout() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser.uid.indexOf("Kakao") == 0) {
      if (await FlutterKakaoLogin().isLoggedIn) {
        await FlutterKakaoLogin().logOut();
      }
    }
    if (firebaseUser.uid.indexOf("Naver") == 0) {
      await FlutterNaverLogin.logOut();
    }
    if (firebaseUser.uid.indexOf("Facebook") == 0) {
      await FacebookLogin().logOut();
    }
    await FirebaseAuth.instance.signOut();
    Navigator.of(_context).popUntil(ModalRoute.withName('/'));
  }

  void goAlramSettingPage() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => G015MainPage(), settings: RouteSettings(name: "G015")));
  }
}
