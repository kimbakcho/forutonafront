import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCaseOutputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';

class J011ViewModel extends ChangeNotifier
    implements PwFindPhoneUseCaseOutputPort {
  final BuildContext context;
  final TextEditingController pwEditingController;
  final TextEditingController pwCheckEditingController;
  final SignValid _pwValid;
  final SignValid _pwCheckValid;
  final PwFindPhoneUseCaseInputPort _pwFindPhoneUseCaseInputPort;

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  J011ViewModel(
      {@required this.context,
      @required SignValid pwValid,
      @required SignValid pwCheckValid,
      @required PwFindPhoneUseCaseInputPort pwFindPhoneUseCaseInputPort,
      @required this.pwEditingController,
      @required this.pwCheckEditingController})
      : _pwValid = pwValid,
        _pwCheckValid = pwCheckValid,
        _pwFindPhoneUseCaseInputPort = pwFindPhoneUseCaseInputPort;

  void onBackTap() {
    Navigator.of(context).pop();
  }

  bool isValidComplete() {
    if (pwEditingController.text.length > 0 &&
        pwCheckEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  onCompleteBtnClick() async {
    if (!_pwValid.hasError() && !_pwCheckValid.hasError()) {
      _pwFindPhoneUseCaseInputPort.password = pwEditingController.text;
      _setIsLoading(true);
      await _pwFindPhoneUseCaseInputPort.phonePwChange(outputPort: this);
      _setIsLoading(false);
    }
  }

  void onPwEditComplete() {
    _pwValid.valid(pwEditingController.text);
    _pwCheckValid.valid(pwCheckEditingController.text);
    notifyListeners();
  }

  void onPwEditChangeText(String value) {
    _pwValid.valid(pwEditingController.text);
    _pwCheckValid.valid(pwCheckEditingController.text);
    notifyListeners();
  }

  bool hasPwError() {
    if(!_pwValid.hasValidTry){
      return true;
    }
    return _pwValid.hasError();
  }

  String pwErrorText() {
    return _pwValid.errorText();
  }

  void onPwCheckComplete() {
    _pwCheckValid.valid(pwCheckEditingController.text);
    notifyListeners();
  }

  void onPwCheckEditChangeText(String value) {
    _pwCheckValid.valid(pwCheckEditingController.text);
    notifyListeners();
  }

  bool hasPwCheckError() {
    if(!_pwCheckValid.hasValidTry){
      return true;
    }
    return _pwCheckValid.hasError();
  }

  String pwCheckErrorText() {
    return _pwCheckValid.errorText();
  }

  @override
  void onPhonePwChange(PwChangeFromPhoneAuth pwChangeFromPhoneAuthResDto) {
    if (pwChangeFromPhoneAuthResDto.errorFlag) {
      Fluttertoast.showToast(
          msg: pwChangeFromPhoneAuthResDto.cause,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      Fluttertoast.showToast(
          msg: "패스워드를 변경하였습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/J001"),
              builder: (context) {
                return J001View();
              }),
          ModalRoute.withName('/'));
    }
  }
}
