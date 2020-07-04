import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/NotJoinException.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/JCodePage/J002/J002View.dart';
import 'package:forutonafront/JCodePage/J008/J008View.dart';
import 'package:forutonafront/ServiceLocator.dart';

class J001ViewModel extends ChangeNotifier {
  BuildContext context;
  SingUpUseCaseInputPort _singUpUseCaseInputPort;
  FireBaseSignInValidUseCase _fireBaseSignInValidUseCase;
  TextEditingController idTextFieldController;
  TextEditingController pwTextFieldController;
  FocusNode idTextFocusNode;
  FocusNode pwTextFocusNode ;

  bool _isLoading = false;

  J001ViewModel(
      {@required FireBaseSignInValidUseCase fireBaseSignInValidUseCase,
      @required SingUpUseCaseInputPort singUpUseCaseInputPort,
      @required this.idTextFieldController,
      @required this.pwTextFieldController,
      @required this.idTextFocusNode,
      @required this.pwTextFocusNode,
      @required this.context})
      : _fireBaseSignInValidUseCase = fireBaseSignInValidUseCase,
        _singUpUseCaseInputPort = singUpUseCaseInputPort{
    idTextFieldController.addListener(onIdTextFieldController);
    pwTextFieldController.addListener(onPwTextFieldController);
    idTextFocusNode.addListener(onIdTextFocusNode);
    pwTextFocusNode.addListener(onPwTextFocusNode);
  }

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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
    await _fireBaseSignInValidUseCase.signInValidWithSignIn(
        idTextFieldController.text, pwTextFieldController.text);
    if (_fireBaseSignInValidUseCase.hasSignInError()) {
      Fluttertoast.showToast(
          msg: _fireBaseSignInValidUseCase.signInErrorText(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    }
    _setIsLoading(false);
  }

  void onFaceBookLogin() async {
    await snsLoginLogic(sl.get(instanceName: "LoginUseCaseFaceBook"));
  }

  void onKakaoLogin() async {
    await snsLoginLogic(sl.get(instanceName: "LoginUseCaseKakao"));
  }

  void onNaverLogin() async {
    await snsLoginLogic(sl.get(instanceName: "LoginUseCaseNaver"));
  }

  Future snsLoginLogic(LoginUseCaseInputPort snsLoginUseCase) async {
    try {
      _setIsLoading(true);
      if (!await DataConnectionChecker().hasConnection) {
        throw ("네트워크 접속에 실패했습니다. 네트워크 연결 상태를 확인해주세요.");
      }
      if (await snsLoginUseCase.tryLogin()) {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      }
    } on NotJoinException catch (e) {
      _singUpUseCaseInputPort.setNickName(e.fUserSnSLoginReqDto.userNickName);
      _singUpUseCaseInputPort.setEmail(e.fUserSnSLoginReqDto.email);
      _singUpUseCaseInputPort
          .setUserProfileImageUrl(e.fUserSnSLoginReqDto.userProfileImageUrl);
      _singUpUseCaseInputPort
          .setSupportSnsService(snsLoginUseCase.getSnsSupportService());
      _singUpUseCaseInputPort.setSnsToken(e.fUserSnSLoginReqDto.accessToken);
      await Navigator.of(context).push(MaterialPageRoute(
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
    _setIsLoading(false);
  }

  void forutonaSingUpJumpToJ002() {
    _singUpUseCaseInputPort.setSupportSnsService(SnsSupportService.Forutona);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return J002View();
      },
      settings: RouteSettings(name: "/J002"),
    ));
  }

  void onClose() {
    Navigator.of(context).pop();
  }

  void jumpToJ008Page() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => J008View()));
  }
}
