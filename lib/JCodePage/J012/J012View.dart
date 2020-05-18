import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/JCodePage/J012/J012ViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class J012View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J012ViewModel(context),
        child: Consumer<J012ViewModel>(builder: (_, model, child) {
          return Stack(
            children: <Widget>[
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
                                children: <Widget>[
                                  cautionBar(context),
                                  idTextInputBar(model),
                                  emailErrorDisplayBar(model)
                                ],
                              ),
                            )
                          ]),
                          joinProgressBar(context)
                        ],
                      ))),
              model.getIsLoading() ? CommonLoadingComponent() : Container()
            ],
          );
        }));
  }
  Container emailErrorDisplayBar(J012ViewModel model) {
    return model.hasEmailError()
        ? Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 22),
      height: 27,
      child: Text(model.emailErrorText(),
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: Color(0xffff4f9a),
          )),
    )
        : Container(
      height: 27,
    );
  }

  Container idTextInputBar(J012ViewModel model) {
    return Container(
      height: 49,
      margin: EdgeInsets.fromLTRB(16, 0, 24, 0),
      child: Stack(
        children: <Widget>[
          TextField(
            controller: model.idEditingController,
            onChanged: model.onIdEditChangeText,
            onEditingComplete: model.onIdEditComplete,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 16, 44, 16),
                hintText: "아이디(이메일 주소)",
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

  Container cautionBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
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
                  ))),
          Positioned(
              top: 47,
              left: 16,
              child: Text("현재 사용중이신 계정 이메일 주소를 입력해주세요.",
                  style: GoogleFonts.notoSans(
                    fontSize: 11,
                    color: Color(0xff454f63),
                  )))
        ],
      ),
      height: 83.00,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xfff5f5f5),
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


  Positioned joinProgressBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      height: 10,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 10,
        child: LinearProgressIndicator(
          value:0.5,
          backgroundColor: Color(0xffCCCCCC),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3497FD)),
        ),
      ),
    );
  }

  Container topBar(J012ViewModel model) {
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
            child: Text("이메일주소 인증하기",
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
