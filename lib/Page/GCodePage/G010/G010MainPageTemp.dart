import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/NickNameValidImpl.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/GCodePage/G010/G010MainPageViewModelTemp.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class G010MainTempPage extends StatelessWidget {
  TextEditingController nickNameController = new TextEditingController();
  TextEditingController userIntroduceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G010MainPageViewModelTemp(
          context: context,
          updateAccountUserInfoUseCaseInputPort: sl(),
          userIntroduceController: userIntroduceController,
          nickNameController: nickNameController,
          userProfileImageUploadUseCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl(),
          nickNameValid: NickNameValidImpl(fUserRepository: sl()),
        ),
        child: Consumer<G010MainPageViewModelTemp>(builder: (_, model, child) {
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
                              padding: EdgeInsets.all(0),
                              children: <Widget>[
                            userProfileImageBar(model),
                            userCountrySelectRowBar(model),
                            nickNameEditor(model, context),
                            userIntroduceEditor(model, context)
                          ]))
                    ]))),
            model.getIsLoading() ? CommonLoadingComponent(isTouch: false) : Container()
          ]);
        }));
  }

  Container userIntroduceEditor(
      G010MainPageViewModelTemp model, BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 398,
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: <Widget>[
                Text("자기소개",
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Color(0xff454f63),
                    )),
                Spacer(),
                Container(
                  child: Text("(${model.userIntroduceInputTextLength}/100)",
                      style: GoogleFonts.notoSans(
                        fontSize: 10,
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
                  maxLength: 100,
                  controller: model.userIntroduceController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      hintText: "자기소개를 입력해주세요.",
                      hintStyle: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
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

  Container nickNameEditor(G010MainPageViewModelTemp model, BuildContext context) {
    return Container(
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: <Widget>[
          Positioned(
              top: 17,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    children: <Widget>[
                      Text("닉네임",
                          style: GoogleFonts.notoSans(
                            fontSize: 12,
                            color: Color(0xff454f63),
                          )),
                      Spacer(),
                      Text("(${model.nickNameInputTextLength}/20)",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 10,
                            color: Color(0xffd4d4d4),
                          ))
                    ],
                  ))),
          Positioned(
              top: 46,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  height: 24,
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                      onEditingComplete: model.onEditCompleteNickName,
                      controller: model.nickNameController,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xff454f63),
                      ),
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: "닉네임을 입력해주세요",
                        hintStyle: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
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
              top: 60,
              left: 16,
              child: model.hasNickNameError()
                  ? Container(
                  child: Text(model.nickNameErrorText(),
                      style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 12,
                          color: Color(0xffff4f9a))))
                  : Container())
        ]),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xffE4E7E8), width: 1))));
  }

  Container userProfileImageBar(G010MainPageViewModelTemp model) {
    return Container(
      height: 145,
      child: Center(
          child : Stack(alignment: Alignment.bottomRight, children: <Widget>[
            Container(
                height: 69.00,
                width: 69.00,
                child: FlatButton(
                  child: Container(),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(0),
                  onPressed: model.onChangeProfileImageTab,
                ),
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
                    shape: BoxShape.circle)),
            Positioned(
                child: Container(
                    height: 21.00,
                    width: 21.00,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: model.onChangeProfileImageTab,
                      child: Icon(
                        ForutonaIcon.pencil,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffb1b1b1),
                      border: Border.all(
                        width: 1.00,
                        color: Color(0xfff2f0f1),
                      ),
                      shape: BoxShape.circle,
                    )))
          ]
          )),
    );
  }

  Container userCountrySelectRowBar(G010MainPageViewModelTemp model) {
    return Container(
      height: 85,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: model.jumpCountrySelect,
          child: Stack(children: <Widget>[
            Positioned(
                top: 20,
                left: 16,
                child: Container(
                  height: 30,
                  child: Text("국가",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 12,
                        color: Color(0xff454f63),
                      )),
                )),
            Positioned(
                top: 41,
                left: 16,
                child: Container(
                    child: Text(model.getUserCountry(),
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        ))))
          ])),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffE4E7E8), width: 1))),
    );
  }



  Container topBar(G010MainPageViewModelTemp model) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackBtnTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text("계정",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        model.isValidComplete()
            ? Container(
                margin: EdgeInsets.only(right: 16),
                height: 32.00,
                width: 75.00,
                child: FlatButton(
                  onPressed: model.onCompleteTap,
                  child: Text("완료",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
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
                margin: EdgeInsets.only(right: 16),
                height: 32.00,
                width: 75.00,
                child: FlatButton(
                  onPressed: null,
                  child: Text("완료",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
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
