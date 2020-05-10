import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J007/J007View.dart';
import 'package:provider/provider.dart';

class J006ViewModel extends ChangeNotifier {
  final BuildContext _context;
  TextEditingController idEditingController = TextEditingController();
  TextEditingController pwEditingController = TextEditingController();
  TextEditingController pwCheckEditingController = TextEditingController();
  bool isIdTextError = false;
  String idTextErrorText = "";
  bool isPwTextError = false;
  String pwTextErrorText = "";
  bool isPwCheckTextError = false;
  String pwCheckTextErrorText = "";

  J006ViewModel(this._context);

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  bool isEmailTypeValid() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(idEditingController.text))
      return false;
    else
      return true;
  }


  bool isPwTypeValid() {
    String value = pwEditingController.text;
    RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
    RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
    RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
    RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
    int match1 = regExp1.hasMatch(value) ? 1 : 0;
    int match2 = regExp2.hasMatch(value) ? 1 : 0;
    int match3 = regExp3.hasMatch(value) ? 1 : 0;
    int match4 = regExp4.hasMatch(value) ? 1 : 0;
    if (value.length < 8) {
      return false;
    } else if (value.length > 16) {
      return false;
    } else if ((match1 + match2 + match3 + match4) < 3) {
      return false;
    } else {
      return true;
    }
  }

  String pwTypeValid() {
    String value = pwEditingController.text;
    RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
    RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
    RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
    RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
    int match1 = regExp1.hasMatch(value) ? 1 : 0;
    int match2 = regExp2.hasMatch(value) ? 1 : 0;
    int match3 = regExp3.hasMatch(value) ? 1 : 0;
    int match4 = regExp4.hasMatch(value) ? 1 : 0;
    if (value.length < 8) {
      return "패스워드가 8자리 이하 입니다.";
    } else if (value.length > 16) {
      return "패스워드가 16자리 이상 입니다.";
    } else if ((match1 + match2 + match3 + match4) < 3) {
      return "영문 소문자,대문자,숫자,특수문자 중 3개 이상 조합";
    } else {
      return "";
    }
  }

  bool isPwCheckTypeValid() {
    if(pwEditingController.text.length <8){
      return false;
    }
    if (pwEditingController.text != pwCheckEditingController.text) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> onIdEditComplete() async {
    String id = idEditingController.text;
    var list =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: id);
    if (!isEmailTypeValid()) {
      isIdTextError = true;
      idTextErrorText = "*이메일 형식이 맞지 않습니다.";
    } else if (list.length != 0) {
      isIdTextError = true;
      idTextErrorText = "*이미 존재하는 아이디 입니다.";
    } else {
      isIdTextError = false;
      idTextErrorText = "";
    }
    notifyListeners();
  }

  void onPwEditComplete() {
    if (!isPwTypeValid()) {
      isPwTextError = true;
      pwTextErrorText = pwTypeValid();
    } else {
      isPwTextError = false;
      pwTextErrorText = "";
    }
    notifyListeners();
  }

  void onPwCheckComplete() {
    if (pwEditingController.text != pwCheckEditingController.text) {
      isPwCheckTextError = true;
      pwCheckTextErrorText = "패스워드가 일치 하지 않습니다.";
    } else {
      isPwCheckTextError = false;
      pwCheckTextErrorText = "";
    }
    notifyListeners();
  }

  bool isCanNextBtn() {
    if (idEditingController.text.length > 0 &&
        pwEditingController.text.length > 0 &&
        pwCheckEditingController.text.length > 0) {
      return true;
    }else {
      return false;
    }
  }
  onNextComplete()async{
    await onIdEditComplete();
    onPwEditComplete();
    onPwCheckComplete();
    if(!isIdTextError && !isPwTextError && !isPwCheckTextError){
      GlobalModel globalModel = Provider.of(_context,listen: false);
      globalModel.fUserInfoJoinReqDto.password = pwEditingController.text;
      globalModel.fUserInfoJoinReqDto.email = idEditingController.text;
      Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>J007View()));
    }
  }

  void onIdEditChangeText(String value) {
    notifyListeners();
  }

  void onPwCheckEditChangeText(String value) {
    notifyListeners();
  }

  void onPwEditChangeText(String value) {
    notifyListeners();
  }
}
