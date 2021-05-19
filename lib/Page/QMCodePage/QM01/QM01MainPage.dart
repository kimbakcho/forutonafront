import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/QuestBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagInsertReqDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Page/MakeCommonPage/MackCommonBottomSheetBody.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonHeaderSheet.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonMainPage.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakePageMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'QM01002Sheet/QM01002Sheet.dart';
import 'QM01002Sheet/QuestSelectMode.dart';

class QM01MainPage extends StatelessWidget {
  final MakePageMode makePageMode;
  final FBallResDto? preSetBallResDto;
  final List<FBallTagResDto>? preSetFBallTagResDtos;

  QM01MainPage({Key? key,
    required this.makePageMode,
    this.preSetBallResDto,
    this.preSetFBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QM01MainPageViewModel(
        makePageMode: makePageMode,
        preSetBallResDto: preSetBallResDto,
        preSetFBallTagResDtos: preSetFBallTagResDtos
      ),
      child: Consumer<QM01MainPageViewModel>(
        builder: (_, model, child) {
          String? preSetAddress;
          Position? preSetPosition;
          if (preSetBallResDto != null) {
            preSetAddress = preSetBallResDto!.placeAddress;
            preSetPosition = Position(
                longitude: preSetBallResDto!.longitude,
                latitude: preSetBallResDto!.latitude);
          }
          return MakeCommonMainPage(
            makePageMode: makePageMode,
            ballName: "퀘스트볼",
            ballIconPath: "assets/MarkesImages/questballmaker.png",
            makeBottomBodySheet: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: model.pageController,
              onPageChanged: (value) {
                FocusScope.of(context).unfocus();
                model.makeCommonHeaderSheetController.setCurrentPage(
                    value, model.makeCommonMainPageController.isBottomOpened);
              },
              children: [
                MackCommonBottomSheetBody(
                  ballName: "퀘스트볼",
                  ballContentDescription: "어떤 퀘스트 인가요?",
                  makeCommonBottomSheetBodyController:
                  model.makeCommonBottomSheetBodyController,
                  makePageMode: makePageMode,
                  preSetBallResDto: preSetBallResDto,
                  preSetFBallTagResDtos: preSetFBallTagResDtos,
                  onComplete: (value) {
                    model.makeCommonHeaderSheetController.setIsCanComplete(
                        value,
                        model.makeCommonMainPageController.isBottomOpened, 0);
                  },
                  onChangeAddress: (value) {},
                  initAddress: "로딩중",
                ),
                QM01002Sheet(
                  makePageMode: model.makePageMode,
                  preSetBallResDto: model.preSetBallResDto,
                  controller: model.qm01002sheetController,
                  onComplete: (value) {
                    model.makeCommonHeaderSheetController.setIsCanComplete(
                        value,
                        model.makeCommonMainPageController.isBottomOpened, 1);
                  },
                )
              ],
            ),
            preSetAddress: preSetAddress,
            preSetPosition: preSetPosition,
            onChangeDisplayAddress: (address) {
              model.makeCommonBottomSheetBodyController
                  .changeDisplayAddress(address);
            },
            makeCommonMainPageController: model.makeCommonMainPageController,
            makeOpenBottomHeaderSheet: MakeCommonHeaderSheet(
              makePageMode: makePageMode,
              onModifyBall: (context) {
                model.onModifyBall(context);
              },
              onCreateBall: (context) {
                model.onCreateBall(context);
              },
              onNextPage: (value) {
                model.pageController.jumpToPage(value);
                model.makeCommonHeaderSheetController.setCurrentPage(
                    value, model.makeCommonMainPageController.isBottomOpened);
              },
              makeCommonHeaderSheetController:
              model.makeCommonHeaderSheetController,
            ),
          );
        },
      ),
    );
  }
}

class QM01MainPageViewModel extends ChangeNotifier {

  final MakePageMode makePageMode;
  final FBallResDto? preSetBallResDto;

  MakeCommonBottomSheetBodyController makeCommonBottomSheetBodyController =
  MakeCommonBottomSheetBodyController();

  MakeCommonMainPageController makeCommonMainPageController =
  MakeCommonMainPageController();

  late MakeCommonHeaderSheetController makeCommonHeaderSheetController;

  PageController pageController = PageController();

  QM01002SheetController qm01002sheetController = QM01002SheetController();

  InsertBallUseCaseInputPort _insertBallUseCaseInputPort = sl();

  UpdateBallUseCaseInputPort _updateBallUseCaseInputPort = sl();

  final List<FBallTagResDto>? preSetFBallTagResDtos;

  QM01MainPageViewModel({required this.makePageMode,this.preSetBallResDto,this.preSetFBallTagResDtos}){
    makeCommonHeaderSheetController = MakeCommonHeaderSheetController(pageLength: 2,makePageMode: makePageMode);
  }

