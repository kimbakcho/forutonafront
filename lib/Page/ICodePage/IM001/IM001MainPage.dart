import 'dart:async';
import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagInsertReqDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/MakeCommonPage/MackCommonBottomSheetBody.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonBottomSheetHeader.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonMainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../MakeCommonPage/MakePageMode.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../MakeCommonPage/MakeCommonHeaderSheet.dart';

class IM001MainPage extends StatelessWidget {
  final MakePageMode makePageMode;
  final FBallResDto? preSetBallResDto;
  final List<FBallTagResDto>? preSetFBallTagResDtos;

  IM001MainPage(
      {Key? key,
      this.makePageMode = MakePageMode.create,
      this.preSetBallResDto,
      this.preSetFBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IM001MainPageViewModel(
          buildContext: context,
          makePageMode: makePageMode,
          preSetBallResDto: preSetBallResDto,
          preSetFBallTagResDtos: preSetFBallTagResDtos),
      child: Consumer<IM001MainPageViewModel>(
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
              ballName: "이슈볼",
              makeBottomBodySheet: MackCommonBottomSheetBody(
                ballName: "이슈볼",
                ballContentDescription: "어떤 이슈인가요?",
                initAddress: "로딩중",
                onComplete: model.onComplete,
                makeCommonBottomSheetBodyController:
                    model._im001bottomSheetBodyController,
                onChangeAddress: (value) {
                  model._im001bottomSheetBodyController
                      .changeDisplayAddress(value);
                },
                makePageMode: makePageMode,
                preSetBallResDto: preSetBallResDto,
                preSetFBallTagResDtos: preSetFBallTagResDtos,
              ),
              ballIconPath: "assets/MarkesImages/issueselectballmaker.png",
              preSetAddress: preSetAddress,
              preSetPosition: preSetPosition,
              makeCommonMainPageController: model.makeCommonMainPageController,
              onChangeDisplayAddress: (address) {
                model._im001bottomSheetBodyController
                    .changeDisplayAddress(address);
              },
              makeOpenBottomHeaderSheet: MakeCommonHeaderSheet(
                makePageMode: makePageMode,
                onCreateBall: model._onCreateBall,
                onModifyBall: model._onModifyBall,
                makeCommonHeaderSheetController:
                    model.makeCommonHeaderSheetController,
              ));
        },
      ),
    );
  }
}

class IM001MainPageViewModel extends ChangeNotifier {
  bool isCanComplete = false;
  BuildContext buildContext;
  MakePageMode makePageMode;
  FBallResDto? preSetBallResDto;
  List<FBallTagResDto>? preSetFBallTagResDtos;

  MakeCommonBottomSheetBodyController _im001bottomSheetBodyController =
      MakeCommonBottomSheetBodyController();
  final InsertBallUseCaseInputPort insertBallUseCaseInputPort = sl();

  final UpdateBallUseCaseInputPort updateBallUseCaseInputPort = sl();

  final MakeCommonMainPageController makeCommonMainPageController =
      MakeCommonMainPageController();

  late MakeCommonHeaderSheetController makeCommonHeaderSheetController;

  IM001MainPageViewModel({
    required this.buildContext,
    required this.makePageMode,
    this.preSetBallResDto,
    this.preSetFBallTagResDtos,
  }){
    makeCommonHeaderSheetController = MakeCommonHeaderSheetController(pageLength: 1,makePageMode: makePageMode);
  }

  onComplete(bool value) {
    this.isCanComplete = value;
    makeCommonHeaderSheetController.setIsCanComplete(
        value, makeCommonMainPageController.isBottomOpened, 0);
  }

