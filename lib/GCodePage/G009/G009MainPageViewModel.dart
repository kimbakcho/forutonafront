import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';
import 'package:forutonafront/GCodePage/G010/G010MainPage.dart';
import 'package:forutonafront/GCodePage/G011/G011MainPage.dart';
import 'package:forutonafront/GCodePage/G015/G015MainPage.dart';
import 'package:forutonafront/GCodePage/G016/G016MainPage.dart';
import 'package:forutonafront/GCodePage/G019/G019MainPage.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/MainPage/CodeMainpage.dart';
import 'package:provider/provider.dart';

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

    GlobalModel globalModel = Provider.of(_context, listen: false);
    globalModel.setFUserInfoDto();
//    Navigator.of(_context).popUntil(ModalRoute.withName('/'));
    Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
            settings:
            RouteSettings(name: "/"),
            builder: (context) {
              return CodeMainpage();
            }),
        ModalRoute.withName('/')
    );
  }

  void goAlarmSettingPage() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => G015MainPage(), settings: RouteSettings(name: "G015")));
  }

  void goNoticePage() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => G016MainPage(), settings: RouteSettings(name: "G016")));
  }

  void goCustomCenter() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => G019MainPage(), settings: RouteSettings(name: "G019")));
  }

  bool isForutonaUser(){
    GlobalModel globalModel = Provider.of(_context,listen: false);
    if(globalModel.fUserInfoDto.snsService ==SnsSupportService.Forutona){
      return true;
    }else {
      return false;
    }
  }
}
