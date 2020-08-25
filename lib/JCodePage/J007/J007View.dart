import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/NickNameValidImpl.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/JCodePage/J007/J007ViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class J007View extends StatelessWidget {
  final TextEditingController nickNameController = new TextEditingController();
  final TextEditingController userIntroduceController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J007ViewModel(
            context: context,
            singUpUseCaseInputPort: sl(),
            nickNameValid: NickNameValidImpl(fUserRepository: sl()),
            userProfileImageUploadUseCaseInputPort: sl(),
            nickNameController: nickNameController,
            userIntroduceController: userIntroduceController),

        child: Consumer<J007ViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Column(children: <Widget>[
                          topBar(model),
                          Expanded(
                              child: ListView(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                userProfileImageBar(model),
                                countrySelectBar(context, model),
                                didver(context),
                                nickNameEditor(model, context),
                                userIntroduceEditor(model, context)
                              ]))
                        ]),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            height: 9,
                            width: MediaQuery.of(context).size.width,
                            child: LinearProgressIndicator(
                                value: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff3497FD),
                                ),
                                backgroundColor: Color(0xffCCCCCC)))
                      ],
                    ))),
            model.getIsLoading()
                ? CommonLoadingComponent(isTouch: false)
                : Container()
          ]);
        }));
  }

  Container userIntroduceEditor(J007ViewModel model, BuildContext context) {
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
                      letterSpacing: 4,
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
                  controller: userIntroduceController,
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      hintText: "자기소개를 입력해주세요.",
                      hintStyle: GoogleFonts.notoSans(
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

  Container nickNameEditor(J007ViewModel model, BuildContext context) {
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
                            letterSpacing: 4,
                            fontSize: 12,
                            color: model.hasNickNameError()
                                ? Color(0xffff4f9a)
                                : Color(0xff454f63),
                          )),
                      Spacer(),
                      Text("(${model.nickNameInputTextLength}/20)",
                          style: GoogleFonts.notoSans(
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
                      onChanged: model.onChangeNickName,
                      controller: nickNameController,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold, fontSize: 14),
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
                          style: GoogleFonts.notoSans(
                              fontSize: 12, color: Color(0xffff4f9a))))
                  : Container())
        ]),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xffE4E7E8), width: 1))));
  }

  Container countrySelectBar(BuildContext context, J007ViewModel model) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            width: MediaQuery.of(context).size.width,
            child: Text("국가",
                style: GoogleFonts.notoSans(
                  letterSpacing: 4,
                  fontSize: 12,
                  color: Color(0xff454f63),
                ))),
        Container(
            child: FlatButton(
          padding: EdgeInsets.only(left: 16),
          onPressed: model.onCountryChange,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              model.getCountryName(model.currentCountryCode),
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ))
      ]),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container didver(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }

  Container userProfileImageBar(J007ViewModel model) {
    return Container(
      height: 145,
      color: Color(0xffF2F0F1),
      child: Center(
          child: Stack(alignment: Alignment.bottomRight, children: <Widget>[
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
      ])),
    );
  }

  Container topBar(J007ViewModel model) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text("프로필 입력",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        Container(
          height: 32.00,
          width: 75.00,
          margin: EdgeInsets.only(right: 16),
          child: FlatButton(
            onPressed: model.isCanComplete() ? model.onCompeleteBtnClick : null,
            child: Text("완료",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color:
                      model.isCanComplete() ? Colors.black : Color(0xffb1b1b1),
                )),
          ),
          decoration: BoxDecoration(
            color: model.isCanComplete() ? Colors.white : Color(0xffd4d4d4),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 12.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              ),
            ],
            border: model.isCanComplete()
                ? Border.all(color: Colors.black, width: 1)
                : null,
            borderRadius: BorderRadius.circular(5.00),
          ),
        )
      ]),
    );
  }
}
