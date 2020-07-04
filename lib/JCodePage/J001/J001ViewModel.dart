import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/NotJoinException.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J002/J002View.dart';
import 'package:forutonafront/JCodePage/J008/J008View.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:provider/provider.dart';

class J001ViewModel extends ChangeNotifier {
  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  SingUpUseCaseInputPort _singUpUseCaseInputPort;
  FireBaseSignInValidUseCase _fireBaseSignInValidUseCase;
  BuildContext _context;

  TextEditingController idTextFieldController = TextEditingController();
  TextEditingController pwTextFieldController = TextEditingController();
  FocusNode idTextFocusNode = FocusNode();
  FocusNode pwTextFocusNode = FocusNode();
  bool _isLoading = false;

  J001ViewModel(
      {@required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required FireBaseSignInValidUseCase fireBaseSignInValidUseCase,
      @required SingUpUseCaseInputPort singUpUseCaseInputPort,
      @required BuildContext context})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fireBaseSignInValidUseCase = fireBaseSignInValidUseCase,
        _singUpUseCaseInputPort = singUpUseCaseInputPort,
        _context = context {
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

  SignInValidWithSignInService _signInValidWithSignInService =
      new FireBaseSignInValidImpl();

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
      Navigator.of(_context).popUntil(ModalRoute.withName('/'));
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
        Navigator.of(_context).popUntil(ModalRoute.withName('/'));
      }
    } on NotJoinException catch (e) {
      _singUpUseCaseInputPort.setUserName(e.snsCheckJoinResDto.userSnsName);
      _singUpUseCaseInputPort.setEmail(e.snsCheckJoinResDto.email);
      _singUpUseCaseInputPort.setUserProfileImageUrl(e.snsCheckJoinResDto.pictureUrl);
      _singUpUseCaseInputPort.setSupportSnsService(snsLoginUseCase.getSnsSupportService());

      globalModel.fUserInfoJoinReqDto.snsToken = snsLoginUseCase.getToken();
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
    _setIsLoading(false);
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
