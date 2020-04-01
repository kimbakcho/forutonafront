import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallSupport/BallImageViwer.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

import 'IssueBallWidgetSyle1ViewModel.dart';

class IssueBallWidgetStyle1 extends StatefulWidget {
  FBallResDto ballResDto;

  IssueBallWidgetStyle1(this.ballResDto);

  @override
  _IssueBallWidgetStyle1State createState() {
    return _IssueBallWidgetStyle1State(this.ballResDto);
  }
}

class _IssueBallWidgetStyle1State extends State<IssueBallWidgetStyle1> {
  FBallResDto ballResDto;

  _IssueBallWidgetStyle1State(this.ballResDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallWidgetSyle1ViewModel(this.ballResDto),
        child:
            Consumer<IssueBallWidgetSyle1ViewModel>(builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
              child: Column(children: <Widget>[
                ballHeader(model),
                ballMainPickture(model),
                ballProfileBar(model),
                ballTextBar(model),
                divider(),
                Container(
                  height: 48.00.h,
                  width: 328.00.w,
                  padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(model.ballResDto.ballLikes.toString(),
                          style: TextStyle(
                            fontFamily: "Gibson",
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Color(0xff78849e),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 0, 0, 7.h),
                          child: Icon(ForutonaIcon.thumbsup,
                              color: Color(0xff78849E), size: 17.sp)),
                      SizedBox(width: 19.w),
                      Text(model.ballResDto.ballDisLikes.toString(),
                          style: TextStyle(
                            fontFamily: "Gibson",
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Color(0xff78849e),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 0, 0, 3.h),
                          child: Icon(ForutonaIcon.thumbsdown,
                              color: Color(0xff78849E), size: 17.sp)),
                      SizedBox(width: 19.w),
                      Text(model.ballResDto.commentCount.toString(),
                          style: TextStyle(
                            fontFamily: "Gibson",
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Color(0xff78849e),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 0, 0, 3.h),
                          child: Icon(ForutonaIcon.comment,
                              color: Color(0xff78849E), size: 17.sp)),
                      SizedBox(width: 19.w),
                      Text(
                          TimeDisplayUtil.getRemainingToStrFromNow(
                              model.ballResDto.activationTime),
                          style: TextStyle(
                            fontFamily: "Gibson",
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Color(0xff78849e),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 0, 0, 3.h),
                          child: Icon(ForutonaIcon.accesstime,
                              color: Color(0xff78849E), size: 17.sp)),
                    ],
                  ),
                )
              ]),
              width: 328.00.w,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 4.00.w),
                    color: Color(0xff455b63).withOpacity(0.08),
                    blurRadius: 16.w,
                  ),
                ],
                borderRadius: BorderRadius.circular(12.00.w),
              ));
        }));
  }

  Container divider() {
    return Container(
      height: 1.00.h,
      width: 284.00.w,
      decoration: BoxDecoration(
        color: Color(0xfff4f4f6),
        borderRadius: BorderRadius.circular(1.00),
      ),
    );
  }

  Container ballTextBar(IssueBallWidgetSyle1ViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 23.h),
      child: Text(model.fBallDescirptionBasic.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontSize: 14.sp,
            color: Color(0xff78849e),
          )),
    );
  }

  Container ballProfileBar(IssueBallWidgetSyle1ViewModel model) {
    return Container(
      height: 55.h,
      width: 328.w,
      padding: EdgeInsets.fromLTRB(14.w, 15.h, 14.w, 15.h),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 25.00.h,
              width: 25.00.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.ballResDto.profilePicktureUrl)),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.00.w, color: Color(0xffdc3e57))),
            ),
          ),
          Positioned(
            left: 34.w,
            top: 0,
            child: Text(model.ballResDto.nickName,
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
            left: 34.w,
            top: 16.h,
            child: Text(
                TimeDisplayUtil.getRemainingToStrFromNow(
                    model.ballResDto.activationTime),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontSize: 8,
                  color: Color(0xff454f63).withOpacity(0.56),
                )),
          )
        ],
      ),
    );
  }

  Widget ballMainPickture(IssueBallWidgetSyle1ViewModel model) {
    return model.isMainPicture()
        ? Stack(children: <Widget>[
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BallImageViewer(
                        model.fBallDescirptionBasic.desimages,
                        model.ballResDto.ballUuid + "picturefromBigpicture");
                  }));
                },
                child: Hero(
                    tag: model.ballResDto.ballUuid + "picturefromBigpicture",
                    child: Container(
                        height: 172.00.h,
                        width: 328.00.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(model.mainPictureSrc()),
                        ))))),
            model.getPicktureCount() > 1
                ? Positioned(
                    bottom: 10.h,
                    right: 10.w,
                    child: Hero(
                      tag: model.ballResDto.ballUuid + "picturefrombutton",
                      child: Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return BallImageViewer(
                                    model.fBallDescirptionBasic.desimages,
                                    model.ballResDto.ballUuid +
                                        "picturefrombutton");
                              }));
                            },
                            padding: EdgeInsets.all(0),
                            child: Text("+${model.getPicktureCount() - 1}",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Color(0xffffffff),
                                )),
                          ),
                          height: 26.00.h,
                          width: 31.00.w,
                          decoration: BoxDecoration(
                            color: Color(0xff454f63).withOpacity(0.60),
                            border: Border.all(
                              width: 1.00.w,
                              color: Color(0xff454f63).withOpacity(0.60),
                            ),
                            borderRadius: BorderRadius.circular(12.00.w),
                          )),
                    ))
                : Container(
                    height: 0,
                  )
          ])
        : Container();
  }

  Container ballHeader(IssueBallWidgetSyle1ViewModel model) {
    return Container(
      height: 65.h,
      width: 328.w,
      child: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
              padding: EdgeInsets.only(left: 1.sp, bottom: 1.sp),
              child: Icon(ForutonaIcon.issue, size: 17.sp, color: Colors.white),
              height: 30.00.h,
              width: 30.00.w,
              decoration: BoxDecoration(
                color: Color(0xffdc3e57),
                shape: BoxShape.circle,
              )),
        ),
        Positioned(
            top: 0,
            left: 48.w,
            width: 256.w,
            child: Container(
                width: 256.w,
                child: Text(model.ballResDto.ballName,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Color(0xff454f63),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))),
        Positioned(
          top: 19.h,
          left: 48.w,
          width: 200.w,
          child: Container(
            width: 200.w,
            child: Text(model.ballResDto.placeAddress,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 12.sp,
                  color: Color(0xff454f63).withOpacity(0.56),
                )),
          ),
        ),
        Positioned(
          top: 19.h,
          right: 0.w,
          height: 19.h,
          width: 68.w,
          child: Container(
            width: 68.w,
            alignment: Alignment.centerRight,
            child: Text(model.ballResDto.distanceDisplayText,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 10.sp,
                  color: Color(0xffff4f9a).withOpacity(0.56),
                )),
          ),
        )
      ]),
      padding: EdgeInsets.fromLTRB(13.w, 16.h, 12.w, 14.h),
    );
  }
}
