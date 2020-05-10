

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/JCodePage/J013/J013View.dart';

class J012ViewModel extends ChangeNotifier{
  final BuildContext _context;
  TextEditingController idEditingController = new TextEditingController();
  bool isIdTextError = false;
  String idTextErrorText = "";
  J012ViewModel(this._context);


  void onBackTap() {
    Navigator.of(_context).pop();
  }

  bool isCanNextBtn() {
    if(idEditingController.text.length > 0){
      return true;
    }else {
      return false;
    }
  }

  onNextComplete() async{
    isIdTextError = false;
    idTextErrorText = "";
    await onIdEditComplete();
    if (!isIdTextError) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: idEditingController.text);
      Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>J013View(idEditingController.text)));
    }
  }

  void onIdEditChangeText(String value) {
    notifyListeners();
  }

  Future<void> onIdEditComplete() async {
    String id = idEditingController.text;
    var list =
    await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: id);
    if (!isEmailTypeValid()) {
      isIdTextError = true;
      idTextErrorText = "*이메일 형식이 맞지 않습니다.";
    } else if (list.length == 0) {
      isIdTextError = true;
      idTextErrorText = "*입력하신 정보와 일치하는 계정이 없습니다.";
    } else {
      isIdTextError = false;
      idTextErrorText = "";
    }
    notifyListeners();
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

}