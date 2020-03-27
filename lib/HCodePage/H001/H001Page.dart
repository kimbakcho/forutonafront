import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/MainPage/HCodeMainViewModel.dart';
import 'package:provider/provider.dart';

class H001Page extends StatefulWidget {
  H001Page({Key key}) : super(key: key);

  @override
  _H001PageState createState() => _H001PageState();
}

class _H001PageState extends State<H001Page> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H001ViewModel(),
        child: Stack(children: <Widget>[
          Scaffold(
              body: Container(
                  color: Color(0xfff2f0f1),
                  padding: EdgeInsets.fromLTRB(0, 22.h, 0, 0),
                  child: Consumer<H001ViewModel>(builder: (_, model, child) {
                    return Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topNavibar(model),
                        addressDisplay(model),
                        Expanded(
                            child: Stack(children: <Widget>[
                          !model.inlineRanking
                              ? Positioned(
                                  height: 52.h,
                                  width: 360.w,
                                  bottom: 0,
                                  child: bottomNavigation(Provider.of(context)))
                              : Container(),
                          Positioned(
                              top: 0.h,
                              child: model.inlineRanking
                                  ? inlineRanking(model)
                                  : unInlineRaking(model)),
                          model.inlineRanking
                              ? Positioned(
                                  height: 52.h,
                                  width: 360.w,
                                  bottom: 0,
                                  child: bottomNavigation(Provider.of(context)))
                              : Container()
                        ]))
                      ])
                    ]);
                  })))
        ]));
  }

  Column unInlineRaking(H001ViewModel model) {
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: model.tagRankings.length,
              itemBuilder: (builder, index) {
                return Container(
                    height: 40.h,
                    width: 320.w,
                    padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
                    child: Row(children: <Widget>[
                      Text("${model.tagRankings[index].ranking}."),
                      SizedBox(width: 12.w),
                      Text("#${model.tagRankings[index].tagName}"),
                      Spacer(),
                      Text(
                          "${(model.tagRankings[index].tagPower / 1000).toStringAsFixed(1)}k"),
                      SizedBox(width: 12.w),
                      Container(
                        width: 12.w,
                        child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              model.inlineRanking = false;
                            },
                            child: Icon(ForutonaIcon.down_arrow, size: 10.sp)),
                      )
                    ]));
              }),
          height: 406.00.h,
          width: 328.00.w,
          decoration: BoxDecoration(
              color: Color(0xffe9faff),
              border: Border.all(
                width: 1.00.w,
                color: Color(0xff38caf5),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.00.w),
                topRight: Radius.circular(10.00.w),
              ))),
      Container(
        child: FlatButton(
          child: Text("접기",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: Color(0xffffffff),
              )),
          onPressed: () {
            model.inlineRanking = true;
          },
        ),
        height: 54.00.h,
        width: 328.00.w,
        decoration: BoxDecoration(
          color: Color(0xff454f63),
          border: Border.all(
            width: 1.00.w,
            color: Color(0xff454f63),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.00.w),
            bottomRight: Radius.circular(12.00.w),
          ),
        ),
      )
    ]);
  }

  Container bottomNavigation(HCodeMainViewModel model) {
    return Container(
        color: Colors.white,
        height: 52.h,
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.H001);
                  },
                  child: Icon(
                    ForutonaIcon.list,
                    color: model.currentState == HCodeState.H001
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T004);
                  },
                  child: Icon(
                    ForutonaIcon.map,
                    color: model.currentState == HCodeState.T004
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T007);
                  },
                  child: Icon(
                    ForutonaIcon.officialchannel,
                    color: model.currentState == HCodeState.T007
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T009);
                  },
                  child: Icon(
                    ForutonaIcon.social,
                    color: model.currentState == HCodeState.T009
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T011);
                  },
                  child: Icon(
                    ForutonaIcon.user,
                    color: model.currentState == HCodeState.T011
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
        ]));
  }

  Container inlineRanking(H001ViewModel model) {
    return Container(
        child: Swiper(
          itemCount: model.tagRankings.length,
          autoplay: model.rankingAutoPlay,
          scrollDirection: Axis.vertical,
          autoplayDelay: 2000,
          controller: model.rankingSwiperController,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 40.h,
                width: 320.w,
                padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
                child: Row(children: <Widget>[
                  Text("${model.tagRankings[index].ranking}."),
                  SizedBox(width: 12.w),
                  Text("#${model.tagRankings[index].tagName}"),
                  Spacer(),
                  Text(
                      "${(model.tagRankings[index].tagPower / 1000).toStringAsFixed(1)}k"),
                  SizedBox(width: 12.w),
                  Container(
                    width: 12.w,
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          model.inlineRanking = false;
                        },
                        child: Icon(ForutonaIcon.down_arrow, size: 10.sp)),
                  )
                ]));
          },
        ),
        margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        height: 40.h,
        width: 328.00.w,
        decoration: BoxDecoration(
            color: Color(0xffe9faff),
            border: Border.all(width: 1.00.w, color: Color(0xff38caf5)),
            borderRadius: BorderRadius.circular(10.00.w)));
  }

  Container addressDisplay(H001ViewModel model) {
    return Container(
        color: Colors.white,
        height: 73.h,
        padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 16.h),
        child: Container(
          height: 46.00.h,
          width: 328.00.w,
          decoration: BoxDecoration(
            color: Color(0xfff6f6f6),
            borderRadius: BorderRadius.circular(12.00.w),
          ),
          child: FlatButton(
            onPressed: () {},
            child: Text(model.selectPosition,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Color(0xff454f63),
                )),
          ),
        ));
  }

  Container topNavibar(H001ViewModel model) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16.w, 7.h, 16.w, 0.h),
        height: 56.h,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              H001_01Button(model),
              SizedBox(
                width: 16.w,
              ),
              H003_01Button(model),
              Spacer(),
              searchButton()
            ]));
  }

  Container searchButton() {
    return Container(
      alignment: Alignment.topCenter,
      height: 36.h,
      width: 36.w,
      decoration: BoxDecoration(
        color: Color(0xfff6f6f6),
        borderRadius: BorderRadius.circular(8.00),
      ),
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Icon(ForutonaIcon.search)),
    );
  }

  Column H003_01Button(H001ViewModel model) {
    return Column(children: <Widget>[
      model.currentState == H001PageState.H003_01
          ? Container(
              height: 36.h,
              width: 36.w,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    model.currentState = H001PageState.H003_01;
                  });
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.h003top,
                  color: Color(0xff454F63),
                  size: 17.sp,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xffff9edb),
                border: Border.all(
                  width: 2.00.w,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(8.00.w),
              ))
          : Container(
              height: 36.00,
              width: 36.00,
              decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(8.00.w),
              ),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    model.currentState = H001PageState.H003_01;
                  });
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.h003top,
                  color: Color(0xffB1B1B1),
                  size: 17.sp,
                ),
              ),
            ),
      model.currentState == H001PageState.H003_01
          ? Container(
              margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
              height: 4.00.h,
              width: 4.00.w,
              decoration: BoxDecoration(
                color: Color(0xff454f63),
                border: Border.all(
                  width: 1.00.w,
                  color: Color(0xff454f63),
                ),
                shape: BoxShape.circle,
              ))
          : Container()
    ]);
  }

  Column H001_01Button(H001ViewModel model) {
    return Column(children: <Widget>[
      model.currentState == H001PageState.H001_01
          ? Container(
              height: 36.00.h,
              width: 36.00.w,
              child: FlatButton(
                onPressed: () {
                  model.currentState = H001PageState.H001_01;
                },
                padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                child: Icon(
                  ForutonaIcon.joystick,
                  color: Color(0xff454F63),
                  size: 17.sp,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff88d4f1),
                border: Border.all(
                  width: 2.00.w,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(8.00.w),
              ))
          : Container(
              height: 36.00.h,
              width: 36.00.w,
              decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(8.00.w),
              ),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    model.currentState = H001PageState.H001_01;
                  });
                },
                padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                child: Icon(
                  ForutonaIcon.joystick,
                  color: Color(0xffB1B1B1),
                  size: 17.sp,
                ),
              ),
            ),
      model.currentState == H001PageState.H001_01
          ? Container(
              margin: EdgeInsets.fromLTRB(0, 6.sp, 0, 0),
              height: 4.00.h,
              width: 4.00.w,
              decoration: BoxDecoration(
                color: Color(0xff454f63),
                border: Border.all(
                  width: 1.00.w,
                  color: Color(0xff454f63),
                ),
                shape: BoxShape.circle,
              ))
          : Container()
    ]);
  }
}
