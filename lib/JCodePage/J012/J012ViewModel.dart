import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCaseOutputPort.dart';
import 'package:forutonafront/JCodePage/J013/J013View.dart';

class J012ViewModel extends ChangeNotifier implements PwFindEmailUseCaseOutputPort{
  final BuildContext context;
  final TextEditingController idEditingController;
  final SignValid _duplicationEmailValid;
  final PwFindEmailUseCaseInputPort _pwFindEmailUseCaseInputPort;

  J012ViewModel(
      {this.context,
      this.idEditingController,
      SignValid duplicationEmailValid,
      PwFindEmailUseCaseInputPort pwFindEmailUseCaseInputPort})
      : _duplicationEmailValid = duplicationEmailValid,
        _pwFindEmailUseCaseInputPort = pwFindEmailUseCaseInputPort;

  bool _idEditCompleteFlag = false;
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  bool isCanNextBtn() {
    if (idEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  onNextComplete() async {
    _idEditCompleteFlag = true;
    _setIsLoading(true);
    await _duplicationEmailValid.valid(idEditingController.text);
    if (!_duplicationEmailValid.hasError()) {
      await _pwFindEmailUseCaseInputPort.sendPasswordResetEmail(idEditingController.text,outputPort: this);
    }
    _setIsLoading(false);
  }

  void onIdEditChangeText(String value) {
    _idEditCompleteFlag = false;
    notifyListeners();
  }

  Future<void> onIdEditComplete() async {
    _idEditCompleteFlag = true;
    await _duplicationEmailValid.valid(idEditingController.text);
    notifyListeners();
  }

  bool hasEmailError() {
    return _duplicationEmailValid.hasError();
  }

  String emailErrorText() {
    if (_idEditCompleteFlag) {
      return _duplicationEmailValid.errorText();
    } else {
      return "";
    }
  }

  @override
  void onSendPasswordResetEmail() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => J013View(idEditingController.text)));
  }
}
