import 'package:flutter/material.dart';
import 'package:forutonafront/JCodePage/J008/J008ViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class J008View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J008ViewModel(context),
        child: Consumer<J008ViewModel>(builder: (_, model, child) {
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
                            phoneAuthBar(context, model),
                            emailAuthBar(context, model)
                          ]),
                        ],
                      )))
            ],
          );
        }));
  }

  Container emailAuthBar(BuildContext context, J008ViewModel model) {
    return Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 16,
                left: 16,
                child: Text(
                  "이메일 인증하기",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ),
                )),
            Positioned(
                top: 46,
                left: 16,
                width: MediaQuery.of(context).size.width - 122,
                child: Container(
                  child: Text("계정에 사용한 이메일 주소를 인증하고 패스워드를 변경합니다.",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: Color(0xff78849e),
                      )),
                )),
            Positioned(
              bottom: 16,
              right: 16,
              width: 42,
              height: 42,
              child: Container(
                height: 42.00,
                width: 42.00,
                child: FlatButton(
                  shape: CircleBorder(),
                  onPressed: model.jumpToJ012Page,
                  padding: EdgeInsets.all(0),
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 25),
                ),
                decoration: BoxDecoration(
                    color: Color(0xff3497fd),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 12.00),
                        color: Color(0xff455b63).withOpacity(0.10),
                        blurRadius: 16,
                      ),
                    ]),
              ),
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        height: 120.00,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 4.00),
              color: Color(0xff455b63).withOpacity(0.08),
              blurRadius: 16,
            ),
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  Container phoneAuthBar(BuildContext context, J008ViewModel model) {
    return Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 16,
                left: 16,
                child: Text(
                  "휴대폰 인증하기",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ),
                )),
            Positioned(
                top: 46,
                left: 16,
                width: MediaQuery.of(context).size.width - 122,
                child: Container(
                  child: Text("계정에 등록된 휴대폰 번호를 인증하고 패스워드를 변경합니다.",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: Color(0xff78849e),
                      )),
                )),
            Positioned(
              bottom: 16,
              right: 16,
              width: 42,
              height: 42,
              child: Container(
                height: 42.00,
                width: 42.00,
                child: FlatButton(
                  shape: CircleBorder(),
                  onPressed: model.jumpToJ009Page,
                  padding: EdgeInsets.all(0),
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 25),
                ),
                decoration: BoxDecoration(
                    color: Color(0xff3497fd),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 12.00),
                        color: Color(0xff455b63).withOpacity(0.10),
                        blurRadius: 16,
                      ),
                    ]),
              ),
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        height: 120.00,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 4.00),
              color: Color(0xff455b63).withOpacity(0.08),
              blurRadius: 16,
            ),
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  Container topBar(J008ViewModel model) {
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
            child: Text("패스워드 찾기",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer()
      ]),
    );
  }
}
