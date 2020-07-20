import 'package:flutter/material.dart';
import 'package:forutonafront/BCodePage/BCodeMainPage.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/GCodePage/GCodeMainPage.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/HCodeMainPage.dart';
import 'package:forutonafront/ICodePage/ICodeMainPage.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/KCodePage/KCodeMainPage.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:provider/provider.dart';

import '../ServiceLocator/ServiceLocator.dart';

class CodeMainpage extends StatefulWidget {
  CodeMainpage({Key key}) : super(key: key);

  @override
  _CodeMainpageState createState() => _CodeMainpageState();
}

class _CodeMainpageState extends State<CodeMainpage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.listen((String payload) async {
      //TODO 여기서 부터 Notification select 시에 Action 개발
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CodeMainViewModel>(
            create: (_) => CodeMainViewModel(
                geoLocationUtilUseCaseInputPort: sl(),
                authUserCaseInputPort: sl(),
                codeMainPageController: sl())),
        ChangeNotifierProvider<H001ViewModel>(
            create: (_) => H001ViewModel(
                context: context,
                authUserCaseInputPort: sl(),
                geoLocationUtilUseCaseInputPort: sl(),
                fBallListUpFromInfluencePowerUseCaseInputPort: sl(),
                tagRankingFromPositionUseCaseInputPort: sl()))
      ],
      child: Consumer<CodeMainViewModel>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Color(0xffF2F0F1),
          body: Stack(children: <Widget>[
            Container(
                child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: model.pageController,
                    children: <Widget>[
                  HCodeMainPage(),
                  ICodeMainPage(),
                  BCodeMainPage(),
                  KCodeMainPage(),
                  GCodeMainPage()
                ]))
          ]),
        );
      }),
    );
  }
}
