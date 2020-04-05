import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/FBall/Dto/UserBallResDto.dart';
import 'package:forutonafront/FBall/Widget/IssueBall/Style2/IssueBallWidgetStyle2ViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class IssueBallWidgetStyle2 extends StatelessWidget {
  UserBallResDto resDto;

  IssueBallWidgetStyle2(this.resDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallWidgetStyle2ViewModel(this.resDto),
        child: Consumer<IssueBallWidgetStyle2ViewModel>(
            builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
              height: 133.h,
              width: 328.w,
              child: Stack(
                children: <Widget>[
                  FlatButton(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                      onPressed: () {},
                      child: Stack(children: <Widget>[
                        Positioned(
                          top: 0.h,
                          left: 0.h,
                          child: ballIcon(),
                        ),
                        Positioned(
                            top: 0, left: 46.w, child: titleAndAddress(model)),
                        Positioned(
                          bottom: 31.h,
                          child: divider(),
                        ),
                        Positioned(
                            right: 0, bottom: 0, child: valueBottomBar(model)),
                        Positioned(
                          bottom: 47.h,
                          right: 0,
                          child: Container(
                            child: Text(model.resDto.distanceDisplayText,
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 10,
                                  color: Color(0xffff4f9a).withOpacity(0.56),
                                )),
                          ),
                        ),
                      ])),
                  Positioned(right: 4.w, top: 10.h, child: pointDashButton())
                ],
              ),
              decoration: BoxDecoration(
                  color: model.isAlive ? Color(0xffffffff) :  Color(0xffF6F6F6),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00.w),
                      color:  Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6.w,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.00)));
        }));
  }

  Container pointDashButton() {
    return Container(
        height: 30.h,
        width: 30.w,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          shape: CircleBorder(),
          child: Icon(
            ForutonaIcon.pointdash,
            size: 16.sp,
          ),
        ));
  }

  Container valueBottomBar(IssueBallWidgetStyle2ViewModel model) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Text(
                NomalValueDisplay.changeIntDisplaystr(model.resDto.ballLikes),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6.w),
          ),
          Container(
            child: Icon(
              ForutonaIcon.thumbsup,
              size: 15.sp,
              color: Color(0xff78849e),
            ),
            margin: EdgeInsets.only(right: 19.w),
          ),
          Container(
            child: Text(
                NomalValueDisplay.changeIntDisplaystr(
                    model.resDto.ballDisLikes),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6.w),
          ),
          Container(
            child: Icon(
              ForutonaIcon.thumbsdown,
              size: 15.sp,
              color: Color(0xff78849e),
            ),
            margin: EdgeInsets.only(right: 19.w),
          ),
          Container(
            child: Text(
                NomalValueDisplay.changeIntDisplaystr(
                    model.resDto.commentCount),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6.w),
          ),
          Container(
            child: Icon(
              ForutonaIcon.comment,
              size: 15.sp,
              color: Color(0xff78849e),
            ),
            margin: EdgeInsets.only(right: 19.w),
          ),
          Container(
            child: Text(
                TimeDisplayUtil.getRemainingToStrFromNow(
                    model.resDto.activationTime),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6.w),
          ),
          Container(
            child: Icon(
              ForutonaIcon.accesstime,
              size: 15.sp,
              color: Color(0xff78849e),
            ),
          )
        ],
      ),
    );
  }

  Container divider() {
    return Container(
      height: 0.50.h,
      width: 294.00.w,
      color: Color(0xffe4e7e8),
    );
  }

  Container ballIcon() {
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: Color(0xffDC3E57),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.only(left: 1.w, bottom: 1.h),
      child: Icon(ForutonaIcon.issue, color: Colors.white, size: 17.sp),
    );
  }

  Container titleAndAddress(IssueBallWidgetStyle2ViewModel model) {
    return Container(
        width: 210.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.resDto.ballName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 13.sp,
                  color: model.isAlive ? Color(0xff454f63):Color(0xff454F63).withOpacity(0.7),
                )),
            Text(model.resDto.ballPlaceAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 11,
                  color: Color(0xff454f63).withOpacity(0.56),
                ))
          ],
        ));
  }
}
