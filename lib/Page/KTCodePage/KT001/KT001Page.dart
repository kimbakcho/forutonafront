import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'KT001PageViewModel.dart';

class KT001Page extends StatefulWidget {
  @override
  _KT001PageState createState() => _KT001PageState();
}

class _KT001PageState extends State<KT001Page> {
  KT001PageViewModel? k001pageViewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KT001PageViewModel(
            androidIntentAdapter: sl(),
            errorReportSurvey: GoogleSurveyErrorReportUseCase(),
            inquireAboutAnythingUseCase: InquireAboutAnythingUseCase(),
            proposalOnServiceSurvey: GoogleProposalOnServiceSurveyUseCase()),
        child: Consumer<KT001PageViewModel>(builder: (_, model, __) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                padding: MediaQuery.of(context).padding,
                child: Column(children: <Widget>[
                  Container(
                    height: 26,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffE4E7E8),
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      '정식버전에서 채팅, 팔로우 기능의 소셜페이지로 변경됩니다.',
                      style: GoogleFonts.notoSans(
                        fontSize: 11,
                        color: const Color(0xff5b5b5b),
                        height: 1.45,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 146,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Icon(ForutonaIcon.support),
                              margin: EdgeInsets.only(right: 6),
                            ),
                            Text(
                              '고객센터',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                            child: Container(
                              child: Text(
                                '무엇이든지 물어보세요!',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  height: 1.33,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: (){
                              model.openKakaoOpenTalk("https://open.kakao.com/o/sZJ1uUwb");
                            },
                            child: Text(
                              '문의하기',
                              style: GoogleFonts.notoSans(
                                fontSize: 13,
                                color: const Color(0xff3a3e3f),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(
                                    color: Color(0xff3A3E3F), width: 1)),
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xffe4e7e8)),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14455b63),
                          offset: Offset(0, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 146,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Icon(ForutonaIcon.squareq),
                              margin: EdgeInsets.only(right: 6),
                            ),
                            Text(
                              '서비스 개선',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                            child: Container(
                              child: Text(
                                '오류 또는 개선사항 환영합니다.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  height: 1.33,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: (){
                              model.openKakaoOpenTalk("https://open.kakao.com/o/sUFJMxqb");
                            },
                            child: Text(
                              '오류 접수',
                              style: GoogleFonts.notoSans(
                                fontSize: 13,
                                color: const Color(0xff3a3e3f),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(
                                    color: Color(0xff3A3E3F), width: 1)),
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xffe4e7e8)),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14455b63),
                          offset: Offset(0, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 146,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Icon(ForutonaIcon.edit),
                              margin: EdgeInsets.only(right: 6),
                            ),
                            Text(
                              '설문조사 참여',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                            child: Container(
                              child: Text(
                                '여러분의 의견을 들려주세요!',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  height: 1.33,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: (){
                              model.openGoogleSurvey("https://docs.google.com/forms/d/15a4_D4KaD7emtrBnKoVpZA-eZbczcl7B4qIUn_I7yzc/edit");
                            },
                            child: Text(
                              '설문조사 참여',
                              style: GoogleFonts.notoSans(
                                fontSize: 13,
                                color: const Color(0xff3a3e3f),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(
                                    color: Color(0xff3A3E3F), width: 1)),
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xffe4e7e8)),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14455b63),
                          offset: Offset(0, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                  )
                ]),
              ));
        }));
  }

  Stack proposalOnServiceComponent(
      BuildContext context, KT001PageViewModel model) {
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
                  text: "${model.proposalOnServiceMaxDraw}",
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
                  text: model.proposalOnServicePrize,
                  style: GoogleFonts.notoSans(
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '을 드릴 예정입니다.(당첨일 ',
                ),
                TextSpan(
                  text: "${model.proposalOnServiceLotteryMonth}",
                  style: GoogleFonts.notoSans(
                    color: const Color(0xff3497fd),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '월 ',
                ),
                TextSpan(
                  text: "${model.proposalOnServiceLotteryDay}",
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
                  model.proposalOnServiceClick();
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

  Stack googleErrorReportSurveyComponent(
      BuildContext context, KT001PageViewModel model) {
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
                  text: "${model.errorReportMaxDraw}",
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
                  text: model.errorReportPrize,
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
                  text: "${model.errorReportLotteryMonth}",
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
                  text: "${model.errorReportLotteryDay}",
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
                    model.errorReportSurveyClick();
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

  Container inquireAboutAnythingComponent(KT001PageViewModel model) {
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
                    model.inquireAboutAnythingClick();
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
