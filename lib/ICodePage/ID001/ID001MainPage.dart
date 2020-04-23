import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPageViewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ID001MainPage extends StatelessWidget {
  final FBallResDto _fBallResDto;

  ID001MainPage(this._fBallResDto);

  @override
  Widget build(BuildContext context) {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(statueBar);
    return ChangeNotifierProvider(
        create: (_) => ID001MainPageViewModel(context, _fBallResDto),
        child: Consumer<ID001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 360.w,
                                height: 640.h,
                                child: ListView(
                                    controller: model.mainScrollController,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),
                                    children: <Widget>[
                                      googleMapBar(model),
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
                                      model.getImageContentBar()
                                    ]))),
                        Positioned(
                            top: MediaQuery.of(context).padding.top,
                            left: 0,
                            child: topHeaderBar(model))
                      ],
                    )))
          ]);
        }));
  }

  Container issueTextContentBar(ID001MainPageViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 23.h, 16.w, 24.h),
      child: Text(model.issueBallDescriptionDto.text,
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontSize: 14.sp,
            color: Color(0xff454f63),
          )),
    );
  }

  Container makerProfileBar(ID001MainPageViewModel model) {
    return Container(
        height: 62.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 32.00.h,
                  width: 32.00.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: model.getMakerUserImage(),
                      ),
                      shape: BoxShape.circle),
                )),
            Positioned(
              top: 0,
              left: 44.w,
              child: Container(
                child: Text(model.getMakerUserNickName(),
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Color(0xff454f63),
                    )),
              ),
            ),
            Positioned(
              top: 16.h,
              left: 44.w,
              child: Container(
                  child: model.makerUserInfo != null
                      ? Text(
                          "유저영향력 ${model.makerUserInfo.cumulativeInfluence}BP • "
                          "팔로워 ${model.makerUserInfo.followCount}명",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 10.sp,
                            color: Color(0xff78849e),
                          ))
                      : Container()),
            )
          ],
        ));
  }

  Container didver() {
    return Container(
      height: 2.00.h,
      width: 360.00.w,
      decoration: BoxDecoration(
        color: Color(0xfff4f4f6),
        borderRadius: BorderRadius.circular(1.00),
      ),
    );
  }

  Container issueBallNameBar() {
    return Container(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        margin: EdgeInsets.only(bottom: 8.h, top: 16.h),
        child: Text("이슈볼",
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontSize: 12.sp,
              color: Color(0xffff4f9a),
            )));
  }

  Container conditionStatueBar(ID001MainPageViewModel model) {
    return Container(
        margin: EdgeInsets.only(top: 8.h, left: 16.w, bottom: 31.h),
        child: Row(children: <Widget>[
          Container(
            width: 11.w,
            height: 11.h,
            child: Icon(
              ForutonaIcon.thumbsup,
              color: Color(0xff78849e),
              size: 11.sp,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 4.w),
              child: Text("${model.fBallResDto.ballLikes}회",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: Color(0xff78849e),
                  ))),
          Container(
            width: 11.w,
            height: 11.h,
            margin: EdgeInsets.only(left: 8.w),
            child: Icon(
              ForutonaIcon.thumbsdown,
              color: Color(0xff78849e),
              size: 11.sp,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 4.w),
              child: Text("${model.fBallResDto.ballDisLikes}회",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: Color(0xff78849e),
                  ))),
          Container(
            width: 11.w,
            height: 11.h,
            margin: EdgeInsets.only(left: 8.w),
            child: Icon(
              ForutonaIcon.visibility,
              color: Color(0xff78849e),
              size: 11.sp,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 4.w),
              child: Text("${model.fBallResDto.ballHits}회",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: Color(0xff78849e),
                  )))
        ]));
  }

  Container issueBallTitleBar(ID001MainPageViewModel model) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 16.w, right: 48.w),
              child: Text(model.fBallResDto.ballName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: model.showMoreDetailFlag ? 3 : 2,
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Color(0xff000000),
                  ))),
          Positioned(
              top: 0.h,
              right: 18.w,
              child: Container(
                  width: 20.w,
                  height: 20.h,
                  child: FlatButton(
                      onPressed: model.showMoreDetailToggle,
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        model.showMoreDetailFlag
                            ? ForutonaIcon.up_arrow
                            : ForutonaIcon.down_arrow,
                        color: Color(0xff454F63),
                      ))))
        ],
      ),
    );
  }

  Container contributorBar(ID001MainPageViewModel model) {
    return Container(
        height: 60.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 9.h),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 32.00.h,
                  width: 32.00.w,
                  child: Icon(
                    ForutonaIcon.contributor,
                    color: Color(0xff707070),
                    size: 15.sp,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe4e7e8),
                  ),
                )),
            Positioned(
              top: 0,
              left: 44.w,
              child: Text("기여자",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
              top: 21,
              left: 44.w,
              child: Container(
                width: 251.w,
                child: Text('${model.fBallResDto.contributor}명이 반응 하였습니다.',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 11.sp,
                      color: Color(0xff78849e),
                    )),
              ),
            )
          ],
        ));
  }

  Container activeTimeBar(ID001MainPageViewModel model) {
    return Container(
        height: 60.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 9.h),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 32.00.h,
                  width: 32.00.w,
                  child: Icon(
                    ForutonaIcon.whatshot,
                    color: Color(0xff707070),
                    size: 15.sp,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe4e7e8),
                  ),
                )),
            Positioned(
              top: 0,
              left: 44.w,
              child: Text("남은 시간",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
              top: 21,
              left: 44.w,
              child: Container(
                width: 251.w,
                child: Text(
                    TimeDisplayUtil.getRemainingToStrFromNow(
                        model.fBallResDto.activationTime),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 11.sp,
                      color: Color(0xff78849e),
                    )),
              ),
            )
          ],
        ));
  }

  Container placeAddressBar(ID001MainPageViewModel model) {
    return Container(
        height: 60.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 9.h),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 32.00.h,
                  width: 32.00.w,
                  child: Icon(
                    Icons.location_on,
                    color: Color(0xff707070),
                    size: 15.sp,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe4e7e8),
                  ),
                )),
            Positioned(
              top: 0,
              left: 44.w,
              child: Text("설치 장소",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
              top: 21,
              left: 44.w,
              child: Container(
                width: 251.w,
                child: Text(model.fBallResDto.placeAddress,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 11.sp,
                      color: Color(0xff78849e),
                    )),
              ),
            )
          ],
        ));
  }

  Container googleMapBar(ID001MainPageViewModel model) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: RepaintBoundary(
                  key: model.makerAnimationKey,
                  child: Container(
                    width: 240.w,
                    height: 240.h,
                    child: FlareActor(
                      "assets/Rive/radar.flr",
                      alignment: Alignment.center,
                      animation: "animating",
                      fit: BoxFit.contain,
                    ),
                  ))),
          GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            initialCameraPosition: model.initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: model.markers,
          )
        ],
      ),
      width: 360.w,
      height: 323.h,
    );
  }

  Container topHeaderBar(ID001MainPageViewModel model) {
    return Container(
      height: 56.h,
      width: 360.w,
      child: Row(children: <Widget>[
        Container(
          width: 32.w,
          height: 32.h,
          padding: EdgeInsets.only(left: 8.w),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: model.onBackBtn,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 18.sp,
              )),
          alignment: Alignment.center,
        ),
        Spacer(),
        Container(
          width: 32.w,
          height: 32.h,
          padding: EdgeInsets.only(left: 8.w),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                ForutonaIcon.share,
                color: Colors.black,
                size: 18.sp,
              )),
          alignment: Alignment.center,
        ),
        Container(
          width: 32.w,
          height: 32.h,
          margin: EdgeInsets.only(right: 16.w),
          padding: EdgeInsets.only(left: 8.w),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                ForutonaIcon.setting,
                color: Colors.black,
                size: 18.sp,
              )),
          alignment: Alignment.center,
        )
      ]),
      decoration: BoxDecoration(color: Color(0xffffffff).withOpacity(0.6)),
    );
  }
}
