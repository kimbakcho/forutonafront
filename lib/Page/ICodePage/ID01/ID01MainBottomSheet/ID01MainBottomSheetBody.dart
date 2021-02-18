import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Components/FBallReply3/FBallReply3.dart';
import 'package:forutonafront/Components/UserProfileBar/UserProfileBar.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/BallPowerDisplay/BallPowerState.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/Page/ICodePage/ID001/ID001WidgetPart/ID01LikeState.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01BallTitle/ID01BallTitle.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01Pictures/ID01Pictures.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01RemainTimeWidget.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01TextContent.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01YoutubeWidget.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:provider/provider.dart';

class ID01MainBottomSheetBody extends StatefulWidget {
  final FBallResDto fBallResDto;

  final double topPosition;

  const ID01MainBottomSheetBody({Key key, this.fBallResDto, this.topPosition}) : super(key: key);

  @override
  _ID01MainBottomSheetBodyState createState() =>
      _ID01MainBottomSheetBodyState();
}

class _ID01MainBottomSheetBodyState extends State<ID01MainBottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainBottomSheetBodyViewModel(widget.fBallResDto,sl()),
      child: Consumer<ID01MainBottomSheetBodyViewModel>(
          builder: (_, model, child) {
        return Container(
          height: widget.topPosition,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ID01RemainTimeWidget(
                  limitTime: model.fBallResDto.activationTime,
                ),
                ID01BallTitle(fBallResDto: model.fBallResDto),
                Divider(color: Color(0xffE4E7E8),height: 1,),
                UserProfileBar(
                  fUserInfoSimpleResDto: model.fBallResDto.uid,
                ),
                Divider(color: Color(0xffE4E7E8),height: 1,),
                ID01TextContent(
                  content: model.getBallTextContent(),
                ),
                ID01Pictures(
                  desImages: model.getBallDesImages(),
                ),
                ID01YoutubeWidget(
                  youtubeVideoId: model.getBallYoutubeId(),
                ),
                ID01BallPowerState(
                  fBallResDto: model.fBallResDto,
                ),
                FBallReply3(
                  ballUuid: model.fBallResDto.ballUuid,
                )
              ],
            ),
          )

        );
      }),
    );
  }
}

class ID01MainBottomSheetBodyViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;
  IssueBallDisPlayUseCase _issueBallDisPlayUseCase;
  final GeolocatorAdapter geolocatorAdapter;
  ID01MainBottomSheetBodyViewModel(this.fBallResDto, this.geolocatorAdapter){
    _init();
  }

  void _init() {
    _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: fBallResDto, geoLocatorAdapter: geolocatorAdapter);
  }

  getBallTextContent() {
    return _issueBallDisPlayUseCase.descriptionText();
  }

  getBallDesImages() {
    return _issueBallDisPlayUseCase.getDesImages();

  }

  getBallYoutubeId() {
    return _issueBallDisPlayUseCase.getYoutubeId();
  }

}
