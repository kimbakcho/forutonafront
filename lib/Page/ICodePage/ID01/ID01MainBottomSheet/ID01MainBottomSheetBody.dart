import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Components/DetailPage/DBallPictures/DBallPictures.dart';
import 'package:forutonafront/Components/DetailPage/DBallTitle/DBallTitle.dart';
import 'package:forutonafront/Components/DetailPage/DBallTitle/DBallLimitTag.dart';
import 'package:forutonafront/Components/FBallReply3/FBallReply3.dart';
import 'package:forutonafront/Components/UserProfileBar/UserProfileBar.dart';


import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01RemainTimeWidget.dart';
import 'package:forutonafront/Components/DetailPage/DBallTextContent.dart';
import 'package:forutonafront/Components/DetailPage/DBallYoutubeWidget.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:provider/provider.dart';

import '../../../../Components/DetailPage/DBallMode.dart';

class ID01MainBottomSheetBody extends StatefulWidget {
  final FBallResDto? fBallResDto;

  final double? topPosition;

  final DBallMode? id01Mode;

  final List<BallImageItem?>? preViewBallImage;

  final List<FBallTagResDto>? preViewfBallTagResDtos;

  final ID01MainBottomSheetBodyController? id01mainBottomSheetBodyController;

  final double? currentStateProgress;

  const ID01MainBottomSheetBody(
      {Key? key,
      this.fBallResDto,
      this.topPosition,
      this.id01Mode,
      this.preViewBallImage,
      this.preViewfBallTagResDtos,
      this.id01mainBottomSheetBodyController,
      this.currentStateProgress})
      : super(key: key);

  @override
  _ID01MainBottomSheetBodyState createState() =>
      _ID01MainBottomSheetBodyState();
}

class _ID01MainBottomSheetBodyState extends State<ID01MainBottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainBottomSheetBodyViewModel(
          widget.fBallResDto!, sl(), widget.id01Mode!, widget.preViewBallImage,
          id01mainBottomSheetBodyController:
              widget.id01mainBottomSheetBodyController),
      child: Consumer<ID01MainBottomSheetBodyViewModel>(
          builder: (_, model, child) {
        return Container(
            height: widget.topPosition,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ID01RemainTimeWidget(
                        limitTime: model.fBallResDto!.activationTime!,
                      ),
                      DBallTitle(
                          fBallResDto: model.fBallResDto!,
                          dBallMode: widget.id01Mode!,
                          preViewfBallTagResDtos:
                              widget.preViewfBallTagResDtos),
                      Divider(
                        color: Color(0xffE4E7E8),
                        height: 1,
                      ),
                      UserProfileBar(
                        fUserInfoSimpleResDto: model.fBallResDto!.uid,
                      ),
                      Divider(
                        color: Color(0xffE4E7E8),
                        height: 1,
                      ),
                      DBallTextContent(
                        content: model.getBallTextContent(),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: DLimitTag(
                          ballUuid: model.fBallResDto!.ballUuid!,
                          limitCount: 10,
                          mode: model.id01Mode!,
                        ),
                      ),
                      DBallPictures(
                        desImages: model.getBallDesImages(),
                      ),
                      DBallYoutubeWidget(
                        youtubeVideoId: model.getBallYoutubeId(),
                      ),
                      // ID01BallPowerState(
                      //   fBallResDto: model.fBallResDto,
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: widget.currentStateProgress! < 0.6
                                ? widget.topPosition! * 0.7
                                : 150),
                        child: FBallReply3(
                          ballUuid: model.fBallResDto!.ballUuid,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ));
      }),
    );
  }
}

class ID01MainBottomSheetBodyViewModel extends ChangeNotifier {
  final FBallResDto? fBallResDto;
  IssueBallDisPlayUseCase? _issueBallDisPlayUseCase;
  final GeolocatorAdapter? geolocatorAdapter;
  final DBallMode? id01Mode;
  final List<BallImageItem?>? preViewBallImage;

  final ID01MainBottomSheetBodyController? id01mainBottomSheetBodyController;

  ID01MainBottomSheetBodyViewModel(this.fBallResDto, this.geolocatorAdapter,
      this.id01Mode, this.preViewBallImage,
      {this.id01mainBottomSheetBodyController}) {
    _init();
  }

  void _init() {
    if (id01mainBottomSheetBodyController != null) {
      this.id01mainBottomSheetBodyController!._viewModel = this;
    }
    _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: fBallResDto!, geoLocatorAdapter: geolocatorAdapter);
  }

  refreshWidget() {
    _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: fBallResDto!, geoLocatorAdapter: geolocatorAdapter);
    notifyListeners();
  }

  getBallTextContent() {
    return _issueBallDisPlayUseCase!.descriptionText();
  }

  getBallDesImages() {
    if (id01Mode == DBallMode.preview) {
      return preViewBallImage;
    } else {
      return _issueBallDisPlayUseCase!.getDesImages();
    }
  }

  getBallYoutubeId() {
    return _issueBallDisPlayUseCase!.getYoutubeId();
  }
}

class ID01MainBottomSheetBodyController {
  ID01MainBottomSheetBodyViewModel? _viewModel;

  refreshWidget() {
    if (_viewModel != null) {
      _viewModel!.refreshWidget();
    }
  }
}
