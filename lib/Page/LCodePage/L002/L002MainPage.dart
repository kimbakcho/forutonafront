import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Components/DottedLine/DottedLine.dart';
import 'package:forutonafront/Page/LCodePage/L004/L004MainPage.dart';

import 'package:forutonafront/Page/LCodePage/LCodeCheckBox/LCodeCheckBox.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'TermsTextLink/TermsTextLink.dart';

class L002MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L002MainPageViewModel(sl()),
        child: Consumer<L002MainPageViewModel>(builder: (_, model, child) {
          return Material(
              color: Colors.white,
              child: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                        title: '이용약관 동의',
                        progressValue: 0.2,
                        enableTailButton: model.enableTailButton,
                        tailButtonLabel: "다음",
                        onTailButtonClick: () {
                          model.nextPage(context);
                        }),
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
                                termsIdx: 15,
                              ),
                              LCodeCheckBox(
                                controller:
                                    model.serviceAgreeCheckBoxController,
                                size: 30,
                              )
                            ])),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TermsTextLink(
                                label: '운영정책 동의(필수)',
                                termsIdx: 17,
                              ),
                              LCodeCheckBox(
                                controller: model
                                    .operationalPoliciesAgreeCheckBoxController,
                                size: 30,
                              )
                            ])),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TermsTextLink(
                                label: '위치정보 처리방침(필수)',
                                termsIdx: 17,
                              ),
                              LCodeCheckBox(
                                controller: model
                                    .positionPrivacyAgreeCheckBoxController,
                                size: 30,
                              )
                            ])),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TermsTextLink(
                                label: '개인정보 수집 동의(필수)',
                                termsIdx: 16,
                              ),
                              LCodeCheckBox(
                                controller:
                                    model.privacyAgreeCheckBoxController,
                                size: 30,
                              )
                            ])),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TermsTextLink(
                                gotoPageFlag: false,
                                label: '마케팅 전체 수신동의(선택)',
                                termsIdx: 15,
                              ),
                              LCodeCheckBox(
                                controller:
                                    model.marketingAgreeCheckBoxController,
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
  LCodeCheckBoxController privacyAgreeCheckBoxController;
  LCodeCheckBoxController positionPrivacyAgreeCheckBoxController;
  LCodeCheckBoxController marketingAgreeCheckBoxController;
  LCodeCheckBoxController operationalPoliciesAgreeCheckBoxController;
  final FUserInfoJoinReqDto _fUserInfoJoinReqDto;

  L002MainPageViewModel(this._fUserInfoJoinReqDto) {
    allCheckBoxController = LCodeCheckBoxController(
        onChangeValue: _allCheckBoxControllerStateChange);
    serviceAgreeCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
    privacyAgreeCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
    positionPrivacyAgreeCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
    marketingAgreeCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
    operationalPoliciesAgreeCheckBoxController =
        LCodeCheckBoxController(onChangeValue: _checkBoxStateChange);
  }

  _allCheckBoxControllerStateChange(bool value) {
    serviceAgreeCheckBoxController.setValue(value);
    privacyAgreeCheckBoxController.setValue(value);
    positionPrivacyAgreeCheckBoxController.setValue(value);
    marketingAgreeCheckBoxController.setValue(value);
    operationalPoliciesAgreeCheckBoxController.setValue(value);
    notifyListeners();
  }

  get enableTailButton {
    return isCheckSatisfied();
  }

  //TODO 여기서 시작 하는데 _fUserInfoJoinReq 가입에 필요한 정보 넣어 주는것 부터
  _checkBoxStateChange(bool value) {
    if (isAllCheck()) {
      allCheckBoxController.setValue(true);
    } else {
      allCheckBoxController.setValue(false);
    }
    notifyListeners();
  }

  bool isCheckSatisfied() {
    if (serviceAgreeCheckBoxController.getValue() &&
        privacyAgreeCheckBoxController.getValue() &&
        positionPrivacyAgreeCheckBoxController.getValue() &&
        operationalPoliciesAgreeCheckBoxController.getValue()) {
      return true;
    } else {
      return false;
    }
  }

  bool isAllCheck() {
    if (serviceAgreeCheckBoxController.getValue() &&
        privacyAgreeCheckBoxController.getValue() &&
        positionPrivacyAgreeCheckBoxController.getValue() &&
        operationalPoliciesAgreeCheckBoxController.getValue() &&
        marketingAgreeCheckBoxController.getValue()) {
      return true;
    } else {
      return false;
    }
  }

  void nextPage(BuildContext context) {
    _fUserInfoJoinReqDto.martketingAgree =
        marketingAgreeCheckBoxController.getValue();
    _fUserInfoJoinReqDto.forutonaAgree =
        serviceAgreeCheckBoxController.getValue();
    _fUserInfoJoinReqDto.privateAgree =
        privacyAgreeCheckBoxController.getValue();
    _fUserInfoJoinReqDto.positionAgree =
        positionPrivacyAgreeCheckBoxController.getValue();
    _fUserInfoJoinReqDto.forutonaManagementAgree =
        operationalPoliciesAgreeCheckBoxController.getValue();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return L004MainPage();
    }));
  }
}
