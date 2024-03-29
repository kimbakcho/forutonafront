import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/TopNavBar.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendAniContent.dart';
import 'package:forutonafront/Page/HCodePage/H001/H001Page.dart';
import 'package:forutonafront/Page/ICodePage/I001/I001MainPage.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'HomeMainPageViewModel.dart';

class HomeMainPage extends StatefulWidget {
  HomeMainPage({Key? key}) : super(key: key);

  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage>
    with AutomaticKeepAliveClientMixin {
  TopNavBtnMediator _topNavBtnMediator =
      TopNavBtnMediatorImpl(currentTopNavRouter: CodeState.H001CODE,isCanNavOpen: false);

  SwipeGestureRecognizerController _swipeGestureRecognizerController =
      SwipeGestureRecognizerController();

  CodeMainPageController? _codeMainPageController;

  @override
  void initState() {
    super.initState();

    _codeMainPageController = CodeMainPageControllerImpl(
        mapCodeMainPageLink: getMapCodeMainPageLink(),
        topNavBtnMediator: _topNavBtnMediator,
        swipeGestureRecognizerController: _swipeGestureRecognizerController,
        currentState: CodeState.H001CODE);

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
                topH_I_001NavExpendAniContentController:
                    TopH_I_001NavExpendAniContentController(),
                userPositionForegroundMonitoringUseCaseInputPort: sl(),
                topNavBtnMediator: _topNavBtnMediator,
                globalInitMutex: sl()
            )),
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
                      // model.swipeRight();
                    },
                    onSwipeLeft: () {
                      // model.swipeLeft();
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
                                model.geoViewSearchManagerInputPort!,
                            topH_I_001NavExpendAniContentController:
                                model.topH_I_001NavExpendAniContentController!,
                          )
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
