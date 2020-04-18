import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Common/YoutubeWidget2.dart';
import 'package:provider/provider.dart';

import 'G023MainPageViewModel.dart';

class G023MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G023MainPageViewModel(context),
        child: Consumer<G023MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Positioned(top: 0, left: 0, child: topBar(model)),
                        Positioned(
                            top: 63,
                            left: 0,
                            child: new Container(
                              height: 326.00.h,
                              width: 360.00.w,
                              child: YoutubeWidget2(id: "dlQK5CglG0E"),
                              color: Color(0xff454f63).withOpacity(0.30),
                            )),
                        Positioned(
                            top: 390.h,
                            left: 0,
                            child: companyIntroduceBar(),
                        ),
                      ],
                    )))
          ]);
        }));
  }

  Container companyIntroduceBar() {
    return Container(
                            height: 200.00.h,
                            width: 360.00.w,
                            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text("상호:",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color:Color(0xff7a7a7a),
                                    )),
                                    Spacer(),
                                    Text("(주)FORUTONA",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color:Color(0xff454f63),
                                    ))
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: <Widget>[
                                    Text("대표:",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color:Color(0xff7a7a7a),
                                    )),
                                    Spacer(),
                                    Text("유호영",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color:Color(0xff454f63),
                                    ))
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: <Widget>[
                                    Text("주소:",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color:Color(0xff7a7a7a),
                                    )),
                                    Spacer(),
                                    Text("경기도 시흥시 신천천동로 7, 403호",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color:Color(0xff454f63),
                                    ))
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: <Widget>[
                                    Text("사업자등록 번호:",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color:Color(0xff7a7a7a),
                                    )),
                                    Spacer(),
                                    Text("",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color:Color(0xff454f63),
                                    ))
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: <Widget>[
                                    Text("통신판매업신고번호:",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color:Color(0xff7a7a7a),
                                    )),
                                    Spacer(),
                                    Text("7470400107",style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color:Color(0xff454f63),
                                    ))
                                  ],
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                          );
  }

  topBar(G023MainPageViewModel model) {
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
            child: Text("회사 소개",
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
