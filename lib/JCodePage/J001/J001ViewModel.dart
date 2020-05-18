import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/SignIn/SignInValidWithSignInService.dart';
import 'package:forutonafront/Common/SignValid/SignInImpl/FireBaseSignInValidImpl.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Service/Impl/NotJoinException.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsSupportServiceFatory.dart';
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
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SignInValidWithSignInService _signInValidWithSignInService =
      new FireBaseSignInValidImpl();

  J001ViewModel(this._context) {
    GlobalModel globalModel = Provider.of<GlobalModel>(_context, listen: false);
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
    _setIsLoading(true);
    await _signInValidWithSignInService.signInValidWithSignIn(
        idTextFieldController.text, pwTextFieldController.text);
    if (_signInValidWithSignInService.hasSignInError()) {
      Fluttertoast.showToast(
          msg: _signInValidWithSignInService.signInErrorText(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      GlobalModel globalModel = Provider.of(_context, listen: false);
      globalModel.setFUserInfoDto();
      Navigator.of(_context).popUntil(ModalRoute.withName('/'));
    }
    _setIsLoading(false);
  }

  void onFaceBookLogin() async {
    SnsLoginService snsLoginService =
        SnsSupportServiceFactory.createSnsSupportService(
            SnsSupportService.FaceBook);
    await snsLoginLogic(snsLoginService);
  }

  void onKakaoLogin() async {
    SnsLoginService snsLoginService =
        SnsSupportServiceFactory.createSnsSupportService(
            SnsSupportService.Kakao);
    await snsLoginLogic(snsLoginService);
  }

  void onNaverLogin() async {
    SnsLoginService snsLoginService =
        SnsSupportServiceFactory.createSnsSupportService(
            SnsSupportService.Naver);
    await snsLoginLogic(snsLoginService);
  }

  Future snsLoginLogic(SnsLoginService snsLoginService) async {
    try {
      _setIsLoading(true);
      if (await snsLoginService.tryLogin()) {
        GlobalModel globalModel = Provider.of(_context, listen: false);
        await globalModel.setFUserInfoDto();
        Navigator.of(_context).popUntil(ModalRoute.withName('/'));
      }
      _setIsLoading(false);
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
