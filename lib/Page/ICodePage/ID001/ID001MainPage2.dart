import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Components/FBallReply2/BasicReViewsContentBars.dart';
import 'package:forutonafront/Components/FBallReply2/BasicReviews.dart';
import 'package:forutonafront/Components/FBallReply3/FBallReply3.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001ActionBottomBar.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001MakerInfo.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Map.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001ReviewsPageBtn.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01Pictures/ID01Pictures.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'ID001Mode.dart';
import 'ID001WidgetPart/ID001AppBar.dart';
import 'ID001WidgetPart/ID001TagList.dart';
import '../ID01/ID01Component/ID01TextContent.dart';
import 'ID001WidgetPart/ID001Title.dart';
import '../ID01/ID01Component/ID01YoutubeWidget.dart';

class ID001MainPage2 extends StatefulWidget {
  final String _ballUuid;

  final ID001Mode id001mode;

  final FBallResDto preViewResDto;
  final List<BallImageItem> preViewBallImage;

  final Function onCreateBall;

  ID001MainPage2(
      {String ballUuid,
      this.id001mode = ID001Mode.publish,
      this.preViewBallImage,
      this.preViewResDto,
      this.onCreateBall})
      : _ballUuid = ballUuid;

  @override
  _ID001MainPage2State createState() =>
      _ID001MainPage2State(ballUuid: _ballUuid);
}

class _ID001MainPage2State extends State<ID001MainPage2> {
  final String _ballUuid;

  _ID001MainPage2State({String ballUuid}) : _ballUuid = ballUuid;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        key: Key(_ballUuid),
        create: (_) {
          var id001mainPage2ViewModel = ID001MainPage2ViewModel(
              ballUuid: _ballUuid,
              id001mode: widget.id001mode,
              preViewBallImage: widget.preViewBallImage,
              preViewResDto: widget.preViewResDto,
              selectBallUseCaseInputPort: sl(),
              fireBaseAuthAdapterForUseCase: sl(),
              valuationMediator: sl(),
              geolocatorAdapter: sl());
          id001mainPage2ViewModel.init();
          return id001mainPage2ViewModel;
        },
        child: Consumer<ID001MainPage2ViewModel>(builder: (_, model, __) {
          return Stack(children: <Widget>[Scaffold(body: mainBody(model))]);
        }));
  }

  Widget mainBody(ID001MainPage2ViewModel model) {
    return model.isLoadBallFinish()
        ? Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ID001AppBar(
                      model: model,
                      ballName: model.getBallTitle(),
                      listViewScrollerController: model.detailPageController,
                    ),
                    Expanded(
                      child: ListView(
                          controller: model.detailPageController,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 52),
                          children: <Widget>[
                            ID001Title(
                              ballTitle: model.getBallTitle(),
                              hits: model.getBallHits(),
                              makeTime: model.getMakeTime(),
                            ),
                            ID001TagList(ballUuid: model.getBallUuid()),
                            ID001Map(
                              ballPosition: model.getBallPosition(),
                              ballAddress: model.getBallAddress(),
                              mapMakerDescriptorContainer: sl(),
                              ballUuid: model.getBallUuid(),
                              mapBallMarkerFactory: sl(),
                              geoLocationUtilForeGroundUseCase: sl(),
                            ),
                            ID001MakerInfo(
                              userNickName: model.getMakerNickName(),
                              userProfileImageUrl: model.getMakerProfileUrl(),
                              userFollower: model.getMakerFollower(),
                              userInfluencePower:
                                  model.getMakerInfluencePower(),
                            ),
                            ID01TextContent(
                              content: model.getBallTextContent(),
                              makeTime: model.getBallMakeTime(),
                            ),
                            ID01Pictures(
                              desImages: model.getBallDesImages(),
                            ),
                            ID01YoutubeWidget(
                              youtubeVideoId: model.getBallYoutubeId(),
                            ),
                            BasicReviews(
                              reviewInertMediator: model.reviewInertMediator,
                              reviewCountMediator: model.reviewCountMediator,
                              ballUuid: model.getBallUuid(),
                            ),
                            FBallReply3(
                              ballUuid: model.ballUuid,
                            )
                          ]),
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  height: 52,
                  child: ID001ActionBottomBar(
                      ballUuid: model.getBallUuid(),
                      reviewInertMediator: model.reviewInertMediator,
                      reviewUpdateMediator: model.reviewUpdateMediator,
                      reviewDeleteMediator: model.reviewDeleteMediator,
                      reviewCountMediator: model.reviewCountMediator),
                ),
                widget.id001mode == ID001Mode.preview
                    ? Positioned(
                        bottom: 80,
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              if (widget.onCreateBall != null) {
                                widget.onCreateBall();
                              }
                            },
                            color: Color(0xff3497FD),
                            child: Text("등록 하기",
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: const Color(0xfff9f9f9),
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ))
                    : Container()
              ],
            ))
        : Container();
  }
}
