import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

enum CodeState { H001CODE, H003CODE, X001CODE, X002CODE, I001CODE }

abstract class CodeMainViewModelInputPort {
  jumpToPage(CodeState pageCode);
}

class CodeMainViewModel
    with ChangeNotifier
    implements CodeMainViewModelInputPort,CodeMainPageChangeListener {
  Position lastKnownPosition;

  String firstAddress = "";

  FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase;

  GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort;

  CodeMainPageController codeMainPageController;

  final UserPositionForegroundMonitoringUseCaseInputPort
      userPositionForegroundMonitoringUseCaseInputPort;

  TopNavBtnMediator topNavBtnMediator;

  CodeMainViewModel(
      {@required this.fireBaseAuthAdapterForUseCase,
      @required this.geoLocationUtilUseCaseInputPort,
      @required this.codeMainPageController,
      @required this.userPositionForegroundMonitoringUseCaseInputPort,
      @required this.topNavBtnMediator}) {
    init();
  }

  init() async {
    codeMainPageController.addListener(this);
    topNavBtnMediator.codeMainViewModelInputPort = this;

    await geoLocationUtilUseCaseInputPort.useGpsReq();

    this.lastKnownPosition =
        await geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();

    this.firstAddress = await geoLocationUtilUseCaseInputPort
        .getPositionAddress(lastKnownPosition);

    userPositionForegroundMonitoringUseCaseInputPort
        .startUserPositionMonitoringAndUpdateToServer();

    geoLocationUtilUseCaseInputPort.startStreamCurrentPosition();
  }

  jumpToPage(CodeState pageCode) {
    codeMainPageController.moveToPage(pageCode);
    notifyListeners();
  }

  checkUser() async {
    return await fireBaseAuthAdapterForUseCase.isLogin();
  }

  gotoJ001Page(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) {
          return J001View();
        },
        settings: RouteSettings(name: "/J001")));
  }

  get pageController {
    return codeMainPageController.pageController;
  }

  get currentState {
    return codeMainPageController.currentState;
  }

  void swipeRight() async {
    if (codeMainPageController.currentState == CodeState.H003CODE) {
      _movePageFromTo(
          mainTo: CodeState.H001CODE,
          topFrom: CodeState.H003CODE,
          topTo: CodeState.H001CODE);
    } else if (codeMainPageController.currentState == CodeState.X001CODE) {
      _movePageFromTo(
          mainTo: CodeState.H003CODE,
          topFrom: CodeState.X001CODE,
          topTo: CodeState.H003CODE);
    } else if (codeMainPageController.currentState == CodeState.X002CODE) {
      _movePageFromTo(
          mainTo: CodeState.X001CODE,
          topFrom: CodeState.X002CODE,
          topTo: CodeState.X001CODE);
    }
  }

  _movePageFromTo(
      {CodeState mainTo,
      CodeState topFrom,
        CodeState topTo}) async {
    await topNavBtnMediator.openNavList(navRouterType: topFrom);
    codeMainPageController.moveToPage(mainTo);
    topNavBtnMediator.closeNavList(navRouterType: topTo);
  }

  void swipeLeft() async {
    if (codeMainPageController.currentState == CodeState.H001CODE) {
      _movePageFromTo(
          mainTo: CodeState.H003CODE,
          topFrom: CodeState.H001CODE,
          topTo: CodeState.H003CODE);
    } else if (codeMainPageController.currentState == CodeState.H003CODE) {
      _movePageFromTo(
          mainTo: CodeState.X001CODE,
          topFrom: CodeState.H003CODE,
          topTo: CodeState.X001CODE);
    } else if (codeMainPageController.currentState == CodeState.X001CODE) {
      _movePageFromTo(
          mainTo: CodeState.X002CODE,
          topFrom: CodeState.X001CODE,
          topTo: CodeState.X002CODE);
    }
  }

  SwipeGestureRecognizerController get swipeGestureRecognizerController {
    return codeMainPageController.swipeGestureRecognizerController;
  }

  updatePageRender(){
    notifyListeners();
  }

  @override
  onChangeMainPage() {
    notifyListeners();
  }
}
