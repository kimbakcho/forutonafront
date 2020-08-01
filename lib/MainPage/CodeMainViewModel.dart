import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

enum HCodeState { HCDOE, ICODE, BCODE, KCODE, GCODE }

class CodeMainViewModel with ChangeNotifier {
  Position lastKnownPosition;

  String firstAddress = "";

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  CodeMainPageController _codeMainPageController;

  final UserPositionForegroundMonitoringUseCaseInputPort
      _userPositionForegroundMonitoringUseCaseInputPort;

  CodeMainViewModel(
      {@required
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          GeoLocationUtilForeGroundUseCaseInputPort
              geoLocationUtilUseCaseInputPort,
      @required
          CodeMainPageController codeMainPageController,
      @required
          UserPositionForegroundMonitoringUseCaseInputPort
              userPositionForegroundMonitoringUseCaseInputPort})
      : _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _codeMainPageController = codeMainPageController,
        _userPositionForegroundMonitoringUseCaseInputPort =
            userPositionForegroundMonitoringUseCaseInputPort {
    init();
  }

  init() async {
    await _geoLocationUtilUseCaseInputPort.useGpsReq();

    this.lastKnownPosition =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();

    this.firstAddress = await _geoLocationUtilUseCaseInputPort
        .getPositionAddress(lastKnownPosition);

    _userPositionForegroundMonitoringUseCaseInputPort.startUserPositionMonitoringAndUpdateToServer();

    _geoLocationUtilUseCaseInputPort.startStreamCurrentPosition();
  }

  jumpToPage(HCodeState pageCode) {
    _codeMainPageController.moveToPage(pageCode);
    notifyListeners();
  }

  checkUser() async {
    return await _fireBaseAuthAdapterForUseCase.isLogin();
  }

  gotoJ001Page(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) {
          return J001View();
        },
        settings: RouteSettings(name: "/J001")));
  }

  get pageController {
    return _codeMainPageController.pageController;
  }

  get currentState {
    return _codeMainPageController.currentState;
  }
}
