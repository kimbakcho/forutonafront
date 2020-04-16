import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/GCodePage/G012/G012MainPage.dart';

class G011MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;

  G011MainPageViewModel(this._context);

  void onBackBtnTap() {
    Navigator.of(_context).pop();
  }

  void goResetPwPage() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser.uid.indexOf("Kakao")==0){
      Fluttertoast.showToast(
          msg: "Kakao 계정에서 변경해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return;
    }
    if(firebaseUser.uid.indexOf("Naver")==0){
      Fluttertoast.showToast(
          msg: "Naver 계정에서 변경해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return;
    }
    if(firebaseUser.uid.indexOf("Facebook")==0){
      Fluttertoast.showToast(
          msg: "Facebook 계정에서 변경해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return;
    }

    Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_) => G012MainPage()));
  }
}