  _onCreateBall(BuildContext context) async {
    showDialog(
        context: context, builder: (context) => CommonLoadingComponent());

    FBallInsertReqDto fBallInsertReqDto = FBallInsertReqDto();

    var imageItems =
        await _im001bottomSheetBodyController.updateImageAndFillImageUrl();

    IssueBallDescription issueBallDescription = IssueBallDescription();

    issueBallDescription.text = _im001bottomSheetBodyController.getContent();

    issueBallDescription.desimages = [];
    for (int i = 0; i < imageItems.length; i++) {
      FBallDesImages fBallDesImages = new FBallDesImages();
      var item = imageItems[i];
      if (item != null) {
        fBallDesImages.src = item.imageUrl;
      }
      fBallDesImages.index = i;
      issueBallDescription.desimages!.add(fBallDesImages);
    }
    issueBallDescription.youtubeVideoId =
        _im001bottomSheetBodyController.getYoutubeId();

    fBallInsertReqDto.ballName = _im001bottomSheetBodyController.getBallName();
    fBallInsertReqDto.description = json.encode(issueBallDescription);
    fBallInsertReqDto.ballType = FBallType.IssueBall;
    fBallInsertReqDto.placeAddress =
        _im001bottomSheetBodyController.getPlaceAddress();
    fBallInsertReqDto.latitude =
        makeCommonMainPageController.getCurrentPosition()!.latitude;
    fBallInsertReqDto.longitude =
        makeCommonMainPageController.getCurrentPosition()!.longitude;
    fBallInsertReqDto.ballUuid = Uuid().v4();

    var tags = _im001bottomSheetBodyController.getTags();
    fBallInsertReqDto.tags = [];
    for (int i = 0; i < tags.length; i++) {
      TagInsertReqDto tagInsertReqDto = TagInsertReqDto();
      tagInsertReqDto.ballUuid = fBallInsertReqDto.ballUuid;
      tagInsertReqDto.tagItem = tags[i].text;
      fBallInsertReqDto.tags!.add(tagInsertReqDto);
    }

    var fBallResDto =
        await insertBallUseCaseInputPort.insertBall(fBallInsertReqDto);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop(fBallResDto);

    notifyListeners();
  }

  _onModifyBall(BuildContext context) async {
    showDialog(
        context: context, builder: (context) => CommonLoadingComponent());

    var imageItems =
        await _im001bottomSheetBodyController.updateImageAndFillImageUrl();

    FBallUpdateReqDto fBallUpdateReqDto = FBallUpdateReqDto();
    IssueBallDescription issueBallDescription = IssueBallDescription();

    issueBallDescription.text = _im001bottomSheetBodyController.getContent();

    issueBallDescription.desimages = [];
    for (int i = 0; i < imageItems.length; i++) {
      FBallDesImages fBallDesImages = new FBallDesImages();
      var item = imageItems[i];
      if (item != null) {
        fBallDesImages.src = item.imageUrl;
      }
      fBallDesImages.index = i;
      issueBallDescription.desimages!.add(fBallDesImages);
    }
    issueBallDescription.youtubeVideoId =
        _im001bottomSheetBodyController.getYoutubeId();

    fBallUpdateReqDto.ballName = _im001bottomSheetBodyController.getBallName();
    print(fBallUpdateReqDto.ballName);
    fBallUpdateReqDto.description = json.encode(issueBallDescription);
    fBallUpdateReqDto.ballType = FBallType.IssueBall;
    fBallUpdateReqDto.placeAddress =
        _im001bottomSheetBodyController.getPlaceAddress();
    fBallUpdateReqDto.latitude =
        makeCommonMainPageController.getCurrentPosition()!.latitude;
    fBallUpdateReqDto.longitude =
        makeCommonMainPageController.getCurrentPosition()!.longitude;
    fBallUpdateReqDto.ballUuid = preSetBallResDto!.ballUuid;

    var tags = _im001bottomSheetBodyController.getTags();
    fBallUpdateReqDto.tags = [];
    for (int i = 0; i < tags.length; i++) {
      TagInsertReqDto tagInsertReqDto = TagInsertReqDto();
      tagInsertReqDto.ballUuid = fBallUpdateReqDto.ballUuid;
      tagInsertReqDto.tagItem = tags[i].text;
      fBallUpdateReqDto.tags!.add(tagInsertReqDto);
    }

    var fBallResDto =
        await updateBallUseCaseInputPort.updateBall(fBallUpdateReqDto);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop(fBallResDto);

    notifyListeners();
  }
}