  onCreateBall(BuildContext context) async {
    showDialog(
        context: context, builder: (context) => CommonLoadingComponent());
    notifyListeners();

    FBallInsertReqDto fBallInsertReqDto = FBallInsertReqDto();

    fBallInsertReqDto.ballType = FBallType.QuestBall;
    fBallInsertReqDto.ballUuid = Uuid().v4();
    fBallInsertReqDto.longitude =
        makeCommonMainPageController.getCurrentPosition()!.longitude;
    fBallInsertReqDto.latitude =
        makeCommonMainPageController.getCurrentPosition()!.latitude;
    fBallInsertReqDto.ballName =
        makeCommonBottomSheetBodyController.getBallName();
    fBallInsertReqDto.placeAddress =
        makeCommonBottomSheetBodyController.getPlaceAddress();
    fBallInsertReqDto.tags =
        makeCommonBottomSheetBodyController.getTags().map((e) {
          TagInsertReqDto item = TagInsertReqDto();
          item.ballUuid = fBallInsertReqDto.ballUuid;
          item.tagItem = e.text;
          return item;
        }).toList();

    var questBallDescription = await makeQuestBallDescription();

    fBallInsertReqDto.description = json.encode(questBallDescription);

    await _insertBallUseCaseInputPort.insertBall(fBallInsertReqDto);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void onModifyBall(BuildContext context) async {


    FBallUpdateReqDto fBallUpdateReqDto =  FBallUpdateReqDto();

    fBallUpdateReqDto.ballUuid = preSetBallResDto!.ballUuid!;

    fBallUpdateReqDto.longitude =
        makeCommonMainPageController.getCurrentPosition()!.longitude;
    fBallUpdateReqDto.latitude =
        makeCommonMainPageController.getCurrentPosition()!.latitude;
    fBallUpdateReqDto.ballName =
        makeCommonBottomSheetBodyController.getBallName();
    fBallUpdateReqDto.placeAddress =
        makeCommonBottomSheetBodyController.getPlaceAddress();
    fBallUpdateReqDto.tags =
        makeCommonBottomSheetBodyController.getTags().map((e) {
          TagInsertReqDto item = TagInsertReqDto();
          item.ballUuid = fBallUpdateReqDto.ballUuid;
          item.tagItem = e.text;
          return item;
        }).toList();

    var questBallDescription = await makeQuestBallDescription();

    fBallUpdateReqDto.description = json.encode(questBallDescription);

    await _updateBallUseCaseInputPort.updateBall(fBallUpdateReqDto);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<QuestBallDescription> makeQuestBallDescription() async {
    var questBallDescription = QuestBallDescription();
    questBallDescription.text =
        makeCommonBottomSheetBodyController.getContent();

    var imageItems =
        await makeCommonBottomSheetBodyController.updateImageAndFillImageUrl();

    questBallDescription.desimages = [];
    for (int i = 0; i < imageItems.length; i++) {
      FBallDesImages fBallDesImages = new FBallDesImages();
      var item = imageItems[i];
      if (item != null) {
        fBallDesImages.src = item.imageUrl;
      }
      fBallDesImages.index = i;
      questBallDescription.desimages!.add(fBallDesImages);
    }

    questBallDescription.youtubeVideoId =
        makeCommonBottomSheetBodyController.getYoutubeId();

    questBallDescription.timeLimitFlag =
        qm01002sheetController.getTimeLimitFlag();

    if (qm01002sheetController.getSuccessSelectMode() ==
        QuestSelectMode.CheckInWithPhotoCertification) {
      questBallDescription.checkInAddress =
          qm01002sheetController.getSelectCheckInAddress();

      questBallDescription.checkInPositionLat =
          qm01002sheetController.getSelectCheckInPosition()!.latitude;

      questBallDescription.checkInPositionLong =
          qm01002sheetController.getSelectCheckInPosition()!.longitude;

      questBallDescription.isOpenCheckInPosition = qm01002sheetController.isOpenCheckInPosition();

      questBallDescription.checkInPositionDescription = qm01002sheetController.getCheckInDescription();
    }
    if (qm01002sheetController.getTimeLimitFlag()) {
      questBallDescription.limitTimeSec =
          qm01002sheetController.getLimitTime()!.inSeconds;
    }
    questBallDescription.photoCertificationDescription =
        qm01002sheetController.getPhotoCertificationDescription();

    questBallDescription.successSelectMode =
        qm01002sheetController.getSuccessSelectMode();

    questBallDescription.startPositionFlag =
        qm01002sheetController.getStartPositionFlag();

    if (qm01002sheetController.getStartPositionFlag()) {
      questBallDescription.startPositionLong =
          qm01002sheetController.getSelectStartPosition()!.longitude;
      questBallDescription.startPositionLat =
          qm01002sheetController.getSelectStartPosition()!.latitude;
      questBallDescription.startPositionAddress =
          qm01002sheetController.getSelectStartPositionAddress();
    }
    return questBallDescription;

  }
}
