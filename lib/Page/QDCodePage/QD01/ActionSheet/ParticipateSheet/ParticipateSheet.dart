import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/QuestBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QD01MissionAndRewardTabView/QDLimitTimeWidget.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QD01MissionAndRewardTabView/QDSuccessModeWidget.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QuestBottomNavBar.dart';
import 'package:forutonafront/Page/QMCodePage/QM01/QM01002Sheet/QuestSelectMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ParticipateSheet extends StatelessWidget {
  final FBallResDto fBallResDto;

  final Function(bool)? onParticipate;

  ParticipateSheet({required this.fBallResDto,this.onParticipate});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParticipateSheetViewModel(fBallResDto: fBallResDto,onParticipate: onParticipate),
      child: Consumer<ParticipateSheetViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            bottomNavigationBar: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  model.participate(context);
                },
                child: Text(
                  '참가하기',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: const Color(0xfff9f9f9),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(double.infinity,40)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff3497FD)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xff4F72FF),width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))))),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).padding.right,
                  MediaQuery.of(context).padding.top + 115,
                  MediaQuery.of(context).padding.right,
                  MediaQuery.of(context).padding.bottom),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '퀘스트 참가자격',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff000000),
                              letterSpacing: -0.28,
                              fontWeight: FontWeight.w700,
                              height: 1.2142857142857142,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.all(16),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            model.qualifyingForQuestText,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff3a3e3f),
                              letterSpacing: -0.28,
                              height: 1.2857142857142858,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        model.getSuccessSelect(),
                        model.hasLimitTime
                            ? QDLimitTimeWidget(
                                seconds: model.limitTimeSeconds,
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ParticipateSheetViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;

  final Function(bool)? onParticipate;

  late final QuestBallDisPlayUseCase questBallDisPlayUseCase;

  QuestBallActionUseCaseInputPort _questBallActionUseCaseInputPort = sl();

  ParticipateSheetViewModel({required this.fBallResDto,this.onParticipate}) {
    questBallDisPlayUseCase = QuestBallDisPlayUseCase(
        fBallResDto: fBallResDto, geoLocatorAdapter: sl());
  }

  String get qualifyingForQuestText {
    return questBallDisPlayUseCase.ballDescription!.qualifyingForQuestText!;
  }

  bool get showCheckInPosition {
    return questBallDisPlayUseCase.ballDescription!.isOpenCheckInPosition!;
  }

  Position get checkInPosition {
    var position = Position(
        latitude: questBallDisPlayUseCase.ballDescription!.checkInPositionLat,
        longitude:
            questBallDisPlayUseCase.ballDescription!.checkInPositionLong);
    return position;
  }

  String get checkInAddress {
    return questBallDisPlayUseCase.ballDescription!.checkInAddress!;
  }

  QuestSelectMode get questSelectMode {
    return questBallDisPlayUseCase.ballDescription!.successSelectMode!;
  }

  bool get hasLimitTime {
    return questBallDisPlayUseCase.ballDescription!.timeLimitFlag!;
  }

  int get limitTimeSeconds {
    return questBallDisPlayUseCase.ballDescription!.limitTimeSec!;
  }

  Widget getSuccessSelect() {
    var questSelectMode =
        questBallDisPlayUseCase.ballDescription!.successSelectMode!;
    if (questSelectMode == QuestSelectMode.PhotoCertification) {
      return QDSuccessModeWidget(
        hasCheckIn: false,
        descriptionText: questBallDisPlayUseCase
            .ballDescription!.photoCertificationDescription!,
      );
    } else if (questSelectMode ==
        QuestSelectMode.CheckInWithPhotoCertification) {
      return QDSuccessModeWidget(
        hasCheckIn: showCheckInPosition,
        checkInAddress: checkInAddress,
        checkInPosition: checkInPosition,
        descriptionText: questBallDisPlayUseCase
            .ballDescription!.photoCertificationDescription!,
      );
    } else {
      return Container();
    }
  }

  participate(BuildContext context) async {

    showDialog(context: context, builder: (context) {
      return CommonLoadingComponent();
    });

    ParticipantReqDto participantReqDto = ParticipantReqDto();
    participantReqDto.ballUuid = fBallResDto.ballUuid;
    var participantResDto = await _questBallActionUseCaseInputPort.participate(participantReqDto);
    if(participantResDto.success!){
      if(onParticipate != null){
        onParticipate!(true);
      }
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

}
