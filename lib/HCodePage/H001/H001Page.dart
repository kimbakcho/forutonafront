import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Widget/IssueBall/Style1/IssueBallWidgetStyle1.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:provider/provider.dart';

class H001Page extends StatefulWidget {
  H001Page({Key key}) : super(key: key);

  @override
  _H001PageState createState() => _H001PageState();
}

class _H001PageState extends State<H001Page> {
  @override
  Widget build(BuildContext context) {
    var h001ViewModel = Provider.of<H001ViewModel>(context);
    return ChangeNotifierProvider.value(
        value: h001ViewModel,
        child: Stack(children: <Widget>[
          Scaffold(
              body: Container(
                  color: Color(0xfff2f0f1),
                  child: Consumer<H001ViewModel>(builder: (_, model, child) {
                    return Stack(children: <Widget>[
                      model.hasBall
                          ? Column(children: <Widget>[
                              addressDisplay(model),
                              Expanded(
                                  child: Stack(children: <Widget>[
                                buildListUpPanel(model),
                              ]))
                            ])
                          : ballEmptyPanel(),
                      makeButton(model),
                    ]);
                  })))
        ]));
  }

  Container ballEmptyPanel() {
    return Container(
        child: Center(
            child: Text("아쉽지만\n검색하신 지역에 컨텐츠가 없습니다.",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 14.sp,
                  color: Color(0xffb1b1b1),
                ),
                textAlign: TextAlign.center)));
  }

  ListView buildListUpPanel(H001ViewModel model) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 65.h),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.fBallListUpWrapDto.balls.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return model.inlineRanking
              ? inlineRanking(model)
              : unInlineRaking(model);
        }
        return selectBallWidget(model.fBallListUpWrapDto.balls[index - 1]);
      },
      controller: model.h001CenterListViewController,
      separatorBuilder: (context, index) {
        return SizedBox(height: 16.h);
      },
    );
  }

  Widget makeButton(H001ViewModel model) {
    return model.inlineRanking
        ? Positioned(
            child: Hero(
              tag: "H001MakeButton",
              child: Container(
                child: AnimatedContainer(
                  child: FlatButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: RouteSettings(name: "/H002"),
                              builder: (context) {
                                return H002Page(
                                  heroTag: "H001MakeButton",
                                );
                              }));
                    },
                  ),
                  height: 46.00.h,
                  width: 47.00.w,
                  decoration: BoxDecoration(
                      color: Color(0xff3497fd),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                        ),
                      ],
                      shape: BoxShape.circle),
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.only(
                      top: model.makeButtonDisplayShowFlag ? 0 : 120.h),
                ),
                height: 120.h,
                alignment: Alignment.topCenter,
              ),
            ),
            bottom: 0.h,
            right: 16.w,
          )
        : Container();
  }

  Widget selectBallWidget(FBallResDto resDto) {
    if (resDto.ballType == FBallType.IssueBall) {
      return IssueBallWidgetStyle1(resDto);
    } else if (resDto.ballType == FBallType.QuestBall) {
      return Container(child: Text("QuestBallType"));
    } else {
      return Container();
    }
  }

  Column unInlineRaking(H001ViewModel model) {
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: model.rankingWrapDto.contents.length,
              itemBuilder: (builder, index) {
                return Container(
                    height: 40.h,
                    width: 320.w,
                    padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFF38CAF5))),
                    ),
                    child: Row(children: <Widget>[
                      Text("${model.rankingWrapDto.contents[index].ranking}."),
                      SizedBox(width: 12.w),
                      Text("#${model.rankingWrapDto.contents[index].tagName}"),
                      Spacer(),
                      Text(
                          "${(model.rankingWrapDto.contents[index].tagPower).toStringAsFixed(1)}k"),
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
              }),
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
              )))
    ]);
  }

  Container bottomNavigation(CodeMainViewModel model) {
    return Container(
        color: Colors.white,
        height: 52.h,
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.HCDOE);
                  },
                  child: Icon(
                    ForutonaIcon.list,
                    color: model.currentState == HCodeState.HCDOE
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.ICODE);
                  },
                  child: Icon(
                    ForutonaIcon.map,
                    color: model.currentState == HCodeState.ICODE
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.JCODE);
                  },
                  child: Icon(
                    ForutonaIcon.officialchannel,
                    color: model.currentState == HCodeState.JCODE
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.KCODE);
                  },
                  child: Icon(
                    ForutonaIcon.social,
                    color: model.currentState == HCodeState.KCODE
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.LCODE);
                  },
                  child: Icon(
                    ForutonaIcon.user,
                    color: model.currentState == HCodeState.LCODE
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
        ]));
  }

  Container inlineRanking(H001ViewModel model) {
    return Container(
        child: Swiper(
          itemCount: model.rankingWrapDto.contents.length,
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
                  Text("${model.rankingWrapDto.contents[index].ranking}."),
                  SizedBox(width: 12.w),
                  Text("#${model.rankingWrapDto.contents[index].tagName}"),
                  Spacer(),
                  Text(
                      "${(model.rankingWrapDto.contents[index].tagPower).toStringAsFixed(1)}k"),
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
        height: model.rankingWrapDto.contents.length == 0 ? 0 : 40.h,
        width: 328.00.w,
        decoration: BoxDecoration(
            color: Color(0xffe9faff),
            border: Border.all(width: 1.00.w, color: Color(0xff38caf5)),
            borderRadius: BorderRadius.circular(10.00.w)));
  }

  AnimatedContainer addressDisplay(H001ViewModel model) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: Colors.white,
        height: model.addressDisplayShowFlag ? 73.h : 0.h,
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
                    )))));
  }
}
