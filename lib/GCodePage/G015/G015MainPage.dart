import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Common/SwitchWidget/SwitchStyle1.dart';
import 'package:forutonafront/GCodePage/G015/G015MainPageViewModel.dart';
import 'package:provider/provider.dart';

class G015MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G015MainPageViewModel(context),
        child: Consumer<G015MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(children: <Widget>[
                      topBar(model),
                      SizedBox(
                        height: 8.h,
                      ),
                      chatAlarmSettingBar(model),
                      myContentReplyAlarmSettingBar(model),
                      myReplyReplyAlarmSettingBar(model),
                      followNewContentSettingBar(model),
                      sponsorNewContentSettingBar(model)
                    ])))
          ]);
        }));
  }
  Container sponsorNewContentSettingBar(G015MainPageViewModel model) {
    return Container(
        height: 65.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 16.h, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("스폰대상의 신규 컨텐츠",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 14.sp,
                        color: Color(0xff454f63),
                      )),
                  Text("  내 스폰대상이 신규 컨텐츠를 제작하면 이를 알립니다.",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w300,
                        fontSize: 10.sp,
                        color:Color(0xff454f63),
                      )),
                ],
              ),
            ),
            Spacer(),
            SwitchStyle1(
              switchStyle1Controller: model.sponsorNewContentSwitchController,
              value: model.isSponsorNewContent,
              onChanged: model.onSponsorNewContentChange,
              activeColor: Color(0xff2AACA7),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }
  Container followNewContentSettingBar(G015MainPageViewModel model) {
    return Container(
        height: 64.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 16.h, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("팔로워의 신규 컨텐츠",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 14.sp,
                        color: Color(0xff454f63),
                      )),
                  Text("  팔로워가 신규 컨텐츠를 제작하면 이를 알립니다.",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w300,
                        fontSize: 10.sp,
                        color:Color(0xff454f63),
                      )),
                ],
              ),
            )
            
            ,
            Spacer(),
            SwitchStyle1(
              switchStyle1Controller: model.followNewContentSwitchController,
              value: model.isFollowNewContent,
              onChanged: model.onFollowNewContentChange,
              activeColor: Color(0xff2AACA7),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container myReplyReplyAlarmSettingBar(G015MainPageViewModel model) {
    return Container(
        height: 48.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
        child: Row(
          children: <Widget>[
            Text("내 댓글에 대댓글",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 14.sp,
                  color: Color(0xff454f63),
                )),
            Spacer(),
            SwitchStyle1(
              switchStyle1Controller: model.myReplyReplyAlarmSwitchController,
              value: model.isMyReplyReplyAlarm,
              onChanged: model.onMyReplyReplyAlarmChange,
              activeColor: Color(0xff2AACA7),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container myContentReplyAlarmSettingBar(G015MainPageViewModel model) {
    return Container(
        height: 48.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
        child: Row(
          children: <Widget>[
            Text("내 컨텐츠에 댓글",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 14.sp,
                  color: Color(0xff454f63),
                )),
            Spacer(),
            SwitchStyle1(
              switchStyle1Controller: model.myContentReplyAlarmSwitchController,
              value: model.isMyContentReplyAlarm,
              onChanged: model.onMyContentReplyAlarmChange,
              activeColor: Color(0xff2AACA7),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }
  Container chatAlarmSettingBar(G015MainPageViewModel model) {
    return Container(
        height: 48.h,
        width: 360.w,
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
        child: Row(
          children: <Widget>[
            Text("채팅메시지",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 14.sp,
                  color: Color(0xff454f63),
                )),
            Spacer(),
            SwitchStyle1(
              switchStyle1Controller: model.chatAlarmSwitchController,
              value: model.isChatMessageAlarm,
              onChanged: model.onChatAlarmChange,
              activeColor: Color(0xff2AACA7),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container topBar(G015MainPageViewModel model) {
    return Container(
      width: 360.w,
      height: 56.h,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48.w),
        Container(
            child: Text("설정",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
