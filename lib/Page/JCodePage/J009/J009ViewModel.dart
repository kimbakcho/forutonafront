import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/Page/JCodePage/J010/J010View.dart';

class J009ViewModel extends ChangeNotifier {
  final BuildContext context;
  final SignValid _duplicationEmailValid;
  final PwFindPhoneUseCase _pwFindPhoneUseCase;
  final TextEditingController idEditingController;

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _hasComplete = false;

  J009ViewModel(
      {@required this.context,
      @required SignValid duplicationEmailValid,
      @required PwFindPhoneUseCaseInputPort pwFindPhoneUseCase,
      @required this.idEditingController})
      : _duplicationEmailValid = duplicationEmailValid,
        _pwFindPhoneUseCase = pwFindPhoneUseCase;

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
    _hasComplete = true;
    if (!_duplicationEmailValid.hasError()) {
      // _pwFindPhoneUseCase.email = idEditingController.text;
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J010View()));
    }
    _setIsLoading(false);
  }

  void onIdEditChangeText(String value) {
    _hasComplete = false;
    notifyListeners();
  }

  Future<void> onIdEditComplete() async {
    _setIsLoading(true);
    await _duplicationEmailValid.valid(idEditingController.text);
    _hasComplete = true;
    _setIsLoading(false);
  }

  bool hasEmailError() {
    if (_hasComplete) {
      return _duplicationEmailValid.hasError();
    } else {
      return true;
    }
  }

  String emailErrorText() {
    if (_hasComplete) {
      return _duplicationEmailValid.errorText();
    } else {
      return "";
    }
  }
}
