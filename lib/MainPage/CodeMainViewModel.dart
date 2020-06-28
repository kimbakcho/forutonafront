import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator.dart';

enum HCodeState { HCDOE, ICODE, BCODE, KCODE, GCODE }

class CodeMainViewModel with ChangeNotifier {
  PageController pageController;
  HCodeState currentState;

  Position lastKnownPosition;

  String firstAddress = "";

  AuthUserCaseInputPort authUserCaseInputPort = sl();

  GeoLocationUtilUseCaseInputPort _geoLocationUtilUseCaseInputPort = sl();


  CodeMainViewModel() {
    pageController = new PageController();
    currentState = HCodeState.HCDOE;
    init();
  }

  init() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white, animate: true);
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    await _geoLocationUtilUseCaseInputPort.useGpsReq();
    this.lastKnownPosition =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
    this.firstAddress =
        await _geoLocationUtilUseCaseInputPort.getPositionAddress(lastKnownPosition);
  }

  jumpToPage(HCodeState pageCode) {
    currentState = pageCode;
    switch (currentState) {
      case HCodeState.HCDOE:
        pageController.jumpToPage(0);
        break;
      case HCodeState.ICODE:
        pageController.jumpToPage(1);
        break;
      case HCodeState.BCODE:
        pageController.jumpToPage(2);
        break;
      case HCodeState.KCODE:
        pageController.jumpToPage(3);
        break;
      case HCodeState.GCODE:
        pageController.jumpToPage(4);
        break;
    }
    notifyListeners();
  }

  checkUser() async {
    return authUserCaseInputPort.isLogin();
  }

  gotoJ001Page(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) {
          return J001View();
        },
        settings: RouteSettings(name: "/J001")));
  }
}
