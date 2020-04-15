import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/GCodePage/G009/G009MainPageViewModel.dart';
import 'package:provider/provider.dart';

class G009MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G009MainPageViewModel(context),
        child: Consumer<G009MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(top: 0, child: topBar(model)),
                      Positioned(
                        top: 64.h,
                        child: accountColumn(model),
                      ),
                      Positioned(
                          top: 265.h,
                          child: Column(
                            children: <Widget>[
                              noticeRowBtn(),
                              versionInfoRowBtn(),
                              customerCenterRowBtn()
                            ],
                          ))
                    ])))
          ]);
        }));
  }

  Container customerCenterRowBtn() {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("고객센터",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Container versionInfoRowBtn() {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("버전정보",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Container noticeRowBtn() {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("공지사항",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Column accountColumn(G009MainPageViewModel model) {
    return Column(
      children: <Widget>[
        accountRowBtn(model),
        securityRowBtn(),
        openScopeRowBtn(),
        alarmRowbtn()
      ],
    );
  }

  Container alarmRowbtn() {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("알림",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Container openScopeRowBtn() {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("공개 범위",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Container securityRowBtn() {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("보안",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Container accountRowBtn(G009MainPageViewModel model ) {
    return Container(
      width: 360.w,
      height: 48.h,
      child: FlatButton(
          onPressed: model.goAccountSettingPage,
          padding: EdgeInsets.all(0),
          child: Container(
              width: 360.w,
              height: 48.h,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text("계정",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1.h))),
    );
  }

  Container topBar(G009MainPageViewModel model) {
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
