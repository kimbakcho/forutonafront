import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseOutputPort.dart';
import 'package:forutonafront/Page/JCodePage/J013/J013View.dart';

class J012ViewModel extends ChangeNotifier
    implements PwFindEmailUseCaseOutputPort {
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
    _setIsLoading(true);
    await _duplicationEmailValid.valid(idEditingController.text);
    if (!_duplicationEmailValid.hasError()) {
      await _pwFindEmailUseCaseInputPort
          .sendPasswordResetEmail(idEditingController.text, outputPort: this);
    }
    _setIsLoading(false);
  }

  void onIdEditChangeText(String value) {
    notifyListeners();
  }

  Future<void> onIdEditComplete() async {
    await _duplicationEmailValid.valid(idEditingController.text);
    notifyListeners();
  }

  bool hasEmailError() {
    if (!_duplicationEmailValid.hasValidTry) {
      return true;
    }
    return _duplicationEmailValid.hasError();
  }

  String emailErrorText() {
    return _duplicationEmailValid.errorText();
  }

  @override
  void onSendPasswordResetEmail() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => J013View(idEditingController.text)));
  }
}
