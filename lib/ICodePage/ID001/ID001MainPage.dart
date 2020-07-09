import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapCircleAnimationWithContainer.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyWidget.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPageViewModel.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ID001MainPage extends StatefulWidget {
  IssueBall issueBall;

  ID001MainPage({this.issueBall});

  @override
  _ID001MainPageState createState() => _ID001MainPageState();
}

class _ID001MainPageState extends State<ID001MainPage>
    with WidgetsBindingObserver {
  UniqueKey googleMapKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    reRenderGoogleMap();
  }

  UniqueKey reRenderGoogleMap() => googleMapKey = UniqueKey();

  ScrollController mainScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ID001MainPageViewModel>(
        create: (_) => ID001MainPageViewModel(
            context: context,
            issueBall: widget.issueBall,
            authUserCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl(),
          mainScrollController: mainScrollController,
          issueBallUseCaseInputPort: sl(),
          issueBallValuationUseCaseInputPort: sl(),
          tagFromBallUuidUseCaseInputPort: sl(),
          userInfoSimple1UseCaseInputPort:sl(),
        ),
        child: Builder(
          builder: (context) {
            return Stack(children: <Widget>[
              Scaffold(
                  body: Container(
                      color: Colors.white,
                      child:
                          context.watch<ID001MainPageViewModel>().isInitFinish
                              ? mainBodyStack(context)
                              : Container())),
              context.watch<ID001MainPageViewModel>().isLoading
                  ? CommonLoadingComponent()
                  : Container()
            ]);
          },
        ));
  }

  Stack mainBodyStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(children: <Widget>[
                  topHeaderBar(context),
                  Expanded(
                    child: mainBodyListView(context),
                  )
                ]))),
      ],
    );
  }

  ListView mainBodyListView(BuildContext context) {
    return ListView(
        controller:
            context.watch<ID001MainPageViewModel>().mainScrollController,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        children: <Widget>[
          googleMapBar(context),
          issueBallNameBar(),
          issueBallTitleWithStatueBar(context),
          didver(2),
          context.watch<ID001MainPageViewModel>().showMoreDetailFlag
              ? placeAddressBar(context)
              : Container(),
          context.watch<ID001MainPageViewModel>().showMoreDetailFlag
              ? activeTimeBar(context)
              : Container(),
          context.watch<ID001MainPageViewModel>().showMoreDetailFlag
              ? contributorBar(context)
              : Container(),
          context.watch<ID001MainPageViewModel>().showMoreDetailFlag
              ? didver(2)
              : Container(),
          makerProfileBar(context),
          didver(2),
          issueTextContentBar(context),
          context.watch<ID001MainPageViewModel>().getImageContentBar(context),
          context.watch<ID001MainPageViewModel>().issueBall.isMainPicture()
              ? didver(2)
              : Container(),
          context.watch<ID001MainPageViewModel>().issueBall.hasYoutubeVideo()
              ? youtubeBar(context)
              : Container(),
          context.watch<ID001MainPageViewModel>().issueBall.hasYoutubeVideo()
              ? didver(2)
              : Container(),
          context.watch<ID001MainPageViewModel>().tagChips.length > 0
              ? tagBar(context)
              : Container(),
          context.watch<ID001MainPageViewModel>().tagChips.length > 0
              ? didver(2)
              : Container(),
          FBallReplyWidget(
              context.watch<ID001MainPageViewModel>().issueBall.ballUuid),
          didver(4),
          context.watch<ID001MainPageViewModel>().showFBallValuation
              ? ballValuationBar(context)
              : Container()
        ]);
  }

  FlatButton issueBallTitleWithStatueBar(BuildContext context) {
    return FlatButton(
        onPressed:
            context.watch<ID001MainPageViewModel>().toggleMoreDetailToggle,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            issueBallTitleBar(context),
            conditionStatueBar(context)
          ],
        ));
  }

  Container ballValuationBar(BuildContext context) {
    return Container(
        color: Color(0xffF5F5F5),
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Text("평가하기",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Color(0xff454f63),
                )),
            margin: EdgeInsets.only(bottom: 8),
          ),
          Container(
              child: RichText(
                  text: TextSpan(
                      text:
                          context.watch<ID001MainPageViewModel>().userNickName,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff3497FD),
                      ),
                      children: [
                TextSpan(
                    text: context
                        .watch<ID001MainPageViewModel>()
                        .getFBallValuationText(),
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
              ]))),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(children: <Widget>[
                Container(
                    height: 32.00,
                    width: 70.00,
                    child: FlatButton(
                        onPressed:
                            context.watch<ID001MainPageViewModel>().plusBtnTap,
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              ForutonaIcon.like,
                              color: context
                                  .watch<ID001MainPageViewModel>()
                                  .getValuationIconAndTextColor(
                                      FBallValuationState.Like),
                              size: 15,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text("+1",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: context
                                          .watch<ID001MainPageViewModel>()
                                          .getValuationIconAndTextColor(
                                              FBallValuationState.Like),
                                    )))
                          ],
                        )),
                    decoration: BoxDecoration(
                      color: context
                          .watch<ID001MainPageViewModel>()
                          .getValuationBoxColor(FBallValuationState.Like),
                      border: Border.all(
                        width: 2.00,
                        color: context
                            .watch<ID001MainPageViewModel>()
                            .getValuationBorderColor(FBallValuationState.Like),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff455b63).withOpacity(0.10),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.00),
                    )),
                Container(
                    height: 32.00,
                    width: 70.00,
                    margin: EdgeInsets.only(left: 16),
                    child: FlatButton(
                        onPressed:
                            context.watch<ID001MainPageViewModel>().minusBtnTap,
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              ForutonaIcon.dislike,
                              color: context
                                  .watch<ID001MainPageViewModel>()
                                  .getValuationIconAndTextColor(
                                      FBallValuationState.DisLike),
                              size: 15,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text("-1",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: context
                                          .watch<ID001MainPageViewModel>()
                                          .getValuationIconAndTextColor(
                                              FBallValuationState.DisLike),
                                    )))
                          ],
                        )),
                    decoration: BoxDecoration(
                      color: context
                          .watch<ID001MainPageViewModel>()
                          .getValuationBoxColor(FBallValuationState.DisLike),
                      border: Border.all(
                        width: 2.00,
                        color: context
                            .watch<ID001MainPageViewModel>()
                            .getValuationBorderColor(
                                FBallValuationState.DisLike),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff455b63).withOpacity(0.10),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.00),
                    ))
              ]))
        ]));
  }

  Container tagBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: context.watch<ID001MainPageViewModel>().tagChips,
      ),
    );
  }

  Container youtubeBar(BuildContext context) {
    return Container(
        height: 135,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: context
                          .watch<ID001MainPageViewModel>()
                          .currentYoutubeImage !=
                      null
                  ? Container(
                      height: 90.00,
                      width: 124.00,
                      child: FlatButton(
                          onPressed: () {
                            context
                                .read<ID001MainPageViewModel>()
                                .goYoutubeIntent(context
                                    .read<ID001MainPageViewModel>()
                                    .issueBall
                                    .getDisplayYoutubeVideoId());
                          },
                          padding: EdgeInsets.all(0),
                          child: Container(
                              height: 50.00,
                              width: 50.00,
                              child:
                                  Icon(ForutonaIcon.yplay, color: Colors.white),
                              decoration: BoxDecoration(
                                color: Color(0xff454f63).withOpacity(0.3),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.00, 6.00),
                                    color: Color(0xff321636).withOpacity(0.7),
                                    blurRadius: 12,
                                  )
                                ],
                                shape: BoxShape.circle,
                              ))),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(context
                                .watch<ID001MainPageViewModel>()
                                .currentYoutubeImage),
                          ),
                          borderRadius: BorderRadius.circular(12.00)))
                  : Container(
                      height: 90.00, width: 124.00, child: Text("로딩중"))),
          Positioned(
              top: 0,
              left: 139,
              child: Container(
                  width: MediaQuery.of(context).size.width - 170,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        context
                                    .watch<ID001MainPageViewModel>()
                                    .currentYoutubeTitle !=
                                null
                            ? Container(
                                child: Text(
                                    context
                                        .watch<ID001MainPageViewModel>()
                                        .currentYoutubeTitle,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Color(0xff454f63),
                                    )),
                                margin: EdgeInsets.only(bottom: 10),
                              )
                            : Container(),
                        context
                                    .watch<ID001MainPageViewModel>()
                                    .currentYoutubeAuthor !=
                                null
                            ? Container(
                                child: Text(
                                    context
                                        .watch<ID001MainPageViewModel>()
                                        .currentYoutubeAuthor,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 10,
                                      color: Color(0xff78849e),
                                    )),
                              )
                            : Container(),
                        context
                                    .watch<ID001MainPageViewModel>()
                                    .currentYoutubeView !=
                                null
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "조회수${context.watch<ID001MainPageViewModel>().currentYoutubeView}회•"
                                    "${DateFormat("yyyy.MM.dd").format(context.watch<ID001MainPageViewModel>().currentYoutubeUploadDate.toLocal())}",
                                    style: GoogleFonts.notoSans(
                                      fontSize: 10,
                                      color: Color(0xff78849e),
                                    )),
                              )
                            : Container()
                      ])))
        ]));
  }

  Container issueTextContentBar(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 23, 16, 24),
        child: Text(
            context
                .watch<ID001MainPageViewModel>()
                .issueBall
                .getDisplayDescriptionText(),
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontSize: 14,
              color: Color(0xff454f63),
            )));
  }

  Container makerProfileBar(BuildContext context) {
    return Container(
        height: 70,
        width: 360,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 38.00,
                width: 38.00,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        context
                            .watch<ID001MainPageViewModel>()
                            .issueBall
                            .profilePictureUrl,
                      ),
                    ),
                    shape: BoxShape.circle),
              )),
          Positioned(
              top: 0,
              left: 48,
              child: Container(
                child: Text(
                    context
                        .watch<ID001MainPageViewModel>()
                        .getMakerUserNickName(),
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff000000),
                    )),
              )),
          Positioned(
            top: 18,
            left: 48,
            child: Container(
                child: context.watch<ID001MainPageViewModel>().makerUserInfo !=
                        null
                    ? Text(
                        "유저영향력 ${context.watch<ID001MainPageViewModel>().makerUserInfo.cumulativeInfluence}BP • "
                        "팔로워 ${context.watch<ID001MainPageViewModel>().makerUserInfo.followCount}명",
                        style: GoogleFonts.notoSans(
                          fontSize: 12,
                          color: Color(0xff78849e),
                        ))
                    : Container()),
          )
        ]));
  }

  Container didver(double height) {
    return Container(
      height: height,
      width: 360.00,
      decoration: BoxDecoration(
        color: Color(0xffE4E7E8),
        borderRadius: BorderRadius.circular(1.00),
      ),
    );
  }

  Container issueBallNameBar() {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        margin: EdgeInsets.only(bottom: 8, top: 16),
        child: Text("이슈볼",
            style: GoogleFonts.notoSans(
              fontSize: 12,
              color: Color(0xffff4f9a),
            )));
  }

  Container conditionStatueBar(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 0, bottom: 31),
        child: Row(children: <Widget>[
          Container(
            width: 12,
            height: 12,
            child: Icon(
              ForutonaIcon.like,
              color: Color(0xff78849e),
              size: 12,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                  "${context.watch<ID001MainPageViewModel>().issueBall.getDisplayLikeCount()}회",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff78849e),
                  ))),
          Container(
              width: 12,
              height: 12,
              margin: EdgeInsets.only(left: 8),
              child: Icon(
                ForutonaIcon.dislike,
                color: Color(0xff78849e),
                size: 12,
              )),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                  "${context.watch<ID001MainPageViewModel>().issueBall.getDisplayDisLikeCount()}회",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff78849e),
                  ))),
          Container(
              width: 12,
              height: 12,
              margin: EdgeInsets.only(left: 8),
              child: Icon(
                ForutonaIcon.visibility,
                color: Color(0xff78849e),
                size: 12,
              )),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                  "${context.watch<ID001MainPageViewModel>().issueBall.ballHits}회",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff78849e),
                  ))),
          Container(
            width: 12,
            height: 12,
            margin: EdgeInsets.only(left: 8, bottom: 4),
            child: Text("•",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xff78849e),
                )),
          ),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                  context
                      .watch<ID001MainPageViewModel>()
                      .issueBall
                      .getDisplayMakeTime(),
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff78849e),
                  ))),
        ]));
  }

  Container issueBallTitleBar(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 0, right: 48),
              child: Text(
                  context.watch<ID001MainPageViewModel>().issueBall.ballName,
                  overflow: TextOverflow.ellipsis,
                  maxLines:
                      context.watch<ID001MainPageViewModel>().showMoreDetailFlag
                          ? 3
                          : 2,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ))),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                  width: 30,
                  height: 30,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        context
                                .watch<ID001MainPageViewModel>()
                                .showMoreDetailFlag
                            ? ForutonaIcon.up_arrow
                            : ForutonaIcon.down_arrow,
                        color: Color(0xff78849E),
                        size: 13,
                      ))))
        ]));
  }

  Container contributorBar(BuildContext context) {
    return Container(
        height: 68,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 9),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 32.00,
                  width: 32.00,
                  child: Icon(
                    ForutonaIcon.contributor,
                    color: Color(0xff707070),
                    size: 15,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe4e7e8),
                  ),
                )),
            Positioned(
              top: 0,
              left: 44,
              child: Text("기여자",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
                top: 21,
                left: 44,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                      '${context.watch<ID001MainPageViewModel>().issueBall.contributor}명이 반응 하였습니다.',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: Color(0xff78849e),
                      )),
                ))
          ],
        ));
  }

  Container activeTimeBar(BuildContext context) {
    return Container(
        height: 68,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 9),
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 32.00,
                width: 32.00,
                child: Icon(
                  ForutonaIcon.whatshot,
                  color: Color(0xff707070),
                  size: 15,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffe4e7e8),
                ),
              )),
          Positioned(
            top: 0,
            left: 44,
            child: Text("남은 시간",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
              top: 21,
              left: 44,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                    context
                        .watch<ID001MainPageViewModel>()
                        .issueBall
                        .getDisplayRemainingTime(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Color(0xff78849e),
                    )),
              ))
        ]));
  }

  Container placeAddressBar(BuildContext context) {
    return Container(
        height: 68,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 9),
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 32.00,
                width: 32.00,
                child: Icon(
                  Icons.location_on,
                  color: Color(0xff707070),
                  size: 15,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffe4e7e8),
                ),
              )),
          Positioned(
            top: 0,
            left: 44,
            child: Text("설치 장소",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
              top: 21,
              left: 44,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                    context
                        .watch<ID001MainPageViewModel>()
                        .issueBall
                        .placeAddress,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Color(0xff78849e),
                    )),
              ))
        ]));
  }

  Container googleMapBar(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
          GoogleMap(
            key: googleMapKey,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            initialCameraPosition:
                context.watch<ID001MainPageViewModel>().initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Center(child: MapCircleAnimationWithContainer.fromIssueBall()),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 244,
              child: FlatButton(
                onPressed: () {},
              ))
        ]),
        height: 244);
  }

  Container topHeaderBar(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      child: Row(children: <Widget>[
        Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.only(left: 8),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: context.watch<ID001MainPageViewModel>().backBtnTap,
              child: Icon(
                ForutonaIcon.leftarrow,
                color: Color(0xff454F63),
                size: 15,
              )),
          alignment: Alignment.center,
        ),
        context.watch<ID001MainPageViewModel>().isBallNameScrollOver()
            ? Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
                    child: Text(
                      context
                          .watch<ID001MainPageViewModel>()
                          .issueBall
                          .ballName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )))
            : Spacer(),
        Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.only(left: 8),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                ForutonaIcon.share,
                color: Color(0xff454F63),
                size: 20,
              )),
          alignment: Alignment.center,
        ),
        Container(
          width: 32,
          height: 32,
          margin: EdgeInsets.only(right: 16),
          padding: EdgeInsets.only(left: 8),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed:
                  context.watch<ID001MainPageViewModel>().showBallSetting,
              child: Icon(
                ForutonaIcon.dots,
                color: Color(0xff454F63),
                size: 16,
              )),
          alignment: Alignment.center,
        )
      ]),
      decoration: BoxDecoration(color: Color(0xffffffff).withOpacity(0.9)),
    );
  }
}
