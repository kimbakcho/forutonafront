import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/GCodePage/G010/G010MainPageViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class G010MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G010MainPageViewModel(context),
        child: Consumer<G010MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(children: <Widget>[
                      topBar(model),
                      Expanded(
                          child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              children: <Widget>[
                            userProfileImageBar(model),
                            userCountrySelectRowBar(model),
                            nickNameEditor(model),
                            userIntroduceEditor(model)
                          ]))
                    ])))
          ]);
        }));
  }

  Container userIntroduceEditor(G010MainPageViewModel model) {
    return Container(
        height: 415.h,
        width: 360.w,
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Row(
              children: <Widget>[
                Text("자기소개",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 12.sp,
                      color: Color(0xff454f63),
                    )),
                Spacer(),
                Container(
                  child: Text("(${model.userIntroduceInputTextLength}/80)",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 10.sp,
                        color: Color(0xffd4d4d4),
                      )),
                )
              ],
            ),
          ),
          Container(
              child: TextField(
                  minLines: 1,
                  maxLines: null,
                  maxLength: 80,
                  controller: model.userIntroduceController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                      hintText: "자기소개를 입력해주세요.",
                      hintStyle: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Color(0xffd4d4d4),
                      ),
                      counter: Container(width: 0, height: 0),
                      enabledBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)))))
        ]));
  }

  Container nickNameEditor(G010MainPageViewModel model) {
    return Container(
        height: 85.h,
        width: 360.w,
        child: Stack(children: <Widget>[
          Positioned(
              top: 17.h,
              left: 0.w,
              child: Container(
                  width: 360.w,
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                  child: Row(
                    children: <Widget>[
                      Text("닉네임",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 12.sp,
                            color: Color(0xff454f63),
                          )),
                      Spacer(),
                      Text("(${model.nickNameInputTextLength}/80)",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 10.sp,
                            color: Color(0xffd4d4d4),
                          ))
                    ],
                  ))),
          Positioned(
              top: 46.h,
              left: 0.w,
              child: Container(
                  width: 360.w,
                  height: 24.h,
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                  child: TextField(
                      onEditingComplete: model.onEditCompleteNickName,
                      controller: model.nickNameController,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Color(0xff454f63),
                      ),
                      maxLength: 80,
                      decoration: InputDecoration(
                        hintText: "닉네임을 입력해주세요",
                        hintStyle: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Color(0xffd4d4d4),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        counter: Container(
                          width: 0,
                          height: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide:
                                BorderSide(color: Colors.white, width: 0)),
                        focusedBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide:
                                BorderSide(color: Colors.white, width: 0)),
                      )))),
          Positioned(
              top: 60.h,
              left: 16.w,
              child: model.isCanNotUseNickNameDisPlay ? Container(
                  child: Text("*사용하실 수 없는 닉네임입니다.",
                      style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 12.sp,
                          color: Color(0xffff4f9a)))):Container() )
        ]),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xffE4E7E8), width: 1.h))));
  }

  Container userProfileImageBar(G010MainPageViewModel model) {
    return Container(
        height: 145.h,
        width: 360.w,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 36.h,
              left: 146.w,
              child: userProfileImage(model),
            ),
            Positioned(top: 86.h, left: 195.w, child: userProfileImageEditBtn(model))
          ],
        ));
  }

  Container userCountrySelectRowBar(G010MainPageViewModel model) {
    return Container(
      width: 360.w,
      height: 85.h,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: model.jumpCountrySelect,
          child: Stack(children: <Widget>[
            Positioned(
                top: 20.h,
                left: 16.w,
                child: Container(
                  width: 360.w,
                  height: 30.h,
                  child: Text("국가",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 12.sp,
                        color: Color(0xff454f63),
                      )),
                )),
            Positioned(
                top: 41.h,
                left: 16.w,
                child: Container(
                    width: 360.w,
                    child: Text(model.getUserCountry(),
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        ))))
          ])),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffE4E7E8), width: 1.h))),
    );
  }

  Container userProfileImageEditBtn(G010MainPageViewModel model) {
    return Container(
      height: 21.00.h,
      width: 21.00.w,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: model.onChangeProfileImageTab,
        child: Icon(
          ForutonaIcon.pencil,
          color: Colors.white,
          size: 10.sp,
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xffb1b1b1),
        border: Border.all(
          width: 1.00.w,
          color: Color(0xfff2f0f1),
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Container userProfileImage(G010MainPageViewModel model) {
    return Container(
        height: 69.00.h,
        width: 69.00.w,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: model.currentProfileImage,
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            shape: BoxShape.circle));
  }

  Container topBar(G010MainPageViewModel model) {
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
            child: Text("계정",
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