import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/QuestBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Components/DetailMap/DetailMap.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QD01MissionAndRewardTabView/QDLimitTimeWidget.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QD01MissionAndRewardTabView/QDPointWidget.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QD01MissionAndRewardTabView/QDSuccessModeWidget.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QuestBottomNavBar.dart';
import 'package:forutonafront/Page/QMCodePage/QM01/QM01002Sheet/QuestSelectMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ParticipateSheet extends StatelessWidget {
  final FBallResDto fBallResDto;

  final Function(bool)? onParticipate;

  final Function? onChangeAcceptUser;

  ParticipateSheet(
      {required this.fBallResDto, this.onParticipate, this.onChangeAcceptUser});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParticipateSheetViewModel(
          fBallResDto: fBallResDto,
          onParticipate: onParticipate,
          context: context,
          onChangeAcceptUser: onChangeAcceptUser),
      child: Consumer<ParticipateSheetViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            bottomNavigationBar: model.isLoaded
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: model.getActionButton(context),
                  )
                : Container(),
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
                        model.hasStartPosition
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: QDPointWidget(
                                    title: "시작 장소",
                                    icon: Icon(
                                      ForutonaIcon.startflag,
                                      size: 16,
                                      color: Color(0xffF82929),
                                    ),
                                    onTap: (position, address) {
                                      model.jumpStartDetailMap(
                                          context, position, address);
                                    },
                                    position: model.startPosition,
                                    address: model.startAddress),
                              )
                            : Container(),
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

  final Function? onChangeAcceptUser;

  late final QuestBallDisPlayUseCase questBallDisPlayUseCase;

  bool isLoaded = false;

  QuestBallActionUseCaseInputPort _questBallActionUseCaseInputPort = sl();

  MapMakerDescriptorContainer _mapMakerDescriptorContainer = sl();

  late QuestBallParticipantResDto currentParticipant;

  final BuildContext context;

  ParticipateSheetViewModel(
      {required this.fBallResDto,
      required this.context,
      this.onParticipate,
      this.onChangeAcceptUser}) {
    questBallDisPlayUseCase = QuestBallDisPlayUseCase(
        fBallResDto: fBallResDto, geoLocatorAdapter: sl());
    _load();
  }

  _load() async {
    isLoaded = false;
    currentParticipant = await _questBallActionUseCaseInputPort
        .getParticipate(fBallResDto.ballUuid!);
    isLoaded = true;
    notifyListeners();
    if ((currentParticipant.ballUuid != null) &&
        (currentParticipant.currentState == QuestBallParticipateState.Accept)) {
      if (onChangeAcceptUser != null) {
        onChangeAcceptUser!();
      }
      Navigator.of(context).pop();
    }
  }

  String get qualifyingForQuestText {
    return questBallDisPlayUseCase.ballDescription!.qualifyingForQuestText!;
  }

  bool get showCheckInPosition {
    return questBallDisPlayUseCase.ballDescription!.isOpenCheckInPosition!;
  }

  Position get startPosition {
    var position = Position(
        latitude: questBallDisPlayUseCase.ballDescription!.startPositionLat,
        longitude: questBallDisPlayUseCase.ballDescription!.startPositionLong);
    return position;
  }

  String get startAddress {
    return questBallDisPlayUseCase.ballDescription!.startPositionAddress!;
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

  bool get hasStartPosition {
    return questBallDisPlayUseCase.ballDescription!.startPositionFlag!;
  }

  Widget getSuccessSelect() {
    var questSelectMode =
        questBallDisPlayUseCase.ballDescription!.successSelectMode!;
    if (questSelectMode == QuestSelectMode.PhotoCertification) {
      return QDSuccessModeWidget(
        mainTitle: "인증샷",
        descriptionText: "사진을 보내 퀘스트 완료를 인증합니다.",
        titleIcon: Icon(
          ForutonaIcon.camera1,
          color: Colors.white,
          size: 17,
        ),
        hasCheckIn: false,
        photoDescriptionText: questBallDisPlayUseCase
            .ballDescription!.photoCertificationDescription!,
      );
    } else if (questSelectMode ==
        QuestSelectMode.CheckInWithPhotoCertification) {
      return QDSuccessModeWidget(
        mainTitle: "체크인 + 인증샷",
        descriptionText: "참가자가 특정 위치에서 체크인 후, 사진을 전송해서 퀘스트 완료를 인증합니다.",
        titleIcon: Icon(
          ForutonaIcon.picture2,
          color: Colors.white,
          size: 17,
        ),
        hasCheckIn: showCheckInPosition,
        checkInAddress: checkInAddress,
        checkInPosition: checkInPosition,
        checkInDescriptionText:
            questBallDisPlayUseCase.ballDescription!.checkInPositionDescription,
        photoDescriptionText: questBallDisPlayUseCase
            .ballDescription!.photoCertificationDescription!,
      );
    } else {
      return Container();
    }
  }

  Widget getActionButton(BuildContext context) {
    if (currentParticipant.ballUuid == null) {
      return TextButton(
        onPressed: () {
          participate(context);
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
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
            backgroundColor: MaterialStateProperty.all(Color(0xff3497FD)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(color: Color(0xff4F72FF), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(20))))),
      );
    } else {
      if (currentParticipant.currentState == QuestBallParticipateState.Wait) {
        return TextButton(
          onPressed: () {
            Fluttertoast.showToast(msg: "참가 승인 대기중 입니다.");
          },
          child: Text(
            '참가 승인 대기중',
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: const Color(0xffB1B1B1),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
              backgroundColor: MaterialStateProperty.all(Color(0xffF2F3F5)),
              elevation: MaterialStateProperty.all(3.0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE4E7E8), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))))),
        );
      } else if (currentParticipant.currentState ==
          QuestBallParticipateState.ForceOut) {
        return TextButton(
          onPressed: () {
            Fluttertoast.showToast(msg: "추방당한 퀘스트는 다시 참여할 수 없습니다.");
          },
          child: Text(
            '추방당한 퀘스트는 다시 참여할 수 없습니다.',
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: const Color(0xffB1B1B1),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
              backgroundColor: MaterialStateProperty.all(Color(0xffF2F3F5)),
              elevation: MaterialStateProperty.all(3.0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE4E7E8), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))))),
        );
      } else if (currentParticipant.currentState ==
          QuestBallParticipateState.SelfOut) {
        return TextButton(
          onPressed: () {
            Fluttertoast.showToast(msg: "포기한 퀘스트는 다시 참여할 수 없습니다.");
          },
          child: Text(
            '포기한 퀘스트는 다시 참여할 수 없습니다.',
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: const Color(0xffB1B1B1),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
              backgroundColor: MaterialStateProperty.all(Color(0xffF2F3F5)),
              elevation: MaterialStateProperty.all(3.0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE4E7E8), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))))),
        );
      } else {
        return Container();
      }
    }
  }

  participate(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return CommonLoadingComponent();
        });

    ParticipantReqDto participantReqDto = ParticipantReqDto();
    participantReqDto.ballUuid = fBallResDto.ballUuid;
    var participantResDto =
        await _questBallActionUseCaseInputPort.participate(participantReqDto);
    if (participantResDto.success!) {
      if (onParticipate != null) {
        onParticipate!(true);
      }
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void jumpStartDetailMap(
      BuildContext context, Position position, String address) {
    var qStartFlag = _mapMakerDescriptorContainer
        .getBitmapDescriptor(MapMakerDescriptorType.QStartFlag);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailMap(
        address: address,
        position: position,
        marker: Marker(
          markerId: MarkerId("QStartFlag" + fBallResDto.ballUuid!),
          position: LatLng(position.latitude!, position.longitude!),
          icon: qStartFlag,
          anchor: Offset(0.5, 1),
        ),
      );
    }));
  }
}
