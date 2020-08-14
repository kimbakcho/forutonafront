import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsContentBars.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReviews.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001ActionBottomBar.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001LikeState.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001MakerInfo.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001Map.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001Pictures.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001ReviewsPageBtn.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'ID001WidgetPart/ID001AppBar.dart';
import 'ID001WidgetPart/ID001TagList.dart';
import 'ID001WidgetPart/ID001TextContent.dart';
import 'ID001WidgetPart/ID001Title.dart';
import 'ID001WidgetPart/ID001YoutubeWidget.dart';

class ID001MainPage2 extends StatefulWidget {
  final String _ballUuid;

  ID001MainPage2({String ballUuid}) : _ballUuid = ballUuid;

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
        create: (_) => ID001MainPage2ViewModel(
            ballUuid: _ballUuid,
            selectBallUseCaseInputPort: sl(),
            fireBaseAuthAdapterForUseCase: sl()),
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
                    ID001AppBar(model: model),
                    Expanded(
                      child: ListView(
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
                              geoLocationUtilForeGroundUseCase: sl(),
                            ),
                            ID001MakerInfo(
                              userNickName: model.getMakerNickName(),
                              userProfileImageUrl: model.getMakerProfileUrl(),
                              userFollower: model.getMakerFollower(),
                              userInfluencePower:
                                  model.getMakerInfluencePower(),
                            ),
                            ID001TextContent(
                              content: model.getBallTextContent(),
                              makeTime: model.getBallMakeTime(),
                            ),
                            ID001Pictures(
                              desImages: model.getBallDesImages(),
                            ),
                            ID001YoutubeWidget(
                              youtubeVideoId: model.getBallYoutubeId(),
                            ),
                            ID001LikeState(
                              ballUuid: model.getBallUuid(),
                              ballActivationTime: model.getBallActivationTime(),
                            ),
                            BasicReviews(
                              reviewInertMediator: model.reviewInertMediator,
                              ballUuid: model.getBallUuid(),
                            ),
                            BasicReViewsContentBars(
                              reviewInertMediator: model.reviewInertMediator,
                              canSubReplyInsert: false,
                              showEditBtn: false,
                              showChildReply: false,
                              ballUuid: model.getBallUuid(),
                              listable: false,
                              pageLimit: 3,
                            ),
                            ID001ReviewsPageBtn(
                              ballUuid: _ballUuid,
                            )
                          ]),
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  height: 52,
                  child: ID001ActionBottomBar(ballUuid: model.getBallUuid()),
                )
              ],
            ))
        : Container();
  }
}
