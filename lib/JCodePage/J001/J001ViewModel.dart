import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/ForutonaUser/Service/FaceBookLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';
import 'package:forutonafront/JCodePage/J002/J002View.dart';
import 'package:forutonafront/JCodePage/JCodeMainPageViewModel.dart';

class J001ViewModel extends ChangeNotifier {
  BuildContext _context;
  JCodeMainPageViewModel _jCodeMainPageViewModel;
  TextEditingController idTextFieldController = TextEditingController();
  TextEditingController pwTextFieldController = TextEditingController();
  FocusNode idTextFocusNode = FocusNode();
  FocusNode pwTextFocusNode = FocusNode();

  J001ViewModel(this._context) {
    idTextFieldController.addListener(onIdTextFieldController);
    pwTextFieldController.addListener(onPwTextFieldController);
    idTextFocusNode.addListener(onIdTextFocusNode);
    pwTextFocusNode.addListener(onPwTextFocusNode);
  }

  onIdTextFocusNode() {
    notifyListeners();
  }

  onPwTextFocusNode() {
    notifyListeners();
  }

  onIdTextFieldController() {
    notifyListeners();
  }

  onPwTextFieldController() {
    notifyListeners();
  }

  isActiveButton() {
    if (idTextFieldController.text.length > 0 &&
        pwTextFieldController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  onLoginBtnClick() async {
    bool errorCheck = false;
    String errorText = "";
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: idTextFieldController.text,
              password: pwTextFieldController.text);
      var idTokenResult = await authResult.user.getIdToken(refresh: true);
    } catch (value) {
      errorCheck = true;
      PlatformException exCode = value as PlatformException;
      Fluttertoast.showToast(
          msg: fireBaseLoginErrorMessageLangChage(exCode.message),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  fireBaseLoginErrorMessageLangChage(String message) {
    if (message == "The email address is badly formatted.") {
      return "아이디가 이메일 형식이 아닙니다";
    } else if (message ==
        "There is no user record corresponding to this identifier. The user may have been deleted.") {
      return "아이디가 없거나 패스워드가 틀렸습니다.";
    } else if (message ==
        "The password is invalid or the user does not have a password.") {
      return "아이디가 없거나 패스워드가 틀렸습니다.";
    } else if (message == "An internal error has occurred. [ 7: ]") {
      return "네트워크 접속에 실패했습니다. 네트워크 연결 상태를 확인해주세요.";
    } else {
      return message;
    }
  }

  void onFaceBookLogin() async{
    SnsLoginService snsLoginService = new FaceBookLoginService();
    try{
      await snsLoginService.tryLogin();
    }catch(value){
      if(value == "not join User"){
        print("가입하지 않은 유저");
        Navigator.of(_context).push(MaterialPageRoute(
          builder: (context){
            return J002View();
          },
          settings: RouteSettings(name: "/J002")
        ));

      }else {
        Fluttertoast.showToast(
            msg: value.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Color(0xff454F63),
            textColor: Colors.white,
            fontSize: 12.0);
      }
    }


  }


}
