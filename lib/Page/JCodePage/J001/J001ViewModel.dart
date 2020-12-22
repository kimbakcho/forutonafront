import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/NotJoinException.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Page/JCodePage/J002/J002View.dart';
import 'package:forutonafront/Page/JCodePage/J008/J008View.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class J001ViewModel extends ChangeNotifier {
  BuildContext context;
  SingUpUseCaseInputPort singUpUseCaseInputPort;
  FireBaseSignInValidUseCase fireBaseSignInValidUseCase;
  TextEditingController idTextFieldController;
  TextEditingController pwTextFieldController;
  FocusNode idTextFocusNode;
  FocusNode pwTextFocusNode ;

  bool _isLoading = false;

  J001ViewModel(
      {@required this.fireBaseSignInValidUseCase,
      @required  this.singUpUseCaseInputPort,
      @required this.idTextFieldController,
      @required this.pwTextFieldController,
      @required this.idTextFocusNode,
      @required this.pwTextFocusNode,
      @required this.context})
      {
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
    await fireBaseSignInValidUseCase.signInValidWithSignIn(
        idTextFieldController.text, pwTextFieldController.text);
    if (fireBaseSignInValidUseCase.hasSignInError()) {
      Fluttertoast.showToast(
          msg: fireBaseSignInValidUseCase.signInErrorText(),
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
      // singUpUseCaseInputPort.setNickName(e.fUserSnSLoginReqDto.userNickName);
      // singUpUseCaseInputPort.setEmail(e.fUserSnSLoginReqDto.email);
      // singUpUseCaseInputPort
      //     .setUserProfileImageUrl(e.fUserSnSLoginReqDto.userProfileImageUrl);
      // singUpUseCaseInputPort
      //     .setSupportSnsService(snsLoginUseCase.getSnsSupportService());
      // singUpUseCaseInputPort.setSnsToken(e.fUserSnSLoginReqDto.accessToken);
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
    // singUpUseCaseInputPort.setSupportSnsService(SnsSupportService.Forutona);
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
