import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwCheckValidImpl.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwValidImpl.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/JCodePage/J011/J011ViewModel.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class J011View extends StatelessWidget {
  final TextEditingController pwEditingController = TextEditingController();
  final TextEditingController pwCheckEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      SignValid pwValid = PwValidImpl();
      return J011ViewModel(
          context: context,
          pwFindPhoneUseCaseInputPort: sl(),
          pwValid: pwValid,
          pwCheckValid: PwCheckValidImpl(pwValid),
          pwCheckEditingController: pwCheckEditingController,
          pwEditingController: pwEditingController);
    }, child: Consumer<J011ViewModel>(builder: (_, model, child) {
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
                            cautionBar(context),
                            pwTextInputBar(model),
                            pwTextErrorDisplayBar(model),
                            pwCheckInputBar(model),
                            pwCheckErrorDisplayBar(model)
                          ]))
                    ]),
                    joinProgressBar(context)
                  ],
                ))),
        model.getIsLoading() ? CommonLoadingComponent() : Container()
      ]);
    }));
  }

  Container pwCheckErrorDisplayBar(J011ViewModel model) {
    return model.hasPwCheckError()
        ? Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 22),
            height: 27,
            child: Text(model.pwCheckErrorText(),
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Color(0xffff4f9a),
                )),
          )
        : Container(
            height: 27,
          );
  }

  Container pwCheckInputBar(J011ViewModel model) {
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
                hintText: "새로운 패스워드 확인",
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

  Container pwTextErrorDisplayBar(J011ViewModel model) {
    return model.hasPwError()
        ? Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 22),
            height: 27,
            child: Text(model.pwErrorText(),
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Color(0xffff4f9a),
                )),
          )
        : Container(
            height: 27,
          );
  }

  Container pwTextInputBar(J011ViewModel model) {
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
                hintText: "새로운 패스워드 입력",
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

  Container cautionBar(BuildContext context) {
    return Container(
      height: 99.00,
      child: Stack(children: <Widget>[
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
            child: Text("새로운 패스워드를 생성합니다.\n패스워드는 8자리 이상을 사용해주세요.",
                style: GoogleFonts.notoSans(
                  fontSize: 11,
                  color: Color(0xff454f63),
                ))),
      ]),
      margin: EdgeInsets.all(16),
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
          value: 1,
          backgroundColor: Color(0xffCCCCCC),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3497FD)),
        ),
      ),
    );
  }

  Container topBar(J011ViewModel model) {
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
            child: Text("신규 패스워드 만들기",
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
            onPressed:
                model.isValidComplete() ? model.onCompleteBtnClick : null,
            child: Text("완료",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: model.isValidComplete()
                      ? Colors.black
                      : Color(0xffb1b1b1),
                )),
          ),
          decoration: BoxDecoration(
            color: model.isValidComplete() ? Colors.white : Color(0xffd4d4d4),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 12.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              ),
            ],
            border: model.isValidComplete()
                ? Border.all(color: Colors.black, width: 1)
                : null,
            borderRadius: BorderRadius.circular(5.00),
          ),
        )
      ]),
    );
  }
}
