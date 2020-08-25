import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseOutputPort.dart';

import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:google_fonts/google_fonts.dart';

class J013ViewModel extends ChangeNotifier implements PwFindEmailUseCaseOutputPort{
  final BuildContext context;
  final String email;
  final PwFindEmailUseCaseInputPort _pwFindEmailUseCaseInputPort;

  J013ViewModel({
    this.context,
    this.email,
    @required PwFindEmailUseCaseInputPort pwFindEmailUseCaseInputPort
  }): _pwFindEmailUseCaseInputPort =pwFindEmailUseCaseInputPort;

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void jumpReTryLoginPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: "/J001"),
            builder: (context) {
              return J001View();
            }),
        ModalRoute.withName('/'));
  }

  void popupReTrySendEmail() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width - 32,
                height: 275,
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 16, 16, 16),
                    child: Text("인증메일을 받지 못하셨나요?",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000),
                        )),
                    alignment: Alignment.centerLeft,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 64,
                      child: Text(
                          "이메일을 올바르게 입력하셨는지 다시 한번 확인해 보세요.\n\n"
                          "스팸편지함 혹은 휴지통을 확인해 보세요.\n\n"
                          "메일 서비스에 따라 도착하기까지 다소 시간이 걸릴 수 있습니다.\n\n",
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Color(0xff454f63),
                          )),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Color(0xffE4E7E8), width: 1),
                                    right: BorderSide(
                                        color: Color(0xffE4E7E8), width: 1))),
                            child: FlatButton(
                                onPressed: () async {
                                  await _pwFindEmailUseCaseInputPort.sendPasswordResetEmail(email,outputPort: this);

                                },
                                child: Text("재발송",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Color(0xffff4f9a),
                                    ))))),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Color(0xffE4E7E8), width: 1))),
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("닫기",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Color(0xff454f63),
                                    )))))
                  ])
                ]),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              )));
        });
  }

  @override
  void onSendPasswordResetEmail() {
    Navigator.of(context).pop();
  }
}
