import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Page/GCodePage/G010/G010MainPageTemp.dart';
import 'package:forutonafront/Page/GCodePage/G011/G011MainPageTemp.dart';
import 'package:forutonafront/Page/GCodePage/G015/G015MainPageTemp.dart';
import 'package:forutonafront/Page/GCodePage/G016/G016MainPageTemp.dart';
import 'package:forutonafront/Page/GCodePage/G019/G019MainPageTemp.dart';

import 'package:forutonafront/MainPage/CodeMainPageController.dart';


class G009MainPageViewModelTemp extends ChangeNotifier
    implements LogoutUseCaseOutputPort, SignInUserInfoUseCaseOutputPort {
  final BuildContext context;
  final LogoutUseCaseInputPort _logoutUseCaseInputPort;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final CodeMainPageController _codeMainPageController;

  FUserInfoResDto _fUserInfoResDto;

  G009MainPageViewModelTemp(
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
        builder: (_) => G010MainTempPage(), settings: RouteSettings(name: "/G010")));
  }

  void goSecurityPage() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G011MainPageTemp(), settings: RouteSettings(name: "/G011")));
  }

  void logout() async {
    _logoutUseCaseInputPort.tryLogout(outputPort: this);
  }

  void goAlarmSettingPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G015MainPageTemp(), settings: RouteSettings(name: "/G015")));
  }

  void goNoticePage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G016MainPageTemp(), settings: RouteSettings(name: "/G016")));
  }

  void goCustomCenter() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G019MainPageTemp(), settings: RouteSettings(name: "/G019")));
  }

  bool isForutonaUser() {
    return _fUserInfoResDto.snsService == SnsSupportService.Forutona ? true : false;
  }

  @override
  void onLogout() {
    _codeMainPageController.moveToPage(CodeState.H001CODE);
    Navigator.of(context).popUntil((route) => route.settings.name == "/");
  }

  @override
  void onSignInUserInfoFromMemory(FUserInfoResDto fUserInfoResDto) {
    _fUserInfoResDto = fUserInfoResDto;
  }

}
