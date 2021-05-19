import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/QuestBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Components/DetailMap/DetailMap.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/QMCodePage/QM01/QM01002Sheet/QuestSelectMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'QDLimitTimeWidget.dart';
import 'QDSuccessModeWidget.dart';
import 'QDPointRewardWidget.dart';
import 'QDPointWidget.dart';

class QD01MissionAndRewardTabView extends StatelessWidget {
  final FBallResDto fBallResDto;

  QD01MissionAndRewardTabView({required this.fBallResDto, Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QD01MissionAndRewardTabViewViewModel(fBallResDto: fBallResDto),
      child: Consumer<QD01MissionAndRewardTabViewViewModel>(
        builder: (_, model, child) {
          return Container(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    '퀘스트 완료방법',
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
                model.getSuccessSelect(),
                model.hasStartPoint
                    ? Container(
                        child: QDPointWidget(
                            title: "퀘스트 시작 위치",
                            icon: Icon(
                              ForutonaIcon.startflag,
                              size: 16,
                              color: Color(0xffF82929),
                            ),
                            onTap: (position, address) {
                              model.jumpStartPointMapDetail(context,position,address);
                            },
                            position: model.startPoint,
                            address: model.startPointAddress),
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      )
                    : Container(),
                model.hasLimitTime
                    ? QDLimitTimeWidget(
                        seconds: model.limitTimeSeconds,
                      )
                    : Container(),
                QDPointRewardWidget(
                  rewardPoint: 1000,
                  influenceRewardPoint: 1000,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class QD01MissionAndRewardTabViewViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;
  late final QuestBallDisPlayUseCase questBallDisPlayUseCase;

  MapMakerDescriptorContainer _mapMakerDescriptorContainer = sl();

  QD01MissionAndRewardTabViewViewModel({required this.fBallResDto}) {
    questBallDisPlayUseCase = QuestBallDisPlayUseCase(
        fBallResDto: fBallResDto, geoLocatorAdapter: sl());

  }

  bool get hasLimitTime {
    return questBallDisPlayUseCase.ballDescription!.timeLimitFlag!;
  }

  int get limitTimeSeconds {
    return questBallDisPlayUseCase.ballDescription!.limitTimeSec!;
  }

  bool get hasStartPoint {
    return questBallDisPlayUseCase.ballDescription!.startPositionFlag!;
  }

  Position get startPoint {
    var position = Position(
        latitude: questBallDisPlayUseCase.ballDescription!.startPositionLat,
        longitude: questBallDisPlayUseCase.ballDescription!.startPositionLong);
    return position;
  }

  String get startPointAddress {
    return questBallDisPlayUseCase.ballDescription!.startPositionAddress!;
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
        checkInDescriptionText: questBallDisPlayUseCase
            .ballDescription!.checkInPositionDescription,
        photoDescriptionText: questBallDisPlayUseCase
            .ballDescription!.photoCertificationDescription!,
      );
    } else {
      return Container();
    }
  }

  void jumpStartPointMapDetail(BuildContext context,Position position, String address) {
    var qStartFlag = _mapMakerDescriptorContainer.getBitmapDescriptor(MapMakerDescriptorType.QStartFlag);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailMap(
        marker: Marker(
          markerId: MarkerId("QStartFlag"+fBallResDto.ballUuid!),
          icon: qStartFlag,
          position: LatLng(position.latitude!,position.longitude!),
          anchor: Offset(0.5,1)
        ),
        position: position,
        address: address,
      );
    }));

  }
}
