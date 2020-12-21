import 'package:flutter/material.dart';
import 'package:forutonafront/Components/DottedLine/DottedLine.dart';
import 'package:forutonafront/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/LCodePage/LCodeCheckBox/LCodeCheckBox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'TermsTextLink/TermsTextLink.dart';

class L002MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L002MainPageViewModel(),
        child: Consumer<L002MainPageViewModel>(builder: (_, model, child) {
          return Material(
              color: Colors.white,
              child: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    LCodeAppBar(
                        progressValue: 0.25,
                        enableTailButton: false,
                        tailButtonLabel: "다음",
                        onTailButtonClick: () {}),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '모든 약관에 동의합니다',
                                style: GoogleFonts.notoSans(
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.4,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text("가입을 위해서는 필수 항목 동의가 필요합니다",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                    letterSpacing: -0.28,
                                    height: 1.4285714285714286,
                                  ))
                            ],
                          ),
                          LCodeCheckBox(
                            controller: model.allCheckBoxController,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: DottedLine(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TermsTextLink(
                                label: '서비스 이용약관 동의(필수)',
                                linkTitle: "서비스 이용약관 동의",
                                idx: 15,
                              ),
                              LCodeCheckBox(
                                controller: model.serviceAgreeCheckBoxController,
                                size: 30,
                              )
                            ]))
                  ])));
        }));
  }
}

class L002MainPageViewModel extends ChangeNotifier {
  LCodeCheckBoxController allCheckBoxController;
  LCodeCheckBoxController serviceAgreeCheckBoxController;


  L002MainPageViewModel() {
    allCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
    serviceAgreeCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
  }

  _checkBoxStateChange(bool value) {
    print(allCheckBoxController.getValue());
  }
}
