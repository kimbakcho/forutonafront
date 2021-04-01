import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GlobalInitMutex/GlobalInitMutex.dart';
import 'package:forutonafront/Components/TopNav/MainPageViewModelInputPort.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnAction.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H003/TopH003NavExpandComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendAniContent.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/X001/TopX001NavExpandComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/X002/TopX002NavExpandComponent.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/Page/JCodePage/J001/J001View.dart';


class HomeMainPageViewModel
    with ChangeNotifier
    implements MainPageViewModelInputPort, CodeMainPageChangeListener {
  Position lastKnownPosition;

  String firstAddress = "";

  FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase;

  GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort;

  final CodeMainPageController codeMainPageController;

  final UserPositionForegroundMonitoringUseCaseInputPort
      userPositionForegroundMonitoringUseCaseInputPort;

  final TopNavBtnMediator topNavBtnMediator;

  final GeoViewSearchManagerInputPort geoViewSearchManagerInputPort;

  final BuildContext context;

  final TopH_I_001NavExpendAniContentController topH_I_001NavExpendAniContentController;

  final GlobalInitMutex globalInitMutex;

  HomeMainPageViewModel(
      {@required this.fireBaseAuthAdapterForUseCase,
      @required this.context,
      @required this.geoLocationUtilUseCaseInputPort,
      @required this.codeMainPageController,
      @required this.userPositionForegroundMonitoringUseCaseInputPort,
      @required this.geoViewSearchManagerInputPort,
      @required this.topNavBtnMediator,
      @required this.topH_I_001NavExpendAniContentController,
      @required this.globalInitMutex}) {
    init();
  }

  init() async {
    codeMainPageController.addListener(this);
    topNavBtnMediator.codeMainViewModelInputPort = this;
    await globalInitMutex.geoRequestMutex.acquire();

    // await geoLocationUtilUseCaseInputPort.useGpsReq(context);

    this.lastKnownPosition =
        await geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();

      this.firstAddress = await geoLocationUtilUseCaseInputPort
          .getPositionAddress(lastKnownPosition);


    userPositionForegroundMonitoringUseCaseInputPort
        .startUserPositionMonitoringAndUpdateToServer();

    geoLocationUtilUseCaseInputPort.startStreamCurrentPosition();
    globalInitMutex.geoRequestMutex.release();
  }

  Map<CodeState, Widget> getCodeStateExpendWidgetMap() {
    Map<CodeState, Widget> codeStateExpendWidgetMap = Map();
    codeStateExpendWidgetMap[CodeState.H001CODE] = TopH_I_001NavExpendComponent(
      topNavBtnMediator: topNavBtnMediator,
      geoViewSearchManager: geoViewSearchManagerInputPort,
      codeMainPageController: codeMainPageController,
      topH_I_001NavExpendAniContentController: topH_I_001NavExpendAniContentController,
      topH001NavExpendDto: TopH_I_001NavExpendDto(
          btnHeightSize: 36,
          btnWidthSize: MediaQuery.of(context).size.width - 75),
    );
    codeStateExpendWidgetMap[CodeState.H003CODE] = TopH003NavExpandComponent(
      codeMainPageController: codeMainPageController,
      topNavBtnMediator: topNavBtnMediator,
    );
    codeStateExpendWidgetMap[CodeState.X001CODE] = TopX001NavExpandComponent(
      codeMainPageController: codeMainPageController,
      topNavBtnMediator: topNavBtnMediator,
    );
    codeStateExpendWidgetMap[CodeState.X002CODE] = TopX002NavExpandComponent(
      codeMainPageController: codeMainPageController,
      topNavBtnMediator: topNavBtnMediator,
    );
    return codeStateExpendWidgetMap;
  }

  List<NavBtn> getNavBtnList() {
    List<NavBtn> navBtnList = [];
    navBtnList.add(NavBtn(
      originIndex: 1,
      codeMainPageController: codeMainPageController,
      navBtnMediator: topNavBtnMediator,
      navBtnSetDto: NavBtnSetDto(
          btnColor: Color(0xffF6F6F6),
          btnIcon: Icon(ForutonaIcon.list_ol),
          topOnMoveMainPage: CodeState.X002CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 120),
      key: Key("1"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 2,
      codeMainPageController: codeMainPageController,
      navBtnMediator: topNavBtnMediator,
      navBtnSetDto: NavBtnSetDto(
          btnColor: Color(0xffF6F6F6),
          btnIcon: Icon(Icons.star),
          topOnMoveMainPage: CodeState.X001CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 80),
      key: Key("2"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 3,
      codeMainPageController: codeMainPageController,
      navBtnMediator: topNavBtnMediator,
      navBtnSetDto: NavBtnSetDto(
          btnColor: Color(0xffCCCCFF),
          btnIcon: Icon(Icons.playlist_add),
          topOnMoveMainPage: CodeState.H003CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 40),
      key: Key("3"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 4,
      codeMainPageController: codeMainPageController,
      navBtnMediator: topNavBtnMediator,
      navBtnSetDto: NavBtnSetDto(
          btnColor: Color(0xff88D4F1),
          btnIcon: Icon(ForutonaIcon.list_ol),
          topOnMoveMainPage: CodeState.H001CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 0,
          navBtnAction: H001NavBtnAction(geoViewSearchManager: geoViewSearchManagerInputPort)),
      key: Key("4"),
    ));
    return navBtnList;
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
      codeMainPageController.movePageFromTo(
          mainTo: CodeState.H001CODE,
          topFrom: CodeState.H003CODE,
          topTo: CodeState.H001CODE);
    } else if (codeMainPageController.currentState == CodeState.X001CODE) {
      codeMainPageController.movePageFromTo(
          mainTo: CodeState.H003CODE,
          topFrom: CodeState.X001CODE,
          topTo: CodeState.H003CODE);
    } else if (codeMainPageController.currentState == CodeState.X002CODE) {
      codeMainPageController.movePageFromTo(
          mainTo: CodeState.X001CODE,
          topFrom: CodeState.X002CODE,
          topTo: CodeState.X001CODE);
    }
  }

  void swipeLeft() async {
    if (codeMainPageController.currentState == CodeState.H001CODE) {
      codeMainPageController.movePageFromTo(
          mainTo: CodeState.H003CODE,
          topFrom: CodeState.H001CODE,
          topTo: CodeState.H003CODE);
    } else if (codeMainPageController.currentState == CodeState.H003CODE) {
      codeMainPageController.movePageFromTo(
          mainTo: CodeState.X001CODE,
          topFrom: CodeState.H003CODE,
          topTo: CodeState.X001CODE);
    } else if (codeMainPageController.currentState == CodeState.X001CODE) {
      codeMainPageController.movePageFromTo(
          mainTo: CodeState.X002CODE,
          topFrom: CodeState.X001CODE,
          topTo: CodeState.X002CODE);
    }
  }



  @override
  onChangeMainPage() {
    notifyListeners();
  }
}
