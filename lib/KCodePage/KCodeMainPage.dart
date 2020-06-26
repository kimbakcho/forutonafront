import 'package:flutter/material.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/KCodePage/K001/K001Page.dart';
import 'package:forutonafront/KCodePage/K001/K001PageViewModel.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:provider/provider.dart';

class KCodeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<K001PageViewModel>(
              create: (_) => K001PageViewModel(
                  inquireAboutAnythingUseCase:
                      sl.get(instanceName: "InquireAboutAnythingUseCase"),
              errorReportSurvey: sl.get(instanceName: "GoogleSurveyErrorReportUseCase"),
              proposalOnServiceSurvey: sl(instanceName: "GoogleProposalOnServiceSurveyUseCase"),
              androidIntentAdapter: AndroidIntentAdapterImpl() ))
        ],
        child: Stack(children: <Widget>[
          Scaffold(
              body: Container(
                  color: Color(0xfff2f0f1),
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).padding.top, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(child: K001Page()),
                      ),
                      BottomNavigation()
                    ],
                  )))
        ]));
  }
}
