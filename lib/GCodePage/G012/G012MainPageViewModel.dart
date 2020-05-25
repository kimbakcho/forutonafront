import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidImpl.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

class G012MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;

  //에러 체크 시도 구분
  bool _isCurrentConfirm = false;
  FUserRepository _fUserRepository = new FUserRepository();

  bool _isLoading = false;
  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  TextEditingController currentPwController = new TextEditingController();
  TextEditingController newPwController = new TextEditingController();
  TextEditingController checkPwController = new TextEditingController();

  SignUpValidService _signUpValidService = DefaultSignValidImpl();

  G012MainPageViewModel(this._context) {
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
    Navigator.of(_context).pop();
  }

  isCurrentPasswordError() {
    if (_isCurrentConfirm && _signUpValidService.hasCurrentPwError()) {
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
    await _signUpValidService.currentPwValid(currentPwController.text);
    _setIsLoading(false);
  }

  String getCurrentPasswordErrorText() {
    return _signUpValidService.currentPwErrorText();
  }

  void onNewPwEditChange(String value) {
    _signUpValidService.pwValid(newPwController.text);
    notifyListeners();
  }

  void onNewPwEditComplete() async {
    _signUpValidService.pwValid(newPwController.text);
    notifyListeners();
  }

  bool isNewPasswordError() {
    if (newPwController.text.length > 0 && _signUpValidService.hasPwError()) {
      return true;
    } else {
      return false;
    }
  }

  String getNewPasswordErrorText() {
    return _signUpValidService.pwErrorText();
  }

  void checkPwEditChange(String value) {
    _signUpValidService.pwCheckValid(
        newPwController.text, checkPwController.text);
    notifyListeners();
  }

  void onCheckEditComplete() {
    _signUpValidService.pwCheckValid(
        newPwController.text, checkPwController.text);
    notifyListeners();
  }

  bool isCheckPasswordError() {
    if (checkPwController.text.length > 0 &&
        _signUpValidService.hasPwCheckError()) {
      return true;
    } else {
      return false;
    }
  }

  String getCheckPasswordErrorText() {
    return _signUpValidService.pwCheckErrorText();
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
    await _signUpValidService.currentPwValid(currentPwController.text);
    _signUpValidService.pwValid(newPwController.text);
    _signUpValidService.pwCheckValid(newPwController.text, checkPwController.text);
    if (_signUpValidService.hasCurrentPwError() || _signUpValidService.hasPwError() || _signUpValidService.hasPwCheckError()) {
      _setIsLoading(false);
      return;
    }
      try {
        if (await _fUserRepository
                .pWChange(FUserInfoPwChangeReqDto(newPwController.text)) ==
            1) {
          await showCompleteChangePwDialog();
          Navigator.of(_context).pop();
        }
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
        context: _context,
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
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ))),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text("패스워드를 변경하였습니다.",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        )),
                  ),
                  Spacer(),
                  Container(
                      height: 32.00,
                      width: MediaQuery.of(_context).size.width,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(_context).pop();
                        },
                        child: Text("확인",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
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
