import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L017MainPage extends StatelessWidget {
  final String email;

  const L017MainPage({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L017MainPageViewModel(email,sl()),
        child: Consumer<L017MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    LCodeAppBar(
                        title: "이메일 인증하기",
                        visibleTailButton: false,
                        enableTailButton: false,
                        progressValue: 1),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 22,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Text.rich(
                                      TextSpan(
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          color: const Color(0xff000000),
                                          letterSpacing: -0.28,
                                          height: 1.4285714285714286,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '패스워드를 변경하고 로그인하세요.\n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: email,
                                            style: TextStyle(
                                              color: const Color(0xff3497fd),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '로 \n패스워드를 재설정하실 수 있는 메일을 발송하였습니다.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 38,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 68, right: 68),
                                    child: Row(children: [
                                      Expanded(
                                          child: FlatButton(
                                              height: 50,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              color: Color(0xff3497FD),
                                              onPressed: () {
                                                model._pop(context);
                                              },
                                              child: Text('다시 로그인하기',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xfff9f9f9),
                                                    fontWeight: FontWeight.w500,
                                                  ))))
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 64,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () {
                                              model._alertShow(context);
                                            },
                                            child: Text('혹시 인증 메일을 받지 못하셨나요?',
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0xffff4f9a),
                                                  letterSpacing: -0.26,
                                                  fontWeight: FontWeight.w300,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  height: 1.6923076923076923,
                                                )))),
                                  )
                                ])))
                  ])));
        }));
  }
}

class L017MainPageViewModel extends ChangeNotifier {
  final String email;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  L017MainPageViewModel(this.email,this._fireBaseAuthAdapterForUseCase);

  _pop(BuildContext context) {
    //until L001
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  _sendPwResetEmail(BuildContext context)async{
    await this._fireBaseAuthAdapterForUseCase.sendPasswordResetEmail(email);
    Navigator.of(context).pop();
  }

  _alertShow(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  side: BorderSide(color: Color(0xffE4E7E8))),
              actionsPadding: EdgeInsets.all(0),
              titlePadding:
                  EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
              contentPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.all(32),
              title: Text(
                '인증메일을 받지 못하셨나요?',
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  height: 2.25,
                ),
                textAlign: TextAlign.left,
              ),
              backgroundColor: Colors.white,
              content: Container(
                  height: 190,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        '이메일을 올바르게 입력하셨는지 다시 한번 확인해 보세요.\n스팸편지함 혹은 휴지통을 확인해 보세요.\n메일 서비스에 따라 도착하기까지 다소 시간이 걸릴 수 있습니다.',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: const Color(0xff3a3e3f),
                          fontWeight: FontWeight.w300,
                          height: 1.5714285714285714,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Color(0xffE4E7E8)))),
                        height: 50,
                        child: Row(children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Color(0xffE4E7E8)))),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {
                                            _sendPwResetEmail(context);
                                          },
                                          child: Center(
                                              child: Text('재발송',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 13,
                                                    color:
                                                        const Color(0xffff4f9a),
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.5384615384615385,
                                                  ))))))),
                          Expanded(
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Center(
                                          child: Text('닫기',
                                              style: GoogleFonts.notoSans(
                                                fontSize: 13,
                                                color: const Color(0xff3a3e3f),
                                                fontWeight: FontWeight.w700,
                                                height: 1.5384615384615385,
                                              ))))))
                        ]))
                  ])));
        });
  }
}
