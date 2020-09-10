import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

enum CodeState { H001CODE, H003CODE, X001CODE, X002CODE }

abstract class CodeMainViewModelInputPort{
  jumpToPage(CodeState pageCode);
}

class CodeMainViewModel with ChangeNotifier implements CodeMainViewModelInputPort{
  Position lastKnownPosition;

  String firstAddress = "";

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  CodeMainPageController _codeMainPageController;

  final UserPositionForegroundMonitoringUseCaseInputPort
      _userPositionForegroundMonitoringUseCaseInputPort;

  TopNavBtnMediator _topNavBtnMediator;

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
    _topNavBtnMediator = sl();

    _topNavBtnMediator.codeMainViewModelInputPort = this;

    await _geoLocationUtilUseCaseInputPort.useGpsReq();

    this.lastKnownPosition =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();

    this.firstAddress = await _geoLocationUtilUseCaseInputPort
        .getPositionAddress(lastKnownPosition);

    _userPositionForegroundMonitoringUseCaseInputPort
        .startUserPositionMonitoringAndUpdateToServer();

    _geoLocationUtilUseCaseInputPort.startStreamCurrentPosition();
  }

  jumpToPage(CodeState pageCode) {
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

  void swipeRight() async {
    if (_codeMainPageController.currentState == CodeState.H003CODE) {
      _movePageFromTo(
          mainTo: CodeState.H001CODE,
          topFrom: TopNavRouterType.H003,
          topTo: TopNavRouterType.H001);
    }else if(_codeMainPageController.currentState == CodeState.X001CODE) {
      _movePageFromTo(
          mainTo: CodeState.H003CODE,
          topFrom: TopNavRouterType.X001,
          topTo: TopNavRouterType.H003);
    }else if(_codeMainPageController.currentState == CodeState.X002CODE) {
      _movePageFromTo(
          mainTo: CodeState.X001CODE,
          topFrom: TopNavRouterType.X002,
          topTo: TopNavRouterType.X001);
    }
  }

  _movePageFromTo(
      {CodeState mainTo,
      TopNavRouterType topFrom,
      TopNavRouterType topTo}) async {
    await _topNavBtnMediator.openNavList(navRouterType: topFrom);
    _codeMainPageController.moveToPage(mainTo);
    _topNavBtnMediator.closeNavList(navRouterType: topTo);
  }

  void swipeLeft() async {
    if (_codeMainPageController.currentState == CodeState.H001CODE) {
      _movePageFromTo(
          mainTo: CodeState.H003CODE,
          topFrom: TopNavRouterType.H001,
          topTo: TopNavRouterType.H003);
    }else if(_codeMainPageController.currentState == CodeState.H003CODE){
      _movePageFromTo(
          mainTo: CodeState.X001CODE,
          topFrom: TopNavRouterType.H003,
          topTo: TopNavRouterType.X001);
    }else if(_codeMainPageController.currentState == CodeState.X001CODE){
      _movePageFromTo(
          mainTo: CodeState.X002CODE,
          topFrom: TopNavRouterType.X001,
          topTo: TopNavRouterType.X002);
    }
  }
}
