import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestParticipateAcceptReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QuestActionDialog.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'ParticipantInfoBar.dart';

class WaitParticipantsWidget extends StatelessWidget {
  final FBallResDto fBallResDto;

  WaitParticipantsWidget({required this.fBallResDto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WaitParticipantsWidgetViewModel(fBallResDto: fBallResDto),
      child: Consumer<WaitParticipantsWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            margin: EdgeInsets.only(top: 16),
            child: model.isLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          '참가대기중(${model.waitParticipates.length})',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xff000000),
                            letterSpacing: -0.28,
                            fontWeight: FontWeight.w700,
                            height: 1.2142857142857142,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListView.builder(
                        itemCount: model.waitParticipates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(16),
                            child: model.questEnterUserMode ==
                                    QuestEnterUserMode.Maker
                                ? ParticipantInfoBar(
                                    questBallParticipantResDto:
                                        model.waitParticipates[index],
                                    onAcceptParticipation: () {
                                      showDialog(context: context, builder: (context) {
                                        return QuestActionDialog(
                                          title: "퀘스트 참가 승인",
                                          content: "해당 유저의 참가를 승인합니다.",
                                          activeColor: Color(0xff00B2AC),
                                          activeText: "승인",
                                          size: Size(332,163),
                                          onAgree: (){
                                            model.participantAccept(context, model.waitParticipates[index]);

                                          },
                                        );
                                      },);
                                    },
                                    onDeleteParticipation: () {},
                                  )
                                : ParticipantInfoBar(
                                    questBallParticipantResDto:
                                        model.waitParticipates[index]),
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.zero,
                      )
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

class WaitParticipantsWidgetViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;

  bool isLoaded = false;

  QuestBallActionUseCaseInputPort _questBallActionUseCaseInputPort = sl();

  List<QuestBallParticipantResDto> waitParticipates = [];

  late QuestEnterUserMode questEnterUserMode;

  WaitParticipantsWidgetViewModel({required this.fBallResDto}) {
    _load();
  }

  _load() async {
    isLoaded = false;
    this.waitParticipates = await _questBallActionUseCaseInputPort
        .getParticipates(fBallResDto.ballUuid!, QuestBallParticipateState.Wait);
    this.questEnterUserMode = await _questBallActionUseCaseInputPort
        .getQuestEnterUserMode(fBallResDto);
    isLoaded = true;
    notifyListeners();
  }

  participantAccept(BuildContext context,QuestBallParticipantResDto resDto) async {

    showDialog(context: context, builder: (context) {
      return CommonLoadingComponent();
    });
    QuestParticipateAcceptReqDto reqDto = QuestParticipateAcceptReqDto();
    reqDto.uid = resDto.uid!.uid!;
    reqDto.ballUuid = fBallResDto.ballUuid;
    await _questBallActionUseCaseInputPort.participateAccept(reqDto);
    this.waitParticipates = await _questBallActionUseCaseInputPort
        .getParticipates(fBallResDto.ballUuid!, QuestBallParticipateState.Wait);
    notifyListeners();
    Navigator.of(context).pop();
  }

}
