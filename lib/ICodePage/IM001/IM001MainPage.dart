import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageViewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'BallImageItemDto.dart';

class IM001MainPage extends StatelessWidget {
  final LatLng setUpPosition;
  final String address;

  const IM001MainPage(this.setUpPosition, this.address);

  @override
  Widget build(BuildContext context) {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(1),
        statusBarIconBrightness: Brightness.dark);

    return ChangeNotifierProvider(
        create: (_) => IM001MainPageViewModel(context, setUpPosition, address),
        child: Consumer<IM001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topBar(model),
                        Expanded(
                            child: ListView(
                                controller: model.mainScrollController,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 60.h),
                                children: <Widget>[
                              googleMapBar(model),
                              titleLabelBar(model),
                              titleEditBar(model),
                              contentDivder(),
                              textContentLabel(model),
                              textContentEditBar(model),
                              contentDivder(),
                              imageListBar(model),
                              youtubeBar(model),
                              tagBar(model)
                            ]))
                      ]),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: bottomBar(model),
                      )
                    ])))
          ]);
        }));
  }

  Container tagBar(IM001MainPageViewModel model) {
    return model.tagBarVisibility ? Container(
        child: Column(children: <Widget>[
      tagTopLabelBar(model),
      tagEditTextBar(model),
      Container(
          width: 360.w,
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 10.w,
            children: model.tagChips,
          ))
    ])):Container();
  }

  Container tagEditTextBar(IM001MainPageViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
          focusNode: model.tagEditFocusNode,
          controller: model.tagEditController,
          onChanged: model.onTagTextChanged,
          onFieldSubmitted: model.onTagFieldSubmitted,
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: Color(0xff3497fd),
              ),
              hintText: "태그를 입력해 주세요(000, 로 구분합니다.)",
              hintStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Color(0xffe4e7e8),
              ),
              contentPadding: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE4E7E8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE4E7E8)),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE4E7E8))))),
    );
  }

  Container tagTopLabelBar(IM001MainPageViewModel model) {
    return Container(
      child: Row(children: <Widget>[
        Container(
            child: Text("#태그",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: model.tagEditFocusNode.hasFocus
                      ? Color(0xff3497FD)
                      : Color(0xff454f63),
                ))),
        Spacer(),
        Container(
            child: model.tagEditFocusNode.hasFocus
                ? Text("${model.tagChips.length}/10",
                    style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: Color(0xffb1b1b1)))
                : Container())
      ]),
      padding: EdgeInsets.fromLTRB(16.w, 31.h, 16.w, 10.h),
    );
  }

  Container youtubeBar(IM001MainPageViewModel model) {
    return model.youtubeAttachVisibility
        ? Container(
            height: 99.h,
            width: 360.w,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 17.h,
                    left: 16.w,
                    child: Text("YOUTUBE 동영상 첨부",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Color(0xff454f63),
                        ))),
                Positioned(
                    top: 45.h,
                    left: 16.w,
                    child: Container(
                        width: 290.w,
                        child: model.validYoutubeLink == null
                            ? Text("동영상 링크를 복사해서 붙어넣기 하세요.",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 13.sp,
                                  color: Color(0xff78849e),
                                ))
                            : Text(model.validYoutubeLink,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 14,
                                  color: Color(0xff78849e),
                                )))),
                Positioned(
                    top: 37.h, right: 16.w, child: youtubeActionBtn(model))
              ],
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffE4E7E8), width: 1.h))),
          )
        : Container();
  }

  Container youtubeActionBtn(IM001MainPageViewModel model) {
    if (model.currentClipBoardData == null) {
      //비활성화 상태
      return Container(
          height: 27.00.h,
          width: 73.00.w,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("붙혀넣기",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                    color: Color(0xffcccccc),
                  )),
              onPressed: () {}),
          decoration: BoxDecoration(
            color: Color(0xffe4e7e8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            borderRadius: BorderRadius.circular(13.00),
          ));
    } else if (model.currentClipBoardData != null &&
        model.validYoutubeLink == null) {
      //붙혀 넣기 가능한 상태
      return Container(
          height: 27.00.h,
          width: 73.00.w,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("붙혀넣기",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                    color: Color(0xffffffff),
                  )),
              onPressed: () {
                model.validYoutubeLinkCheck(model.currentClipBoardData);
              }),
          decoration: BoxDecoration(
              color: Color(0xff8382F2),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(13.00)));
    } else if (model.validYoutubeLink != null) {
      //youtube Link 까지 입력된 상태
      return Container(
          height: 27.00.h,
          width: 73.00.w,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("삭제",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                    color: Color(0xffffffff),
                  )),
              onPressed: () {
                model.deleteYoutubeLink();
              }),
          decoration: BoxDecoration(
              color: Color(0xffFF4F9A),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(13.00)));
    } else {
      return Container();
    }
  }

  Container imageListBar(IM001MainPageViewModel model) {
    return model.ballImageList.length != 0
        ? Container(
            width: 360.w,
            height: 124.h,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 16.h,
                  left: 16.h,
                  child: Text("이미지",
                      style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Color(0xff454f63)))),
              Positioned(
                  top: 16.h,
                  right: 16.h,
                  child: Text("${model.ballImageList.length}/20",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: Color(0xffb1b1b1),
                      ))),
              Positioned(
                  top: 40.h,
                  left: 0.w,
                  child: Container(
                      height: 68.h, width: 360.w, child: imageListView(model)))
            ]),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.h, color: Color(0xffE4E7E8)))),
          )
        : Container();
  }

  ListView imageListView(IM001MainPageViewModel model) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: model.ballImageList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
              width: 77.w,
              height: 68.h,
              margin: EdgeInsets.only(left: 16.w),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: ballImageFromDto(model.ballImageList[index])),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 14.00.h,
                      width: 14.00.w,
                      child: FlatButton(
                        onPressed: () {
                          model.deleteBallImage(index);
                        },
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.clear,
                          color: Color(0xffFF4F9A),
                          size: 10.sp,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1.00,
                          color: Color(0xffff4f9a),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ))
              ]));
        });
  }

  Container ballImageFromDto(BallImageItemDto reqDto) {
    if (reqDto.imageUrl != null) {
      return Container(
        height: 62.h,
        width: 75.w,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(reqDto.imageUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.00.w),
        ),
      );
    } else {
      return Container(
        height: 62.h,
        width: 75.w,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: MemoryImage(
                reqDto.imageByte,
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.00.w),
        ),
      );
    }
  }

  Container bottomBar(IM001MainPageViewModel model) {
    return !model.keyboardVisibility
        ? Container(
            height: 60.00.h,
            width: 371.00.w,
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 42.00.h,
                  width: 42.00.w,
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 4.h),
                    shape: CircleBorder(),
                    onPressed: model.onShowSelectPictureDialog,
                    child: Icon(ForutonaIcon.camera, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffee9acf),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  height: 42.00.h,
                  width: 42.00.w,
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 4.h),
                    shape: CircleBorder(),
                    onPressed: model.youtubeAttachVisibilityToggle,
                    child: Icon(ForutonaIcon.videoattach, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff8382F2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  height: 42.00.h,
                  width: 42.00.w,
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 4.h),
                    shape: CircleBorder(),
                    onPressed: model.tagBarToggle,
                    child: Icon(ForutonaIcon.tagadd, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff88D4F1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffffffff).withOpacity(0.90),
              border: Border.all(
                width: 0.50,
                color: Color(0xffe4e7e8).withOpacity(0.90),
              ),
            ),
          )
        : Container();
  }

  TextField textContentEditBar(IM001MainPageViewModel model) {
    return TextField(
      controller: model.textContentEditController,
      focusNode: model.textContentFocusNode,
      maxLength: 2000,
      maxLines: null,
      minLines: 1,
      decoration: InputDecoration(
          counter: Container(),
          hintText: "어떤 이슈인가요?",
          hintStyle: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Color(0xffe4e7e8),
          ),
          contentPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Container textContentLabel(IM001MainPageViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Text("내용",
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: model.textContentFocusNode.hasFocus
                ? Color(0xff3497FD)
                : Color(0xff454f63),
          )),
    );
  }

  Container contentDivder() {
    return Container(
      height: 1.h,
      width: 360.w,
      color: Color(0xffE4E7E8),
    );
  }

  TextField titleEditBar(IM001MainPageViewModel model) {
    return TextField(
      controller: model.titleEditController,
      focusNode: model.titleFocusNode,
      maxLength: 50,
      maxLines: 2,
      minLines: 2,
      decoration: InputDecoration(
          counter: Container(),
          hintText: "제목을 지어주세요!",
          hintStyle: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Color(0xffe4e7e8),
          ),
          contentPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Container titleLabelBar(IM001MainPageViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 0, 8.h),
      child: Text("제목",
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: model.titleFocusNode.hasFocus
                ? Color(0xff3497FD)
                : Color(0xff454f63),
          )),
    );
  }

  Container googleMapBar(IM001MainPageViewModel model) {
    return Container(
        height: 233.h,
        width: 360.w,
        child: Stack(children: <Widget>[
          //Ball 레이더 애니메이션 뒤로 숨김
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
            mapType: MapType.normal,
            initialCameraPosition: model.initCameraPosition,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            markers: model.markers,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 46.00.h,
                width: 360.00.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on,
                        color: Color(0xff78849E), size: 15.sp),
                    Text(model.address,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 14.sp,
                          color: Color(0xff454f63),
                        ))
                  ],
                ),
                color: Color(0xffffffff).withOpacity(0.70),
              )),
        ]));
  }

  Container topBar(IM001MainPageViewModel model) {
    return Container(
      width: 360.w,
      height: 56.h,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackBtnTap,
                child: Icon(Icons.arrow_back)),
            width: 48.w),
        Container(
            child: Text("이슈볼 만들기",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        model.isValidComplete()
            ? Container(
                margin: EdgeInsets.only(right: 16.w),
                height: 32.00.h,
                width: 75.00.w,
                child: FlatButton(
                  onPressed: model.onCompleteTap,
                  child: Text("완료",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: Color(0xff454f63),
                      )),
                ),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border.all(
                      width: 1.00,
                      color: Color(0xff454f63),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 12.00),
                        color: Color(0xff455b63).withOpacity(0.08),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.00)))
            : Container(
                margin: EdgeInsets.only(right: 16.w),
                height: 32.00.h,
                width: 75.00.w,
                child: FlatButton(
                  child: Text("완료",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: Color(0xffb1b1b1),
                      )),
                ),
                decoration: BoxDecoration(
                    color: Color(0xffd4d4d4),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.00, 12.00),
                          color: Color(0xff455b63).withOpacity(0.08),
                          blurRadius: 16)
                    ],
                    borderRadius: BorderRadius.circular(5.00)))
      ]),
    );
  }
}
