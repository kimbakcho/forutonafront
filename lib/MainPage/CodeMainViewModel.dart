import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

enum HCodeState { HCDOE, ICODE, BCODE, KCODE, GCODE }

class CodeMainViewModel with ChangeNotifier {

  Position lastKnownPosition;

  String firstAddress = "";

  AuthUserCaseInputPort _authUserCaseInputPort;

  GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  CodeMainPageController _codeMainPageController;

  CodeMainViewModel(
      {@required AuthUserCaseInputPort authUserCaseInputPort,
      @required GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort,
      @required CodeMainPageController codeMainPageController})
      : _authUserCaseInputPort = authUserCaseInputPort,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort,
        _codeMainPageController = codeMainPageController {
    init();
  }

  init() async {
    await _geoLocationUtilUseCaseInputPort.useGpsReq();
    this.lastKnownPosition =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
    this.firstAddress = await _geoLocationUtilUseCaseInputPort
        .getPositionAddress(lastKnownPosition);
  }

  jumpToPage(HCodeState pageCode) {
    _codeMainPageController.moveToPage(pageCode);
    notifyListeners();
  }

  checkUser() async {
    return await _authUserCaseInputPort.isLogin();
  }

  gotoJ001Page(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) {
          return J001View();
        },
        settings: RouteSettings(name: "/J001")));
  }

  get pageController{
    return _codeMainPageController.pageController;
  }

  get currentState{
    return _codeMainPageController.currentState;
  }
}
