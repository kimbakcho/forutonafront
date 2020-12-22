import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/Page/HCodePage/H001/H001BodyFactory.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'H001ViewModel.dart';

class H001Page extends StatelessWidget {

  final GeoViewSearchManagerInputPort geoViewSearchManagerInputPort;

  const H001Page({Key key, this.geoViewSearchManagerInputPort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H001ViewModel(
            ballListMediator: BallListMediatorImpl(),
            geoViewSearchManager: geoViewSearchManagerInputPort,
            tagRepository: sl(),
            geoLocationUtilBasicUseCaseInputPort: sl(),
            rankingTagListFromBIManager: sl(),
            fBallRepository: sl(),
            noInterestBallUseCaseInputPort: sl()),
        child: Consumer<H001ViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  color: Color(0xfff2f0f1),
                  child: Stack(children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: H001BodyFactory.getBodyWidget(
                              rankingTagListFromBIManager:
                                  model.rankingTagListFromBIManager,
                              ballListMediator: model.ballListMediator),
                        ),
                      ],
                    ),
                    model.ballListMediator.isLoading
                        ? CommonLoadingComponent(
                            isTouch: false,
                          )
                        : Container()
                  ])));
        }));
  }
}
