

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/PwFindValid/PwFindValidService.dart';
import 'package:forutonafront/Common/SignValid/PwFindValidImpl/PwFindValidImpl.dart';
import 'package:forutonafront/JCodePage/J013/J013View.dart';

class J012ViewModel extends ChangeNotifier{
  final BuildContext _context;
  TextEditingController idEditingController = new TextEditingController();

  J012ViewModel(this._context);
  bool _idEditCompleteFlag = false;
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }
  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  PwFindValidService _pwFindValidService = PwFindValidImpl();


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
    _idEditCompleteFlag = true;
    _setIsLoading(true);
    await _pwFindValidService.emailIdValid(idEditingController.text);
    if (!_pwFindValidService.hasEmailError()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: idEditingController.text);
      Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>J013View(idEditingController.text)));
    }
    _setIsLoading(false);
  }

  void onIdEditChangeText(String value) {
    _idEditCompleteFlag = false;
    notifyListeners();
  }

  Future<void> onIdEditComplete() async {
    _idEditCompleteFlag = true;
    await _pwFindValidService.emailIdValid(idEditingController.text);
    notifyListeners();
  }
  bool hasEmailError(){
      return _pwFindValidService.hasEmailError();
  }
  String emailErrorText(){
    if(_idEditCompleteFlag){
      return _pwFindValidService.emailErrorText();
    }else {
      return "";
    }

  }


}