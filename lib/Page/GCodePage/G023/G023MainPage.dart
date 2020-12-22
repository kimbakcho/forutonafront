import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'G023MainPageViewModel.dart';

class G023MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G023MainPageViewModel(context),
        child: Consumer<G023MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Positioned(top: 0, left: 0,
                            width: MediaQuery.of(context).size.width,
                            child: topBar(model)),
                        Positioned(
                            top: 63,
                            left: 0,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 326.00,
                              child: Center(child: Text("준비중")),
                              color: Color(0xff454f63).withOpacity(0.30),
                            )),
                        Positioned(
                          top: 390,
                          left: 0,
                          child: companyIntroduceBar(context),
                        ),
                      ],
                    )))
          ]);
        }));
  }

  Container companyIntroduceBar(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("상호:",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff7a7a7a),
                  )),
              Spacer(),
              Text("(주)FORUTONA",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Text("대표:",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff7a7a7a),
                  )),
              Spacer(),
              Text("유호영",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Text("주소:",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff7a7a7a),
                  )),
              Spacer(),
              Text("경기도 시흥시 신천천동로 7, 403호",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Text("사업자등록 번호:",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff7a7a7a),
                  )),
              Spacer(),
              Text("",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Text("통신판매업신고번호:",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff7a7a7a),
                  )),
              Spacer(),
              Text("7470400107",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff454f63),
                  ))
            ],
          )
        ],
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  topBar(G023MainPageViewModel model) {
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
            child: Text("회사 소개",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
