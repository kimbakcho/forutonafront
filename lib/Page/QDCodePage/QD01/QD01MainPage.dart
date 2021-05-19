import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/MapIntentButton/MapIntent.dart';
import 'package:forutonafront/Common/MapIntentButton/MapintentButton.dart';
import 'package:forutonafront/Components/BallOption/OtherUserBallPopup/OtherUserBallPopup.dart';
import 'package:forutonafront/Components/DetailMap/DetailMap.dart';
import 'package:forutonafront/Components/DetailPage/DBallAddressWidget.dart';
import 'package:forutonafront/Components/DetailPage/DBallMapStyle1.dart';
import 'package:forutonafront/Components/DetailPage/DBallMode.dart';
import 'package:forutonafront/Components/DetailPage/DBallTitle/DBallTitle.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakePageMode.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QDInfoTabView.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:forutonafront/Page/QMCodePage/QM01/QM01MainPage.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'QD01MissionAndRewardTabView/QD01MissionAndRewardTabView.dart';
import 'QD01TopBar.dart';
import 'QDOptionDialog/MakerOptionDialog.dart';
import 'QDParticipantsTabView/QDParticipantsTabView.dart';
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
                          key: model.mainWidgetKey,
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
                                    QD01TopBar(
                                      onShowPopup: () {
                                        model.showOptionPopup(context);
                                      },
                                    ),
                                    DBallTitle(
                                        fBallResDto: model.fBallResDto,
                                        dBallMode: DBallMode.publish),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: DBallAddressWidget(
                                            padding: EdgeInsets.only(right: 16),
                                            address: model
                                                .fBallResDto!.placeAddress!,
                                            position: Position(
                                                longitude: model
                                                    .fBallResDto!.longitude,
                                                latitude: model
                                                    .fBallResDto!.latitude),
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
                                          onTap: () {
                                            model.mapTap(context);
                                          },
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
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Tab(
                                            text: "참가자",
                                          ),
                                        ),
                                        model.waitParticipatesCount > 0
                                            ? Positioned(
                                                right: 0,
                                                top: 3,
                                                child: Text(
                                                  'N',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 10,
                                                    color:
                                                        const Color(0xffff4f9a),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ))
                                            : Container(
                                                width: 0,
                                                height: 0,
                                              )
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: TabBarView(
                                  children: [
                                    QDInfoTabView(
                                        fBallResDto: model.fBallResDto!,
                                        key: model.infoTabWidgetKey),
                                    QD01MissionAndRewardTabView(
                                        fBallResDto: model.fBallResDto!,
                                        key:
                                            model.missionAndRewardTabWidgetKey),
                                    QDParticipantsTabView(
                                        fBallResDto: model.fBallResDto!,
                                        key: model.qdParticipantsTabViewKey)
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

  QuestBallActionUseCaseInputPort _questBallActionUseCaseInputPort = sl();

  TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort = sl();

  DeleteBallUseCaseInputPort _deleteBallUseCaseInputPort = sl();

  MapBallMarkerFactory _mapBallMarkerFactory = sl();

  int waitParticipatesCount = 0;

  Key mainWidgetKey = UniqueKey();

  Key infoTabWidgetKey = UniqueKey();

  Key missionAndRewardTabWidgetKey = UniqueKey();

  Key qdParticipantsTabViewKey = UniqueKey();

  MaliciousBallUseCaseInputPort _maliciousBallUseCaseInputPort = sl();

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
    waitParticipatesCount = await _questBallActionUseCaseInputPort
        .getStateParticipatesCount(ballUuid, QuestBallParticipateState.Wait);
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

  mapTap(BuildContext context) async {
    var marker = _mapBallMarkerFactory.getBallMaker(
        fBallResDto!.ballType!,
        fBallResDto!.ballUuid!,
        Position(
            longitude: fBallResDto!.longitude, latitude: fBallResDto!.latitude),
        select: true);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailMap(
        marker: marker!,
        address: fBallResDto!.placeAddress!,
        position: Position(
            longitude: fBallResDto!.longitude, latitude: fBallResDto!.latitude),
      );
    }));
  }

  void showOptionPopup(BuildContext context) async {
    var questEnterUserMode = await _questBallActionUseCaseInputPort
        .getQuestEnterUserMode(fBallResDto!);

    if (questEnterUserMode == QuestEnterUserMode.Maker) {
      showDialog(
          context: context,
          builder: (context) {
            return MakerOptionDialog(
              onModify: () async {
                var tagList = await _tagFromBallUuidUseCaseInputPort
                    .getTagFromBallUuid(ballUuid: fBallResDto!.ballUuid!);
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return QM01MainPage(
                    makePageMode: MakePageMode.modify,
                    preSetBallResDto: fBallResDto,
                    preSetFBallTagResDtos: tagList,
                  );
                }));
                fBallResDto = null;
                mainWidgetKey = UniqueKey();
                infoTabWidgetKey = UniqueKey();
                missionAndRewardTabWidgetKey = UniqueKey();
                qdParticipantsTabViewKey = UniqueKey();
                _loadBall();
              },
              onDelete: () async {
                await _deleteBallUseCaseInputPort.deleteBall(fBallResDto!.ballUuid!);
                fBallResDto!.ballDeleteFlag = true;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          });
    }else if(questEnterUserMode == QuestEnterUserMode.Participant){
      showDialog(context: context, builder: (context) {
        return OtherUserBallPopup(
          onReportMalicious: (context, replyMaliciousType) async {
            await _maliciousBallUseCaseInputPort.reportMaliciousReply(replyMaliciousType, ballUuid);
          },
        );
      });
    }else if(questEnterUserMode == QuestEnterUserMode.NoneLogin){
      showMaterialModalBottomSheet(
          context: context,
          expand: false,
          backgroundColor: Colors.transparent,
          enableDrag: true,
          builder: (context) {
            return L001BottomSheet();
          });
    }
  }
}
