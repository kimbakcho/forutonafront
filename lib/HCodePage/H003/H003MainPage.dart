import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/HCodePage/H003/H003MainPageModel.dart';
import 'package:forutonafront/HCodePage/H003/H003PageState.dart';
import 'package:forutonafront/HCodePage/H003/H003_01/H00301Page.dart';
import 'package:provider/provider.dart';

import 'H003_01/H00301PageViewModel.dart';
import 'H003_02/H00302Page.dart';
import 'H003_02/H00302PageViewModel.dart';

class H003MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<H003MainPageModel>(create: (_)=> H003MainPageModel()),
          ChangeNotifierProvider<H00301PageViewModel>(create: (_)=> H00301PageViewModel(context)),
          ChangeNotifierProvider<H00302PageViewModel>(create: (_)=> H00302PageViewModel(context)),
        ],
        child: Consumer<H003MainPageModel>(builder: (_, model, child) {
          return Scaffold(
              body: Stack(children: <Widget>[
            Column(children: <Widget>[
              headerBar(model),
              Expanded(
                child: PageView(
                  controller: model.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    H00301Page(),
                    H00302Page()
                  ],
                ),
              )
            ])
          ]));
        }));
  }

  Container headerBar(H003MainPageModel model) {
    return Container(
              height: 82.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  playButton(model.currentState == H003PageState.H003_01Page,model),
                  SizedBox(
                    width: 17.w,
                  ),
                  makeButton(model.currentState == H003PageState.H003_02Page,model)
                ],
              ),
              decoration: BoxDecoration(color: Colors.white),
            );
  }

  Container playButton(bool selected,H003MainPageModel model) {
    return Container(
        child: selected
            ? FlatButton(
                onPressed: () {},
                child: Text("PLAY",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Color(0xff454f63),
                    )),
                padding: EdgeInsets.all(0),
              )
            : FlatButton(
                onPressed: () {
                  model.changePage(H003PageState.H003_01Page);
                },
                child: Text("PLAY",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Color(0xffcccccc),
                    )),
                padding: EdgeInsets.all(0),
              ),
        height: 36.00.h,
        width: 84.00.w,
        decoration: selected
            ? BoxDecoration(
                color: Color(0xfff9f9f9),
                border: Border.all(
                  width: 2.00.w,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(20.00.w),
              )
            : BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(20.00.w),
              ));
  }

  Container makeButton(bool selected,H003MainPageModel model) {
    return Container(
        child: selected
            ? FlatButton(
                onPressed: () {},
                child: Text("MAKE",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Color(0xff454f63),
                    )),
                padding: EdgeInsets.all(0),
              )
            : FlatButton(
                onPressed: () {
                  model.changePage(H003PageState.H003_02Page);
                },
                child: Text("MAKE",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Color(0xffcccccc),
                    )),
                padding: EdgeInsets.all(0)),
        height: 36.00.h,
        width: 84.00.w,
        decoration: selected
            ? BoxDecoration(
                color: Color(0xfff9f9f9),
                border: Border.all(
                  width: 2.00.w,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(20.00.w),
              )
            : BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(20.00.w),
              ));
  }
}