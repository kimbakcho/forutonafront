import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';

import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import 'package:google_fonts/google_fonts.dart';

class G012MainPageViewModel extends ChangeNotifier {
  final BuildContext context;

  final TextEditingController currentPwController;
  final TextEditingController newPwController;
  final TextEditingController checkPwController;

  final SignValid _pwValid;
  final SignValid _pwCheckValid;
  final SignValid _currentPwValid;


  final CodeMainPageController _codeMainPageController;

  final LogoutUseCaseInputPort _logoutUseCaseInputPort;

  final FUserPwChangeUseCaseInputPort _fUserPwChangeUseCaseInputPort;

  //에러 체크 시도 구분
  bool _isCurrentConfirm = false;

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  G012MainPageViewModel(
      {@required this.context,
      @required this.currentPwController,
      @required this.newPwController,
      @required this.checkPwController,
      @required SignValid pwValid,
      @required SignValid pwCheckValid,
      @required SignValid currentPwValid,
      @required CodeMainPageController codeMainPageController,
      @required LogoutUseCaseInputPort logoutUseCaseInputPort,
      @required FUserPwChangeUseCaseInputPort fUserPwChangeUseCaseInputPort})
      : _pwValid = pwValid,
        _pwCheckValid = pwCheckValid,
        _currentPwValid = currentPwValid,
        _codeMainPageController = codeMainPageController,
        _fUserPwChangeUseCaseInputPort = fUserPwChangeUseCaseInputPort,
        _logoutUseCaseInputPort = logoutUseCaseInputPort {
    checkPwController.addListener(_onCheckPwControllerListener);
    newPwController.addListener(_onNewPwControllerListener);
    currentPwController.addListener(_onCurrentPwControllerListener);
  }

  _onCheckPwControllerListener() {
    notifyListeners();
  }

  _onNewPwControllerListener() {
    notifyListeners();
  }

  _onCurrentPwControllerListener() {
    notifyListeners();
  }

  void onBackBtnTap() {
    Navigator.of(context).pop();
  }

  isCurrentPasswordError() {
    if (_isCurrentConfirm && _currentPwValid.hasError()) {
      return true;
    } else {
      return false;
    }
  }

  void onCurrentPwEditChange(String value) {
    _isCurrentConfirm = false;
    notifyListeners();
  }

  Future onCurrentPwEditComplete() async {
    _isCurrentConfirm = true;
    _setIsLoading(true);
    await _currentPwValid.valid(currentPwController.text);
    _setIsLoading(false);
  }

  String getCurrentPasswordErrorText() {
    return _currentPwValid.errorText();
  }

  void onNewPwEditChange(String value) {
    _pwValid.valid(newPwController.text);
    notifyListeners();
  }

  void onNewPwEditComplete() async {
    _pwValid.valid(newPwController.text);
    notifyListeners();
  }

  bool isNewPasswordError() {
    if (newPwController.text.length > 0 && _pwValid.hasError()) {
      return true;
    } else {
      return false;
    }
  }

  String getNewPasswordErrorText() {
    return _pwValid.errorText();
  }

  void checkPwEditChange(String value) {
    _pwCheckValid.valid(checkPwController.text);
    notifyListeners();
  }

  void onCheckEditComplete() {
    _pwCheckValid.valid(checkPwController.text);
    notifyListeners();
  }

  bool isCheckPasswordError() {
    if (checkPwController.text.length > 0 && _pwCheckValid.hasError()) {
      return true;
    } else {
      return false;
    }
  }

  String getCheckPasswordErrorText() {
    return _pwCheckValid.errorText();
  }

  isCanComplete() {
    if (newPwController.text.length > 0 &&
        currentPwController.text.length > 0 &&
        checkPwController.text.length > 0) {
      return true;
    }
    return false;
  }

  void onPwChangeComplete() async {
    _isCurrentConfirm = true;
    _setIsLoading(true);

    await _currentPwValid.valid(currentPwController.text);
    _pwValid.valid(newPwController.text);
    _pwCheckValid.valid(checkPwController.text);

    if (_currentPwValid.hasError() ||
        _pwValid.hasError() ||
        _pwCheckValid.hasError()) {
      _setIsLoading(false);
      return;
    }
    try {
      await _fUserPwChangeUseCaseInputPort.pwChange(newPwController.text);
      await showCompleteChangePwDialog();
      await _logoutUseCaseInputPort.tryLogout();
      _codeMainPageController.moveToPage(CodeState.H001CODE);
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    } catch (ex) {
      Fluttertoast.showToast(
          msg: ex.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
    _setIsLoading(false);
  }

  Future showCompleteChangePwDialog() async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        useRootNavigator: true,
        child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(12),
            )),
            contentPadding: EdgeInsets.all(0),
            content: Container(
                height: 182.00,
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text("패스워드 변경",
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ))),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text("패스워드를 변경하였습니다.",
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        )),
                  ),
                  Spacer(),
                  Container(
                      height: 32.00,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("확인",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Color(0xff3497fd),
                            )),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1.00,
                          color: Color(0xff454f63),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 12.00),
                            color: Color(0xff455b63).withOpacity(0.08),
                            blurRadius: 16,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5.00),
                      ))
                ]))));
  }
}
