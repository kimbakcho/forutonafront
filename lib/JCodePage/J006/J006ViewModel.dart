import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J007/J007View.dart';
import 'package:provider/provider.dart';

class J006ViewModel extends ChangeNotifier {
  final BuildContext context;
  final SignValid _signUpEmailValid;
  final SignValid _pwValid;
  final SignValid _pwCheckValid;
  final SingUpUseCaseInputPort _singUpUseCaseInputPort;
  final TextEditingController idEditingController;
  final TextEditingController pwEditingController;
  final TextEditingController pwCheckEditingController;

  bool hasIdComplete = false;
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  J006ViewModel(
      {@required this.context,
      @required SignValid signUpEmailValid,
      @required SignValid pwValidImpl,
      @required SignValid pwCheckValid,
      @required SingUpUseCaseInputPort singUpUseCaseInputPort,
        @required this.idEditingController,
        @required this.pwEditingController,
        @required this.pwCheckEditingController,
      })
      : _signUpEmailValid = signUpEmailValid,
        _pwValid = pwValidImpl,
        _pwCheckValid = pwCheckValid,
        _singUpUseCaseInputPort = singUpUseCaseInputPort;

  void onBackTap() {
    Navigator.of(context).pop();
  }

  Future<void> onIdEditComplete() async {
    _setIsLoading(true);
    hasIdComplete = true;
    await _signUpEmailValid.valid(idEditingController.text);
    _setIsLoading(false);
  }

  hasEmailError() {
    return _signUpEmailValid.hasError();
  }

  String emailErrorText() {
    if (hasIdComplete) {
      return _signUpEmailValid.errorText();
    } else {
      return "";
    }
  }

  hasPwCheckError() {
    if (pwCheckEditingController.text.length > 0) {
      return _pwCheckValid.hasError();
    } else {
      return true;
    }
  }

  void onPwEditComplete() {
    _pwValid.valid(pwEditingController.text);
    notifyListeners();
  }

  hasPwError() {
    return _pwValid.hasError();
  }

  String pwErrorText() {
    return _pwValid.errorText();
  }

  void onPwCheckComplete() {
    _pwCheckValid.valid(pwCheckEditingController.text);
    notifyListeners();
  }

  bool isCanNextBtn() {
    if (idEditingController.text.length > 0 &&
        pwEditingController.text.length > 0 &&
        pwCheckEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  onNextComplete() async {
    _setIsLoading(true);
    await finalCheckValid();
    if (!hasEmailError() && !hasPwError() && !hasPwCheckError()) {
      _singUpUseCaseInputPort.setPassword(pwEditingController.text);
      _singUpUseCaseInputPort.setEmail(idEditingController.text);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J007View()));
    }
    _setIsLoading(false);
  }

  Future finalCheckValid() async {
    await _signUpEmailValid.valid(idEditingController.text);
    hasIdComplete = true;
    _pwValid.valid(pwEditingController.text);
    _pwCheckValid.valid(pwCheckEditingController.text);
  }

  void onIdEditChangeText(String value) {
    hasIdComplete = false;
    notifyListeners();
  }

  void onPwCheckEditChangeText(String value) {
    _pwCheckValid.valid(pwCheckEditingController.text);
    notifyListeners();
  }

  void onPwEditChangeText(String value) {
    _pwValid.valid(pwEditingController.text);
    notifyListeners();
  }

  String pwCheckErrorText() {
    if (pwCheckEditingController.text.length > 0) {
      return _pwCheckValid.errorText();
    } else {
      return "";
    }
  }
}
