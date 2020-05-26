import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapCircleAni.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyWidget.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPageViewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ID001MainPage extends StatelessWidget {
  final String fBallUuid;
  final FBallResDto fBallResDto;

  ID001MainPage(this.fBallUuid,{this.fBallResDto}) {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(0.5),
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(statueBar);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001MainPageViewModel(context, fBallUuid,fBallResDto: fBallResDto),
        child: Consumer<ID001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Colors.white,
                    child: model.isInitFinish ?
                    Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: MapCircleAni(model.googleMapCircleController),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                    controller: model.mainScrollController,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),
                                    children: <Widget>[
                                      googleMapBar(model, context),
                                      issueBallNameBar(),
                                      issueBallTitleBar(model),
                                      conditionStatueBar(model),
                                      didver(),
                                      model.showMoreDetailFlag
                                          ? placeAddressBar(model)
                                          : Container(),
                                      model.showMoreDetailFlag
                                          ? activeTimeBar(model)
                                          : Container(),
                                      model.showMoreDetailFlag
                                          ? contributorBar(model)
                                          : Container(),
                                      model.showMoreDetailFlag
                                          ? didver()
                                          : Container(),
                                      makerProfileBar(model),
                                      didver(),
                                      issueTextContentBar(model),
                                      model.getImageContentBar(context),
                                      model.issueBallDescriptionDto.desimages
                                                  .length !=
                                              0
                                          ? didver()
                                          : Container(),
                                      model.issueBallDescriptionDto
                                                  .youtubeVideoId !=
                                              null
                                          ? youtubeBar(model, context)
                                          : Container(),
                                      model.issueBallDescriptionDto
                                                  .youtubeVideoId !=
                                              null
                                          ? didver()
                                          : Container(),
                                      model.tagChips.length > 0
                                          ? tagBar(model)
                                          : Container(),
                                      model.tagChips.length > 0
                                          ? didver()
                                          : Container(),
                                      FBallReplyWidget(
                                          model.fBallUuid
                                      ),
                                      model.showFBallValuation()
                                          ? ballValuationBar(model)
                                          : Container()
                                    ]))),
                        Positioned(
                            top: MediaQuery.of(context).padding.top,
                            left: 0,
                            child: topHeaderBar(model, context))
                      ],
                    ):Container() )),
            model.getIsLoading() ? CommonLoadingComponent() : Container()
          ]);
        }));
  }

  Container ballValuationBar(ID001MainPageViewModel model) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Text("평가하기",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Color(0xff454f63),
                )),
            margin: EdgeInsets.only(bottom: 8),
          ),
          Container(
              child: RichText(
                  text: TextSpan(
                      text: model.userNickName,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff3497FD),
                      ),
                      children: [
                TextSpan(
                    text: model.getFBallValuationText(),
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
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
                        onPressed: model.onPlusBtn,
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              ForutonaIcon.like,
                              color: model.getValuationIconAndTextColor(
                                  FBallValuationState.Like),
                              size: 15,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text("+1",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: model.getValuationIconAndTextColor(
                                          FBallValuationState.Like),
                                    )))
                          ],
                        )),
                    decoration: BoxDecoration(
                      color:
                          model.getValuationBoxColor(FBallValuationState.Like),
                      border: Border.all(
                        width: 2.00,
                        color: model
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
                        onPressed: model.onMinusBtn,
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              ForutonaIcon.dislike,
                              color: model.getValuationIconAndTextColor(
                                  FBallValuationState.DisLike),
                              size: 15,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text("-1",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: model.getValuationIconAndTextColor(
                                          FBallValuationState.DisLike),
                                    )))
                          ],
                        )),
                    decoration: BoxDecoration(
                      color: model
                          .getValuationBoxColor(FBallValuationState.DisLike),
                      border: Border.all(
                        width: 2.00,
                        color: model.getValuationBorderColor(
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

  Container tagBar(ID001MainPageViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: model.tagChips,
      ),
    );
  }

  Container youtubeBar(ID001MainPageViewModel model, BuildContext context) {
    return Container(
        height: 122,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: model.currentYoutubeImage != null
                  ? Container(
                      height: 90.00,
                      width: 124.00,
                      child: FlatButton(
                          onPressed: () {
                            model.goYoutubeIntent(
                                model.issueBallDescriptionDto.youtubeVideoId);
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
                            image: NetworkImage(model.currentYoutubeImage),
                          ),
                          borderRadius: BorderRadius.circular(12.00)))
                  : Container(
                      height: 90.00, width: 124.00, child: Text("로딩중"))),
          Positioned(
              top: 0,
              left: 139,
              child: Container(
                  width: MediaQuery.of(context).size.width - 165,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        model.currentYoutubeTitle != null
                            ? Container(
                                child: Text(model.currentYoutubeTitle,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Color(0xff454f63),
                                    )),
                                margin: EdgeInsets.only(bottom: 10),
                              )
                            : Container(),
                        model.currentYoutubeAuthor != null
                            ? Container(
                                child: Text(model.currentYoutubeAuthor,
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 8,
                                      color: Color(0xff78849e),
                                    )),
                              )
                            : Container(),
                        model.currentYoutubeView != null
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "조회수${model.currentYoutubeView}회•"
                                    "${DateFormat("yyyy.MM.dd").format(model.currentYoutubeUploadDate.toLocal())}",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 8,
                                      color: Color(0xff78849e),
                                    )),
                              )
                            : Container()
                      ])))
        ]));
  }

  Container issueTextContentBar(ID001MainPageViewModel model) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 23, 16, 24),
        child: Text(model.issueBallDescriptionDto.text,
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontSize: 14,
              color: Color(0xff454f63),
            )));
  }

  Container makerProfileBar(ID001MainPageViewModel model) {
    return Container(
        height: 62,
        width: 360,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 32.00,
                width: 32.00,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: model.getMakerUserImage(),
                    ),
                    shape: BoxShape.circle),
              )),
          Positioned(
              top: 0,
              left: 44,
              child: Container(
                child: Text(model.getMakerUserNickName(),
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff454f63),
                    )),
              )),
          Positioned(
            top: 16,
            left: 44,
            child: Container(
                child: model.makerUserInfo != null
                    ? Text(
                        "유저영향력 ${model.makerUserInfo.cumulativeInfluence}BP • "
                        "팔로워 ${model.makerUserInfo.followCount}명",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 10,
                          color: Color(0xff78849e),
                        ))
                    : Container()),
          )
        ]));
  }

  Container didver() {
    return Container(
      height: 2.00,
      width: 360.00,
      decoration: BoxDecoration(
        color: Color(0xfff4f4f6),
        borderRadius: BorderRadius.circular(1.00),
      ),
    );
  }

  Container issueBallNameBar() {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        margin: EdgeInsets.only(bottom: 8, top: 16),
        child: Text("이슈볼",
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontSize: 12,
              color: Color(0xffff4f9a),
            )));
  }

  Container conditionStatueBar(ID001MainPageViewModel model) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 16, bottom: 31),
        child: Row(children: <Widget>[
          Container(
            width: 11,
            height: 11,
            child: Icon(
              ForutonaIcon.like,
              color: Color(0xff78849e),
              size: 11,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text("${model.fBallResDto.ballLikes}회",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xff78849e),
                  ))),
          Container(
              width: 11,
              height: 11,
              margin: EdgeInsets.only(left: 8),
              child: Icon(
                ForutonaIcon.dislike,
                color: Color(0xff78849e),
                size: 11,
              )),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text("${model.fBallResDto.ballDisLikes}회",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xff78849e),
                  ))),
          Container(
              width: 11,
              height: 11,
              margin: EdgeInsets.only(left: 8),
              child: Icon(
                ForutonaIcon.visibility,
                color: Color(0xff78849e),
                size: 11,
              )),
          Container(
              margin: EdgeInsets.only(left: 4),
              child: Text("${model.fBallResDto.ballHits}회",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xff78849e),
                  )))
        ]));
  }

  Container issueBallTitleBar(ID001MainPageViewModel model) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(left: 16, right: 48),
          child: Text(model.fBallResDto.ballName,
              overflow: TextOverflow.ellipsis,
              maxLines: model.showMoreDetailFlag ? 3 : 2,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xff000000),
              ))),
      Positioned(
          top: 0,
          right: 18,
          child: Container(
              width: 20,
              height: 20,
              child: FlatButton(
                  onPressed: model.showMoreDetailToggle,
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    model.showMoreDetailFlag
                        ? ForutonaIcon.up_arrow
                        : ForutonaIcon.down_arrow,
                    color: Color(0xff454F63),
                  ))))
    ]));
  }

  Container contributorBar(ID001MainPageViewModel model) {
    return Container(
        height: 60,
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
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
                top: 21,
                left: 44,
                child: Container(
                  width: 251,
                  child: Text('${model.fBallResDto.contributor}명이 반응 하였습니다.',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 11,
                        color: Color(0xff78849e),
                      )),
                ))
          ],
        ));
  }

  Container activeTimeBar(ID001MainPageViewModel model) {
    return Container(
        height: 60,
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
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
              top: 21,
              left: 44,
              child: Container(
                width: 251,
                child: Text(
                    TimeDisplayUtil.getRemainingToStrFromNow(
                        model.fBallResDto.activationTime),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 11,
                      color: Color(0xff78849e),
                    )),
              ))
        ]));
  }

  Container placeAddressBar(ID001MainPageViewModel model) {
    return Container(
        height: 60,
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
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
              top: 21,
              left: 44,
              child: Container(
                width: 251,
                child: Text(model.fBallResDto.placeAddress,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 11,
                      color: Color(0xff78849e),
                    )),
              ))
        ]));
  }

  Container googleMapBar(ID001MainPageViewModel model, BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
          GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            initialCameraPosition: model.initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: model.markers,
            circles: model.circles,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 323,
              child: FlatButton(
                onPressed: () {},
              ))
        ]),
        height: 323);
  }

  Container topHeaderBar(ID001MainPageViewModel model, BuildContext context) {
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
              onPressed: model.onBackBtn,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 18,
              )),
          alignment: Alignment.center,
        ),
        Spacer(),
        Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.only(left: 8),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                ForutonaIcon.share,
                color: Colors.black,
                size: 18,
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
              onPressed: model.showBallSetting,
              child: Icon(
                ForutonaIcon.setting,
                color: Colors.black,
                size: 18,
              )),
          alignment: Alignment.center,
        )
      ]),
      decoration: BoxDecoration(color: Color(0xffffffff).withOpacity(0.6)),
    );
  }
}
