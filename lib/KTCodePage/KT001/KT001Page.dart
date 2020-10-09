import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'KT001PageViewModel.dart';

class KT001Page extends StatefulWidget {
  @override
  _KT001PageState createState() => _KT001PageState();
}

class _KT001PageState extends State<KT001Page> {

  KT001PageViewModel k001pageViewModel;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: k001pageViewModel,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(children: <Widget>[
              Expanded(
                flex: 1,
                child: inquireAboutAnythingComponent(context),
              ),
              Divider(
                thickness: 2,
                color: Color(0xffE4E7E8),
              ),
              Expanded(
                flex: 1,
                child: googleErrorReportSurveyComponent(context),
              ),
              Divider(
                thickness: 2,
                color: Color(0xffE4E7E8),
              ),
              Expanded(
                flex: 1,
                child: proposalOnServiceComponent(context),
              )
            ])));
  }

  Stack proposalOnServiceComponent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 30,
            left: 32,
            child: SizedBox(
              child: Text(
                '서비스에 대한 의견을 주세요!',
                style: GoogleFonts.notoSans(
                  fontSize: 15,
                  color: const Color(0xff454f63),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        Positioned(
          top: 59,
          left: 32,
          width: MediaQuery.of(context).size.width - 64,
          child: Text.rich(
            TextSpan(
              style: GoogleFonts.notoSans(
                fontSize: 12,
                color: const Color(0xff454f63),
              ),
              children: [
                TextSpan(
                  text: '좋은 제안을 주신 유저 분 중 추첨을 통해 ',
                ),
                TextSpan(
                  text:
                  "${context.watch<KT001PageViewModel>().proposalOnServiceMaxDraw}",
                  style: GoogleFonts.notoSans(
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '분께',
                ),
                TextSpan(
                  text: ' ',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                  context.watch<KT001PageViewModel>().proposalOnServicePrize,
                  style: GoogleFonts.notoSans(
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '을 드릴 예정입니다.(당첨일 ',
                ),
                TextSpan(
                  text:
                  "${context.watch<KT001PageViewModel>().proposalOnServiceLotteryMonth}",
                  style: GoogleFonts.notoSans(
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '월 ',
                ),
                TextSpan(
                  text:
                  "${context.watch<KT001PageViewModel>().proposalOnServiceLotteryDay}",
                  style: GoogleFonts.notoSans(
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '일)',
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
          bottom: 30,
          right: 32,
          child: Container(
            width: 108.0,
            height: 36.0,
            child: FlatButton(
                onPressed: () {
                  context.read<KT001PageViewModel>().proposalOnServiceClick();

                },
                child: Text(
                  '제안하기',
                  style: GoogleFonts.notoSans(
                    fontSize: 13,
                    color: const Color(0xff454f63),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff454f63)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x14455b63),
                  offset: Offset(0, 12),
                  blurRadius: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Stack googleErrorReportSurveyComponent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 29,
          left: 32,
          child: Text("발견한 오류를 알려주세요!",
              style: GoogleFonts.notoSans(
                fontSize: 15,
                color: const Color(0xff454f63),
                fontWeight: FontWeight.w700,
              )),
        ),
        Positioned(
          top: 56,
          left: 32,
          width: MediaQuery.of(context).size.width - 64,
          child: Text.rich(
            TextSpan(
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: const Color(0xff454f63),
              ),
              children: [
                TextSpan(
                  text: '추첨을 통해 ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text:
                  "${context.watch<KT001PageViewModel>().errorReportMaxDraw}",
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '분께 ',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: context.watch<KT001PageViewModel>().errorReportPrize,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '을 드릴 예정입니다. (당첨일 ',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text:
                  "${context.watch<KT001PageViewModel>().errorReportLotteryMonth}",
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '월 ',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text:
                  "${context.watch<KT001PageViewModel>().errorReportLotteryDay}",
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '일)',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
            bottom: 30,
            right: 32,
            child: Container(
                width: 108.0,
                height: 36.0,
                child: FlatButton(
                  onPressed: () {
                    context.read<KT001PageViewModel>().errorReportSurveyClick();
                  },
                  child: Text(
                    '오류신고',
                    style: GoogleFonts.notoSans(
                      fontSize: 13,
                      color: const Color(0xff454f63),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xffffffff),
                  border:
                  Border.all(width: 1.0, color: const Color(0xff454f63)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x14455b63),
                      offset: Offset(0, 12),
                      blurRadius: 16,
                    ),
                  ],
                )))
      ],
    );
  }

  Container inquireAboutAnythingComponent(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Positioned(
          top: 25,
          left: 32,
          child: Container(
            child: Text(
              "무엇이든 물어보세요.\n가벼운 호기심에 나온 질문도 괜찮습니다!",
              style: GoogleFonts.notoSans(
                fontSize: 15,
                color: const Color(0xff454f63),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Positioned(
          bottom: 31,
          right: 32,
          child: Container(
              width: 108.0,
              height: 36.0,
              child: FlatButton(
                  onPressed: () {
                    context
                        .read<KT001PageViewModel>()
                        .inquireAboutAnythingClick();
                  },
                  child: SizedBox(
                      width: 62.0,
                      child: Text(
                        '문의하기',
                        style: GoogleFonts.notoSans(
                          fontSize: 13,
                          color: const Color(0xff454f63),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ))),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xffffffff),
                  border:
                  Border.all(width: 1.0, color: const Color(0xff454f63)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x14455b63),
                      offset: Offset(0, 12),
                      blurRadius: 16,
                    )
                  ])),
        )
      ]),
    );
  }
}

