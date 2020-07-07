import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/GCodePage/G010/G010MainPage.dart';
import 'package:forutonafront/GCodePage/G011/G011MainPage.dart';
import 'package:forutonafront/GCodePage/G015/G015MainPage.dart';
import 'package:forutonafront/GCodePage/G016/G016MainPage.dart';
import 'package:forutonafront/GCodePage/G019/G019MainPage.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';

class G009MainPageViewModel extends ChangeNotifier
    implements LogoutUseCaseOutputPort, SignInUserInfoUseCaseOutputPort {
  final BuildContext context;
  final LogoutUseCaseInputPort _logoutUseCaseInputPort;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final CodeMainPageController _codeMainPageController;

  FUserInfo _fUserInfo;

  G009MainPageViewModel(
      {@required this.context,
      @required LogoutUseCaseInputPort logoutUseCaseInputPort,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required CodeMainPageController codeMainPageController})
      : _logoutUseCaseInputPort = logoutUseCaseInputPort,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _codeMainPageController = codeMainPageController {
    _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory(
        outputPort: this);
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void goAccountSettingPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G010MainPage(), settings: RouteSettings(name: "/G010")));
  }

  void goSecurityPage() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G011MainPage(), settings: RouteSettings(name: "/G011")));
  }

  void logout() async {
    _logoutUseCaseInputPort.tryLogout(outputPort: this);
  }

  void goAlarmSettingPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G015MainPage(), settings: RouteSettings(name: "/G015")));
  }

  void goNoticePage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G016MainPage(), settings: RouteSettings(name: "/G016")));
  }

  void goCustomCenter() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G019MainPage(), settings: RouteSettings(name: "/G019")));
  }

  bool isForutonaUser() {
    return _fUserInfo.snsService == SnsSupportService.Forutona ? true : false;
  }

  @override
  void onLogout() {
    _codeMainPageController.moveToPage(HCodeState.HCDOE);
    Navigator.of(context).popUntil((route) => route.settings.name == "/");
  }

  @override
  void onSignInUserInfoFromMemory(FUserInfo fUserInfo) {
    _fUserInfo = fUserInfo;
  }
}
