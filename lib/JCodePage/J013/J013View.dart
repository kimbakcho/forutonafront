import 'package:flutter/material.dart';
import 'package:forutonafront/JCodePage/J013/J013ViewModel.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class J013View extends StatelessWidget {
  final String email;

  J013View(this.email);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J013ViewModel(
          context: context,
          email: email,
          pwFindEmailUseCaseInputPort: sl()
        ),
        child: Consumer<J013ViewModel>(builder: (_, model, child) {
          return Stack(
            children: <Widget>[
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
                                  cautionBar(context),
                                  jumpLoginPageBtnBar(model, context),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.fromLTRB(16, 14, 16, 0),
                                      child: FlatButton(
                                        onPressed: model.popupReTrySendEmail,
                                        padding: EdgeInsets.all(0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            child: Text("혹시 인증 메일을 받지 못하셨나요?",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                  color: Color(0xffff4f9a),
                                                  decoration: TextDecoration.underline,
                                                )),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ]),
                          joinProgressBar(context)
                        ],
                      )))
            ],
          );
        }));
  }

  Container jumpLoginPageBtnBar(J013ViewModel model, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 50.00,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: model.jumpReTryLoginPage,
        child: Text("다시 로그인하기",
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xfff9f9f9),
            )),
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff3497fd),
        border: Border.all(
          width: 1.00,
          color: Color(0xff4f72ff),
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
              width: MediaQuery.of(context).size.width - 80,
              child: RichText(
                text: TextSpan(
                    text: email,
                    style: GoogleFonts.notoSans(
                      fontSize: 11,
                      color: Color(0xff3497FD),
                    ),
                    children: [
                      TextSpan(
                          text: "로 패스워드를 재설정하실 수 있는 메일을 발송하였습니다.",
                          style: GoogleFonts.notoSans(
                            fontSize: 11,
                            color: Color(0xff454F63),
                          ))
                    ]),
              ))
        ],
      ),
      height: 96.00,
      width: MediaQuery.of(context).size.width,
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

  Container topBar(J013ViewModel model) {
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
            child: Text("패스워드 설정 메일 발송",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
      ]),
    );
  }
}
