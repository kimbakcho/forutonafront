import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/BCodePage/BCodeMainPage.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import 'package:forutonafront/GCodePage/GCodeMainPage.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/HCodeMainPage.dart';
import 'package:forutonafront/ICodePage/ICodeMainPage.dart';
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
                authUserCaseInputPort: sl(),
                codeMainPageController: sl(),
                userPositionForegroundMonitoringUseCaseInputPort: sl())),
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
