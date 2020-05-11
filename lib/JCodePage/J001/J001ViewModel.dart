import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Service/FaceBookLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/KakaoLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/NaverLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/NotJoinException.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J002/J002View.dart';
import 'package:forutonafront/JCodePage/J008/J008View.dart';
import 'package:provider/provider.dart';

class J001ViewModel extends ChangeNotifier {
  BuildContext _context;
  TextEditingController idTextFieldController = TextEditingController();
  TextEditingController pwTextFieldController = TextEditingController();
  FocusNode idTextFocusNode = FocusNode();
  FocusNode pwTextFocusNode = FocusNode();

  J001ViewModel(this._context) {
    GlobalModel globalModel = Provider.of<GlobalModel>(_context, listen: false);
    //초기화
    globalModel.fUserInfoJoinReqDto = FUserInfoJoinReqDto();
    idTextFieldController.addListener(onIdTextFieldController);
    pwTextFieldController.addListener(onPwTextFieldController);
    idTextFocusNode.addListener(onIdTextFocusNode);
    pwTextFocusNode.addListener(onPwTextFocusNode);
  }

  onIdTextFocusNode() {
    notifyListeners();
  }

  onPwTextFocusNode() {
    notifyListeners();
  }

  onIdTextFieldController() {
    notifyListeners();
  }

  onPwTextFieldController() {
    notifyListeners();
  }

  isActiveButton() {
    if (idTextFieldController.text.length > 0 &&
        pwTextFieldController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  onLoginBtnClick() async {
    bool errorCheck = false;
    String errorText = "";
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: idTextFieldController.text,
              password: pwTextFieldController.text);
      GlobalModel globalModel = Provider.of(_context, listen: false);
      globalModel.setFUserInfoDto();
      Navigator.of(_context).popUntil(ModalRoute.withName('/'));
    } catch (value) {
      errorCheck = true;
      PlatformException exCode = value as PlatformException;
      Fluttertoast.showToast(
          msg: fireBaseLoginErrorMessageLangChage(exCode.message),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  fireBaseLoginErrorMessageLangChage(String message) {
    if (message == "The email address is badly formatted.") {
      return "아이디가 이메일 형식이 아닙니다";
    } else if (message ==
        "There is no user record corresponding to this identifier. The user may have been deleted.") {
      return "아이디가 없거나 패스워드가 틀렸습니다.";
    } else if (message ==
        "The password is invalid or the user does not have a password.") {
      return "아이디가 없거나 패스워드가 틀렸습니다.";
    } else if (message == "An internal error has occurred. [ 7: ]") {
      return "네트워크 접속에 실패했습니다. 네트워크 연결 상태를 확인해주세요.";
    } else {
      return message;
    }
  }

  void onFaceBookLogin() async {
    SnsLoginService snsLoginService = new FaceBookLoginService();
    await snsLoginLogic(snsLoginService);
  }

  void onKakaoLogin() async {
    SnsLoginService snsLoginService = new KakaoLoginService();
    await snsLoginLogic(snsLoginService);
  }

  void onNaverLogin() async {
    SnsLoginService snsLoginService = new NaverLoginService();
    await snsLoginLogic(snsLoginService);
  }

  Future snsLoginLogic(SnsLoginService snsLoginService) async {
    try {
      if (await snsLoginService.tryLogin()) {
        GlobalModel globalModel = Provider.of(_context);
        await globalModel.setFUserInfoDto();
        Navigator.of(_context).popUntil(ModalRoute.withName('/'));
      }
    } on NotJoinException catch (e) {
      GlobalModel globalModel =
          Provider.of<GlobalModel>(_context, listen: false);
      globalModel.fUserInfoJoinReqDto.nickName =
          e.snsCheckJoinResDto.userSnsName;
      globalModel.fUserInfoJoinReqDto.email = e.snsCheckJoinResDto.email;
      globalModel.fUserInfoJoinReqDto.userProfileImageUrl =
          e.snsCheckJoinResDto.pictureUrl;
      globalModel.fUserInfoJoinReqDto.snsSupportService =
          snsLoginService.getSupportSnsService();
      globalModel.fUserInfoJoinReqDto.snsToken = snsLoginService.getToken();
      await Navigator.of(_context).push(MaterialPageRoute(
        builder: (context) {
          return J002View();
        },
        settings: RouteSettings(name: "/J002"),
      ));
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  void jumpToJ002() {
    GlobalModel globalModel = Provider.of(_context, listen: false);
    globalModel.fUserInfoJoinReqDto.snsSupportService =
        SnsSupportService.Forutona;
    Navigator.of(_context).push(MaterialPageRoute(builder: (_) => J002View()));
  }

  void onClose() {
    Navigator.of(_context).pop();
  }

  void jumpToJ008Page() {
    Navigator.of(_context).push(MaterialPageRoute(builder: (_) => J008View()));
  }
}
