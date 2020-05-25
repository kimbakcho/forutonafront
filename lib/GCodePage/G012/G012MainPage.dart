import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:provider/provider.dart';

import 'G012MainPageViewModel.dart';

class G012MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G012MainPageViewModel(context),
        child: Consumer<G012MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(children: <Widget>[
                      topBar(model),
                      Expanded(
                          child: Container(
                              child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(0),
                                  children: <Widget>[
                            discriptionBar(context),
                            currentPwTextField(model),
                            currentPwErrorBar(model),
                            newPwTextField(model),
                            newPwErrorBar(model),
                            checkPwTextField(model),
                            checkPwErrorBar(model),
                          ])))
                    ]))),
            model.getIsLoading() ? CommonLoadingComponent(isTouch: false) : Container()
          ]);
        }));
  }

  Container checkPwErrorBar(G012MainPageViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(32, 8, 16, 8),
      child: model.isCheckPasswordError()
          ? Text(model.getCheckPasswordErrorText(),
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 12,
                color: Color(0xffff4f9a),
              ))
          : Container(),
    );
  }

  Container checkPwTextField(G012MainPageViewModel model) {
    return Container(
        height: 49.00,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: TextField(
            obscureText: true,
            controller: model.checkPwController,
            onChanged: model.checkPwEditChange,
            onEditingComplete: model.onCheckEditComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              hintText: " 새 패스워드 확인",
              hintStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 14,
                color: Color(0xffb1b1b1),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  gapPadding: 0,
                  borderSide: !model.isCheckPasswordError()
                      ? BorderSide(color: Colors.white, width: 0)
                      : BorderSide(color: Color(0xffFF4F9A), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  gapPadding: 0,
                  borderSide: !model.isCheckPasswordError()
                      ? BorderSide(color: Color(0xff3497FD), width: 0)
                      : BorderSide(color: Color(0xffFF4F9A), width: 1)),
            )));
  }

  Container newPwTextField(G012MainPageViewModel model) {
    return Container(
        height: 49.00,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: TextField(
            obscureText: true,
            controller: model.newPwController,
            onChanged: model.onNewPwEditChange,
            onEditingComplete: model.onNewPwEditComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              hintText: " 새 패스워드",
              hintStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 14,
                color: Color(0xffb1b1b1),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  gapPadding: 0,
                  borderSide: !model.isNewPasswordError()
                      ? BorderSide(color: Colors.white, width: 0)
                      : BorderSide(color: Color(0xffFF4F9A), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  gapPadding: 0,
                  borderSide: !model.isNewPasswordError()
                      ? BorderSide(color: Color(0xff3497FD), width: 0)
                      : BorderSide(color: Color(0xffFF4F9A), width: 1)),
            )));
  }

  Container newPwErrorBar(G012MainPageViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(32, 8, 16, 8),
      child: model.isNewPasswordError()
          ? Text(model.getNewPasswordErrorText(),
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 12,
                color: Color(0xffff4f9a),
              ))
          : Container(),
    );
  }

  Container currentPwErrorBar(G012MainPageViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(32, 8, 16, 8),
      child: model.isCurrentPasswordError()
          ? Text(model.getCurrentPasswordErrorText(),
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 12,
                color: Color(0xffff4f9a),
              ))
          : Container(),
    );
  }

  Container currentPwTextField(G012MainPageViewModel model) {
    return Container(
        height: 49.00,
        margin: EdgeInsets.fromLTRB(16, 26, 16, 0),
        child: TextField(
            obscureText: true,
            controller: model.currentPwController,
            onChanged: model.onCurrentPwEditChange,
            onEditingComplete: model.onCurrentPwEditComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              hintText: "현재 패스워드",
              hintStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 14,
                color: Color(0xffb1b1b1),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  gapPadding: 0,
                  borderSide: !model.isCurrentPasswordError()
                      ? BorderSide(color: Colors.white, width: 0)
                      : BorderSide(color: Color(0xffFF4F9A), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  gapPadding: 0,
                  borderSide: !model.isCurrentPasswordError()
                      ? BorderSide(color: Color(0xff3497FD), width: 0)
                      : BorderSide(color: Color(0xffFF4F9A), width: 1)),
            )));
  }

  Container discriptionBar(BuildContext context) {
    return Container(
        height: 121.00,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Container(
            child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Text("권장사항",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ))),
          Positioned(
            top: 34,
            left: 0,
            width: MediaQuery.of(context).size.width - 64,
            child: Text(
                "*패스워드는 주기적으로 바꾸어 사용하시는 것이 안전합니다." +
                    "\n*패스워드에 8-16자리 영문 대소문자, 숫자, 특수문자를 조합" +
                    "하시면 비밀번호 안전도가 높아져 도용의 위험이 줄어듭니다.",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 11,
                  color: Color(0xff454f63),
                )),
          )
        ])),
        decoration: BoxDecoration(
          color: Color(0xfff5f5f5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 4.00),
              color: Color(0xff455b63).withOpacity(0.08),
              blurRadius: 16,
            )
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  Container topBar(G012MainPageViewModel model) {
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
            child: Text("패스워드 재설정",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        model.isCanComplete()
            ? new Container(
                height: 32.00,
                width: 75.00,
                margin: EdgeInsets.only(right: 16),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: model.onPwChangeComplete,
                  child: Text("완료",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
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
                  borderRadius: BorderRadius.circular(5.00),
                ),
              )
            : Container(
                height: 32.00,
                width: 75.00,
                margin: EdgeInsets.only(right: 16),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text("완료",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
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
                      blurRadius: 16,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5.00),
                ),
              )
      ]),
    );
  }
}
