import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/TopNavBar.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/HCodePage/H001/H001Page.dart';
import 'package:forutonafront/ICodePage/I001/I001MainPage.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:provider/provider.dart';

import '../ServiceLocator/ServiceLocator.dart';
import 'HomeMainPageViewModel.dart';

class HomeMainPage extends StatefulWidget {
  HomeMainPage({Key key}) : super(key: key);

  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage>
    with AutomaticKeepAliveClientMixin {
  TopNavBtnMediator _topNavBtnMediator =
      TopNavBtnMediatorImpl(currentTopNavRouter: CodeState.H001CODE);

  SwipeGestureRecognizerController _swipeGestureRecognizerController =
      SwipeGestureRecognizerController();

  CodeMainPageController _codeMainPageController;

  @override
  void initState() {
    super.initState();

    _codeMainPageController = CodeMainPageControllerImpl(
        mapCodeMainPageLink: getMapCodeMainPageLink(),
        topNavBtnMediator: _topNavBtnMediator,
        swipeGestureRecognizerController: _swipeGestureRecognizerController,
        currentState: CodeState.H001CODE);

    _configureSelectNotificationSubject();
  }

  Map<CodeState, CodeMainPageLinkDto> getMapCodeMainPageLink() {
    Map<CodeState, CodeMainPageLinkDto> mapCodeMainPageLink = Map();
    mapCodeMainPageLink[CodeState.H001CODE] =
        CodeMainPageLinkDto(pageNumber: 0, gestureFlag: true);
    mapCodeMainPageLink[CodeState.H003CODE] =
        CodeMainPageLinkDto(pageNumber: 1, gestureFlag: true);
    mapCodeMainPageLink[CodeState.X001CODE] =
        CodeMainPageLinkDto(pageNumber: 2, gestureFlag: true);
    mapCodeMainPageLink[CodeState.X002CODE] =
        CodeMainPageLinkDto(pageNumber: 3, gestureFlag: true);
    mapCodeMainPageLink[CodeState.I001CODE] =
        CodeMainPageLinkDto(pageNumber: 4, gestureFlag: false);
    return mapCodeMainPageLink;
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.listen((String payload) async {
      var actionPayloadDto = ActionPayloadDto.fromJson(json.decode(payload));
      NotiSelectActionBaseInputPort notiSelectActionBaseInputPort = sl.get(
          instanceName: "NotiSelectActionBaseInputPortFactory",
          param1: actionPayloadDto.commandKey);
      notiSelectActionBaseInputPort.action(actionPayloadDto, context);
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeMainPageViewModel>(
            create: (_) => HomeMainPageViewModel(
              context: context,
                geoLocationUtilUseCaseInputPort: sl(),
                fireBaseAuthAdapterForUseCase: sl(),
                codeMainPageController: _codeMainPageController,
                geoViewSearchManagerInputPort: GeoViewSearchManager(),
                userPositionForegroundMonitoringUseCaseInputPort: sl(),
                topNavBtnMediator: _topNavBtnMediator)),
      ],
      child: Consumer<HomeMainPageViewModel>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Color(0xffF2F0F1),
          body: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: TopNavBar(
                      codeStateExpendWidgetMap:
                          model.getCodeStateExpendWidgetMap(),
                      codeMainPageController: model.codeMainPageController,
                      topNavBtnMediator: model.topNavBtnMediator,
                      navBtnList: model.getNavBtnList(),
                    )),
                Expanded(
                  child: SwipeGestureRecognizer(
                    swipeGestureRecognizerController:
                        _swipeGestureRecognizerController,
                    onSwipeRight: () {
                      model.swipeRight();
                    },
                    onSwipeLeft: () {
                      model.swipeLeft();
                    },
                    child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: model.pageController,
                        children: <Widget>[
                          H001Page(
                              geoViewSearchManagerInputPort:
                                  model.geoViewSearchManagerInputPort),
                          Container(child: Text("H003")),
                          Container(child: Text("X001")),
                          Container(child: Text("X002")),
                          I001MainPage(
                              geoViewSearchManagerInputPort:
                                  model.geoViewSearchManagerInputPort)
                        ]),
                  ),
                ),
              ],
            )
          ]),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
