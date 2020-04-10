import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/IssueBallWidgetStyle3ViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuestBallWidgetStyle3 extends StatelessWidget {
  FBallResDto ballResDto;

  QuestBallWidgetStyle3(this.ballResDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallWidgetStyle3ViewModel(ballResDto),
        child: Consumer<IssueBallWidgetStyle3ViewModel>(
            builder: (_, model, child) {
          return Container(
              height: 90.00.h,
              width: 312.00.w,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 11.h,
                      left: 11.h,
                      child: questBallIcon(),
                    ),
                    Positioned(
                        top: 11.h, left: 54.w, child: ballNameText(model)),
                    Positioned(
                        top: 31.h, left: 54.w, child: makerInfoBar(model)),
                    Positioned(
                        right: 0.w, top: 0.h, child: ballMainimageBox(model)),
                    Positioned(top: 54.h, left: 0, child: divider()),
                    Positioned(top: 50.h, right: 0, child: ballBottomBar(model))
                  ],
                ),
                onPressed: () {},
              ),
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00.w),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6.w,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.00.w)));
        }));
  }

  Container makerInfoBar(IssueBallWidgetStyle3ViewModel model) {
    return Container(
      width: model.isMainPicture() ? 178.w : 252.w,
      child: RichText(
        text: TextSpan(
            text: model.ballResDto.nickName,
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
              color: Color(0xff78849e),
            ),
            children: <TextSpan>[
              TextSpan(text: "    "),
              TextSpan(
                  text: "${model.ballResDto.userLevel.toStringAsFixed(0)}  lv",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                    color: Color(0xff454f63).withOpacity(0.56),
                  )),
            ]),
      ),
    );
  }

  Container ballBottomBar(IssueBallWidgetStyle3ViewModel model) {
    return Container(
        height: 48.00.h,
        width: 328.00.w,
        padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(ballResDto.ballLikes.toString(),
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
        ));
  }

  Container divider() {
    return Container(
      height: 0.50.h,
      width: 312.00.w,
      color: Color(0xffe4e4e4),
    );
  }

  Container ballMainimageBox(IssueBallWidgetStyle3ViewModel model) {
    return model.isMainPicture()
        ? Container(
            height: 54.00.h,
            width: 80.00.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      model.fBallDescriptionBasic.desimages[0].src)),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.00),
              ),
            ),
          )
        : Container();
  }

  Container ballNameText(IssueBallWidgetStyle3ViewModel model) {
    return Container(
      width: model.isMainPicture() ? 178.w : 252.w,
      height: 18.h,
      child: Text(model.ballResDto.ballName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w700,
            fontSize: 13.sp,
            color: Color(0xff454f63),
          )),
    );
  }

  Container questBallIcon() {
    return Container(
        padding: EdgeInsets.only(left: 1.sp, bottom: 1.sp),
        child: Icon(ForutonaIcon.quest, size: 13.sp, color: Colors.white),
        height: 30.00.h,
        width: 30.00.w,
        decoration: BoxDecoration(
          color: Color(0xff4F72FF),
          shape: BoxShape.circle,
        ));
  }
}
