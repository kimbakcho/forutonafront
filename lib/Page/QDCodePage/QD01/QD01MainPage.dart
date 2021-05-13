import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/MapIntentButton/MapIntent.dart';
import 'package:forutonafront/Common/MapIntentButton/MapintentButton.dart';
import 'package:forutonafront/Components/DetailPage/DBallAddressWidget.dart';
import 'package:forutonafront/Components/DetailPage/DBallMapStyle1.dart';
import 'package:forutonafront/Components/DetailPage/DBallMode.dart';
import 'package:forutonafront/Components/DetailPage/DBallTitle/DBallTitle.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QDInfoTabView.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'QD01TopBar.dart';
import 'QDMissionAndAwardTabView.dart';
import 'QDParticipantTabView.dart';
import 'QuestBottomNavBar.dart';

class QD01MainPage extends StatelessWidget {
  final FBallResDto? fBallResDto;
  final String ballUuid;

  QD01MainPage({this.fBallResDto, required this.ballUuid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            QD01MainPageViewModel(ballUuid: ballUuid, fBallResDto: fBallResDto),
        child: Consumer<QD01MainPageViewModel>(builder: (_, model, child) {
          return Container(
              padding: MediaQuery.of(context).padding,
              color: Colors.white,
              child: model.isBallLoaded
                  ? DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Scaffold(
                          backgroundColor: Colors.white,
                          bottomNavigationBar: QuestBottomNavBar(
                            fBallResDto: model.fBallResDto!,
                          ),
                          body: NestedScrollView(
                              headerSliverBuilder:
                                  (context, innerBoxIsScrolled) {
                                return [
                                  SliverList(
                                      delegate: SliverChildListDelegate([
                                    QD01TopBar(),
                                    DBallTitle(
                                        fBallResDto: model.fBallResDto,
                                        dBallMode: DBallMode.publish),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: DBallAddressWidget(
                                            fBallResDto: model.fBallResDto,
                                          )),
                                          MapIntentButton(
                                            dstPosition: model._ballPosition,
                                            dstAddress: model
                                                .fBallResDto!.placeAddress!,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: DBallMapStyle1(
                                          fBallResDto: model.fBallResDto!),
                                    ),
                                  ]))
                                ];
                              },
                              body: Column(children: [
                                TabBar(
                                  labelColor: Colors.black,
                                  indicatorColor: Colors.black,
                                  tabs: [
                                    Tab(text: "정보"),
                                    Tab(text: "업무&보상"),
                                    Tab(
                                      text: "참가자",
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: TabBarView(
                                  children: [
                                    QDInfoTabView(
                                      fBallResDto: model.fBallResDto!,
                                    ),
                                    QDMissionAndAward(),
                                    QDParticipantTabView()
                                  ],
                                ))
                              ]))))
                  : CommonLoadingComponent());
        }));
  }
}

class QD01MainPageViewModel extends ChangeNotifier {
  FBallResDto? fBallResDto;

  String ballUuid;

  bool isBallLoaded = false;

  SelectBallUseCaseInputPort _selectBallUseCaseInputPort = sl();



  QD01MainPageViewModel({this.fBallResDto, required this.ballUuid}) {
    _loadBall();
  }


  _loadBall() async {
    isBallLoaded = false;

    if (fBallResDto == null) {
      notifyListeners();
      this.fBallResDto =
          await this._selectBallUseCaseInputPort.selectBall(ballUuid);
    }
    // _signInUserInfoUseCaseInputPort.isLogin


    isBallLoaded = true;
    notifyListeners();
  }





  Position get _ballPosition {
    if (fBallResDto != null) {
      return Position(
          longitude: fBallResDto!.longitude, latitude: fBallResDto!.latitude);
    } else {
      return Preference.initPosition;
    }
  }
}
