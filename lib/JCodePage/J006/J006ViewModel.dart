import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidUseCaseInputPort.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/IdDuplicationCheckSignValidUseCase.dart';

import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J007/J007View.dart';
import 'package:provider/provider.dart';

class J006ViewModel extends ChangeNotifier {
  final BuildContext _context;
  TextEditingController idEditingController = TextEditingController();
  TextEditingController pwEditingController = TextEditingController();
  TextEditingController pwCheckEditingController = TextEditingController();
  SignUpValidUseCaseInputPort _signValidService = IdDuplicationCheckSignValidUseCase();
  bool hasIdComplete = false;

  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
  J006ViewModel(this._context);
  void onBackTap() {
    Navigator.of(_context).pop();
  }
  Future<void> onIdEditComplete() async {
    _setIsLoading(true);
    hasIdComplete= true;
    await _signValidService.emailIdValid(idEditingController.text);
    _setIsLoading(false);
  }
  hasEmailError() {
     return _signValidService.hasEmailError();
  }
  String emailErrorText() {
    if(hasIdComplete){
      return _signValidService.emailErrorText();
    }else {
      return "";
    }
  }
  hasPwCheckError() {
    if(pwCheckEditingController.text.length > 0){
      return _signValidService.hasPwCheckError();
    }else {
      return true;
    }
  }
  void onPwEditComplete() {
    _signValidService.pwValid(pwEditingController.text);
    notifyListeners();
  }
  hasPwError() {
      return _signValidService.hasPwError();
  }
  String pwErrorText() {
    return _signValidService.pwErrorText();
  }
  void onPwCheckComplete() {
    _signValidService.pwCheckValid(pwEditingController.text, pwCheckEditingController.text);
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
    _setIsLoading(true);
    await finalCheckValid();
    if(!hasEmailError() && !hasPwError() && !hasPwCheckError()){
      GlobalModel globalModel = Provider.of(_context,listen: false);
      globalModel.fUserInfoJoinReqDto.password = pwEditingController.text;
      globalModel.fUserInfoJoinReqDto.email = idEditingController.text;
      Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>J007View()));
    }
    _setIsLoading(false);
  }
  Future finalCheckValid() async {
    await _signValidService.emailIdValid(idEditingController.text);
    hasIdComplete = true;
    _signValidService.pwValid(pwEditingController.text);
    _signValidService.pwCheckValid(pwEditingController.text, pwCheckEditingController.text);
  }
  void onIdEditChangeText(String value) {
    hasIdComplete = false;
    notifyListeners();
  }

  void onPwCheckEditChangeText(String value) {
    _signValidService.pwCheckValid(pwEditingController.text, pwCheckEditingController.text);
    notifyListeners();
  }

  void onPwEditChangeText(String value) {
    _signValidService.pwValid(pwEditingController.text);
    notifyListeners();
  }

  String pwCheckErrorText() {
    if(pwCheckEditingController.text.length > 0){
      return _signValidService.pwCheckErrorText();
    }else {
      return "";
    }
  }



}
