import 'package:flutter/material.dart';
import 'package:forutonafront/JCodePage/J001/J001ViewModel.dart';
import 'package:provider/provider.dart';

class J001View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => J001ViewModel(context),
          ),

        ],
        child: Consumer<J001ViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: ListView(children: <Widget>[
                      loginTextBar(),
                      idTextFieldBar(model),
                      pwTextFieldBar(model),
                      logInBtnBar(model, context),
                      pwFindBar(),
                    ]),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: closeBar(context),
                  ),
                  Positioned(
                      top:MediaQuery.of(context).size.height - 167,
                      left: 0,
                      child: Column(
                        children: <Widget>[
                          orBar(context),
                          snsLogInBtnBar(context,model),
                          joinBtnBar(context)
                        ],
                      ))
                ],
              ),
            ))
          ]);
        }));
  }

  Container joinBtnBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 22),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
      child: FlatButton(
        onPressed: () {},
        child: RichText(
          text: TextSpan(
              text: "아직 회원이 아니신가요?",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xff78849E),
                decoration: TextDecoration.underline,
              ),
              children: [
                TextSpan(
                    text: "가입하기",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff3497FD),
                      decoration: TextDecoration.underline,
                    ))
              ]),
        ),
      ),
    );
  }

  Container snsLogInBtnBar(BuildContext context,J001ViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 23),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Container(
            height: 36.00,
            width: 36.00,
            child: FlatButton(
              onPressed: model.onFaceBookLogin,
              padding: EdgeInsets.all(0),
            ),
            margin: EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MainImage/faceBookIcon.png"),
                  fit: BoxFit.cover),
              border: Border.all(
                width: 2.00,
                color: Color(0xff454f63),
              ),
              borderRadius: BorderRadius.circular(8.00),
            )),
        Container(
            height: 36.00,
            width: 36.00,
            child: FlatButton(
              onPressed: model.onKakaoLogin,
              padding: EdgeInsets.all(0),
            ),
            margin: EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MainImage/kakaoTalkIcon.png"),
                  fit: BoxFit.cover),
              border: Border.all(
                width: 2.00,
                color: Color(0xff454f63),
              ),
              borderRadius: BorderRadius.circular(8.00),
            )),
        Container(
            height: 36.00,
            width: 36.00,
            child: FlatButton(
              onPressed: model.onNaverLogin,
              padding: EdgeInsets.all(0),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MainImage/naverIcon.png"),
                  fit: BoxFit.cover),
              border: Border.all(
                width: 2.00,
                color: Color(0xff454f63),
              ),
              borderRadius: BorderRadius.circular(8.00),
            ))
      ]),
    );
  }

  Container orBar(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            height: 1.00,
            width: MediaQuery.of(context).size.width / 2 - 46,
            color: Color(0xfff2f0f1),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
            child: Text("OR",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 12,
                  color: Color(0xff78849e).withOpacity(0.56),
                )),
          ),
          Container(
            height: 1.00,
            width: MediaQuery.of(context).size.width / 2 - 50,
            color: Color(0xfff2f0f1),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
    );
  }

  Container pwFindBar() {
    return Container(
      height: 14,
      margin: EdgeInsets.fromLTRB(32, 24, 16, 0),
      alignment: Alignment.centerRight,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Text("혹시 비밀번호를 분실하셨나요?",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 10,
                color: Color(0xffff4f9a),
              ))),
    );
  }

  Container logInBtnBar(J001ViewModel model, BuildContext context) {
    return Container(
      height: 39.00,
      child: FlatButton(
          onPressed: model.isActiveButton() ? model.onLoginBtnClick : null,
          child: Text("로그인",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color:
                    model.isActiveButton() ? Colors.white : Color(0xff7a7a7a),
              ))),
      margin: EdgeInsets.fromLTRB(36, 24, 36, 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: model.isActiveButton() ? Color(0xff3497FD) : Color(0xffd4d4d4),
        border: Border.all(
          width: 1.00,
          color: model.isActiveButton() ? Color(0xff4F72FF) : Color(0xffb1b1b1),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(8.00),
      ),
    );
  }

  Container pwTextFieldBar(J001ViewModel model) {
    return Container(
        margin: EdgeInsets.fromLTRB(36, 16, 36, 0),
        child: TextField(
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontSize: 12,
            color: Color(0xff454f63),
          ),
          focusNode: model.pwTextFocusNode,
          controller: model.pwTextFieldController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: "비밀번호",
              labelStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 12,
                color: model.pwTextFocusNode.hasFocus
                    ? Color(0xff3497fd)
                    : Color(0xff78849E),
              ),
              hintText: "비밀번호",
              hintStyle: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 12,
                color: Color(0xff454f63),
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF2F0F1))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF2F0F1))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff3497FD)))),
        ));
  }

  Container idTextFieldBar(J001ViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(36, 16, 36, 0),
      child: TextField(
        controller: model.idTextFieldController,
        focusNode: model.idTextFocusNode,
        style: TextStyle(
          fontFamily: "Noto Sans CJK KR",
          fontSize: 12,
          color: Color(0xff454f63),
        ),
        decoration: InputDecoration(
            labelText: "아이디(이메일 주소)",
            labelStyle: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontSize: 12,
              color: model.idTextFocusNode.hasFocus
                  ? Color(0xff3497fd)
                  : Color(0xff78849E),
            ),
            hintText: "아이디(이메일 주소)",
            hintStyle: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontSize: 12,
              color: Color(0xff454f63),
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF2F0F1))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF2F0F1))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff3497FD)))),
      ),
    );
  }

  Container loginTextBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(36, 57, 16, 0),
      child: Text("로그인",
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xff454f63),
          )),
    );
  }

  Container closeBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.only(top: 16, right: 16),
          height: 23.00,
          width: 23.00,
          child: Icon(Icons.clear, color: Colors.white, size: 15),
          decoration: BoxDecoration(
            color: Color(0xff454f63),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              )
            ],
            shape: BoxShape.circle,
          )),
    );
  }


}
