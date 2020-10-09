import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/TopNavBar.dart';
import 'package:forutonafront/HCodePage/H001/H001Page.dart';
import 'package:forutonafront/ICodePage/I001/I001MainPage.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:provider/provider.dart';

import '../ServiceLocator/ServiceLocator.dart';
import 'BottomNavigation.dart';

class CodeMainPage extends StatefulWidget {
  CodeMainPage({Key key}) : super(key: key);

  @override
  _CodeMainPageState createState() => _CodeMainPageState();
}

class _CodeMainPageState extends State<CodeMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    _configureSelectNotificationSubject();
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CodeMainViewModel>(
            create: (_) => CodeMainViewModel(
                geoLocationUtilUseCaseInputPort: sl(),
                fireBaseAuthAdapterForUseCase: sl(),
                codeMainPageController: sl(),
                userPositionForegroundMonitoringUseCaseInputPort: sl(),
                topNavBtnMediator: sl())),
      ],
      child: Consumer<CodeMainViewModel>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Color(0xffF2F0F1),
          body: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: TopNavBar()),
                Expanded(
                  child: SwipeGestureRecognizer(
                    swipeGestureRecognizerController:
                        model.swipeGestureRecognizerController,
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
                          H001Page(),
                          Container(child: Text("H003")),
                          Container(child: Text("X001")),
                          Container(child: Text("X002")),
                          I001MainPage()
                          // ICodeMainPage(),
                          // BCodeMainPage(),
                          // KCodeMainPage(),
                          // GCodeMainPage()
                        ]),
                  ),
                ),
                BottomNavigation()
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
