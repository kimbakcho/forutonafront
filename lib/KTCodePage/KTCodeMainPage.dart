import 'package:flutter/material.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';

import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'KT001/KT001Page.dart';
import 'KT001/KT001PageViewModel.dart';

class KTCodeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<KT001PageViewModel>(
              create: (_) => KT001PageViewModel(
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
                        child: Container(child: KT001Page()),
                      ),
                      BottomNavigation()
                    ],
                  )))
        ]));
  }
}
