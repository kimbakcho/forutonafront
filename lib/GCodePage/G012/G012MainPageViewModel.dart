import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

class G012MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;

  //에러 체크 시도 구분
  bool _isCheckTry = false;
  bool _isCurrentPwTry = false;
  bool _isNewPwTry = false;
  bool _currentPwCheckError = false;
  FUserRepository _fUserRepository = new FUserRepository();

  TextEditingController currentPwController = new TextEditingController();
  TextEditingController newPwController = new TextEditingController();
  TextEditingController checkPwController = new TextEditingController();

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
    //패스워드 일치 테스트
    if (_isCurrentPwTry && _currentPwCheckError) {
      return true;
    } else {
      return false;
    }
  }

  bool isNewPasswordError() {
    if (_isNewPwTry) {
      RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
      RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
      RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
      RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
      int match1 = regExp1.hasMatch(newPwController.text) ? 1 : 0;
      int match2 = regExp2.hasMatch(newPwController.text) ? 1 : 0;
      int match3 = regExp3.hasMatch(newPwController.text) ? 1 : 0;
      int match4 = regExp4.hasMatch(newPwController.text) ? 1 : 0;
      if (newPwController.text.length < 8) {
        return true;
      } else if (newPwController.text.length > 16) {
        return true;
      } else if ((match1 + match2 + match3 + match4) < 3) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool isCheckPasswordError() {
    if (_isCheckTry) {
      if (checkPwController.text != newPwController.text) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void onCheckEditComplete() {
    if (checkPwController.text.length > 0) {
      _isCheckTry = true;
    }
    notifyListeners();
  }

  Future onCurrentPwEditComplete() async {
    if (currentPwController.text.length > 6) {
      _isCurrentPwTry = true;
      _currentPwCheckError = false;
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: firebaseUser.email, password: currentPwController.text);
      } catch (ex) {
        _currentPwCheckError = true;
        Fluttertoast.showToast(
            msg: ex.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Color(0xff454F63),
            textColor: Colors.white,
            fontSize: 12.0);
      }
    }
    notifyListeners();
  }

  void onNewPwEditComplete() async {
    if (newPwController.text.length > 0) {}
    notifyListeners();
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

    _isCheckTry = true;
    _isCurrentPwTry = true;
    _isNewPwTry = true;

    if (!await onCurrentPwEditComplete()) {
      notifyListeners();
      return;
    }

    if (!isCurrentPasswordError() &&
        !isNewPasswordError() &&
        !isCheckPasswordError()) {
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
    } else {
      notifyListeners();
    }
    notifyListeners();
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
