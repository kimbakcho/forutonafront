import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/ProgressIndicator/CommonLinearProgressIndicator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'J006ViewModel.dart';

class J006View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J006ViewModel(context),
        child: Consumer<J006ViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                backgroundColor: Color(0xffF2F0F1),
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
                                  children: <Widget>[
                                idDescriptionBar(context),
                                idTextInputBar(model),
                                emailErrorDisplayBar(model),
                                pwTextInputBar(model),
                                pwTextErrorDisplayBar(model),
                                pwCheckInputBar(model),
                                pwCheckErrorDisplayBar(model)
                              ]))
                        ]),
                        joinProgressBar(context),
                        model.getIsLoading() ? CommonLoadingComponent() : Container()
                      ],
                    ))),
          ]);
        }));
  }

  Positioned joinProgressBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      height: 10,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 10,
        child: CommonLinearProgressIndicator(0.75),
      ),
    );
  }

  Container pwCheckErrorDisplayBar(J006ViewModel model) {
    return model.hasPwCheckError()
        ? Container(
            alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 8,bottom: 10),
      height: 38,
      margin: EdgeInsets.only(left: 22),
            child: Text(model.pwCheckErrorText(),
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: Color(0xffff4f9a),
                )),
          )
        : Container(
            height: 27,
          );
  }

  Container pwCheckInputBar(J006ViewModel model) {
    return Container(
        height: 49,
        margin: EdgeInsets.fromLTRB(16, 0, 24, 0),
        child: Stack(children: <Widget>[
          TextField(
            controller: model.pwCheckEditingController,
            onChanged: model.onPwCheckEditChangeText,
            onEditingComplete: model.onPwCheckComplete,
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 16, 44, 16),
                hintText: "패스워드 확인",
                hintStyle: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Color(0xffb1b1b1),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffF2F0F1), width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide:
                        BorderSide(color: Color(0xff3497FD), width: 1))),
          ),
          !model.hasPwCheckError()
              ? Positioned(
                  top: 16,
                  right: 16,
                  width: 20,
                  height: 20,
                  child: Container(
                    height: 20,
                    width: 20,
                    child:
                        Icon(ForutonaIcon.check, color: Colors.white, size: 20),
                    decoration: BoxDecoration(
                        color: Color(0xff3497FD), shape: BoxShape.circle),
                  ))
              : Container()
        ]));
  }

  Container pwTextErrorDisplayBar(J006ViewModel model) {
    return model.hasPwError()
        ? Container(
            alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 8,bottom: 10),
      height: 38,
            margin: EdgeInsets.only(left: 22),
            child: Text(model.pwErrorText(),
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: Color(0xffff4f9a),
                )),
          )
        : Container(
            height: 27,
          );
  }

  Container pwTextInputBar(J006ViewModel model) {
    return Container(
        height: 49,
        margin: EdgeInsets.fromLTRB(16, 0, 24, 0),
        child: Stack(children: <Widget>[
          TextField(
            controller: model.pwEditingController,
            onChanged: model.onPwEditChangeText,
            onEditingComplete: model.onPwEditComplete,
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 16, 44, 16),
                hintText: "패스워드 입력",
                hintStyle: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Color(0xffb1b1b1),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffF2F0F1), width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide:
                        BorderSide(color: Color(0xff3497FD), width: 1))),
          ),
          !model.hasPwError()
              ? Positioned(
                  top: 16,
                  right: 16,
                  width: 20,
                  height: 20,
                  child: Container(
                    height: 20,
                    width: 20,
                    child:
                        Icon(ForutonaIcon.check, color: Colors.white, size: 20),
                    decoration: BoxDecoration(
                        color: Color(0xff3497FD), shape: BoxShape.circle),
                  ))
              : Container()
        ]));
  }

  Container emailErrorDisplayBar(J006ViewModel model) {
    return model.hasEmailError()
        ? Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 22),
            padding: EdgeInsets.only(top: 8,bottom: 10),
            height: 38,
            child: Text(model.emailErrorText(),
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: Color(0xffFF4F9A),
                )),
          )
        : Container(
            height: 27,
          );
  }

  Container idTextInputBar(J006ViewModel model) {
    return Container(
      height: 49,
      margin: EdgeInsets.fromLTRB(16, 0, 24, 0),
      child: Stack(
        children: <Widget>[
          TextField(
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            controller: model.idEditingController,
            onChanged: model.onIdEditChangeText,
            onEditingComplete: model.onIdEditComplete,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 16, 44, 16),
                hintText: "이메일 주소",
                hintStyle: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Color(0xffb1b1b1),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffF2F0F1), width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide:
                        BorderSide(color: Color(0xff3497FD), width: 1))),
          ),
          !model.hasEmailError()
              ? Positioned(
                  top: 16,
                  right: 16,
                  width: 20,
                  height: 20,
                  child: Container(
                    height: 20,
                    width: 20,
                    child:
                        Icon(ForutonaIcon.check, color: Colors.white, size: 20),
                    decoration: BoxDecoration(
                        color: Color(0xff3497FD), shape: BoxShape.circle),
                  ))
              : Container()
        ],
      ),
    );
  }

  Container idDescriptionBar(BuildContext context) {
    return Container(
      height: 101.00,
      margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 16,
            left: 16,
            child: Text("주의사항",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
            top: 50,
            left: 16,
            child: Text("아이디는 실제 사용하시는 이메일로 작성해주세요.\n패스워드 분실시 복구에 사용됩니다.",
                style: GoogleFonts.notoSans(
                  fontSize: 13,
                  color: Color(0xff454f63),
                  fontWeight: FontWeight.normal
                )),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xffF6F6F6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 4.00),
            color: Color(0xff455b63).withOpacity(0.08),
            blurRadius: 16,
          ),
        ],
        borderRadius: BorderRadius.circular(12.00),
      ),
    );
  }

  Container topBar(J006ViewModel model) {
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
            child: Text("아이디 등록",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        Container(
            margin: EdgeInsets.only(right: 16),
            height: 32.00,
            width: 75.00,
            decoration: BoxDecoration(
              color: model.isCanNextBtn() ? Colors.white : Color(0xffd4d4d4),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 12.00),
                  color: Color(0xff455b63).withOpacity(0.08),
                  blurRadius: 16,
                ),
              ],
              border: model.isCanNextBtn()
                  ? Border.all(color: Color(0xff454F63), width: 1)
                  : Border.all(color: Colors.white, width: 0),
              borderRadius: BorderRadius.circular(5.00),
            ),
            child: FlatButton(
                onPressed: model.isCanNextBtn() ? model.onNextComplete : null,
                padding: EdgeInsets.all(0),
                child: Text("다음",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: model.isCanNextBtn()
                          ? Color(0xff454F63)
                          : Color(0xffb1b1b1),
                    ))))
      ]),
    );
  }
}
