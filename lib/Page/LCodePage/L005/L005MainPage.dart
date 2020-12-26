import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthComponent.dart';
import 'package:forutonafront/Page/LCodePage/L007/L007MainPage.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L005MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L005MainPageViewModel(sl(), context),
        child: Consumer<L005MainPageViewModel>(builder: (_, model, child) {
          return Material(
              child: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LCodeAppBar(
                            progressValue: 0.7,
                            tailButtonLabel: "다음",
                            // enableTailButton: true,
                            //TODO 회원가입 완료시 해당 부분으로 교체
                            enableTailButton: model.enableTailButton,
                            title: "휴대폰 인증",
                            onTailButtonClick: () {
                              // model.testNextButton();
                              //TODO 회원가입 완료시 해당 부분으로 교체
                              model.checkPhoneAuth();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
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
                                  text: '연락 받을 수 있는 휴대폰 번호를 입력하세요. \n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: '서비스 이용에 반드시 필요합니다.',
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
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: PhoneAuthComponent(
                            phoneAuthComponentController:
                                model._phoneAuthComponentController,
                          ),
                        )
                      ])));
        }));
  }
}

class L005MainPageViewModel extends ChangeNotifier {
  bool enableTailButton = false;
  final FUserInfoJoinReqDto _fUserInfoJoinReqDto;

  final BuildContext context;

  PhoneAuthComponentController _phoneAuthComponentController;

  L005MainPageViewModel(this._fUserInfoJoinReqDto, this.context) {
    this._phoneAuthComponentController = PhoneAuthComponentController(
        onPhoneAuthCheckSuccess: onPhoneAuthCheckSuccess,
        onTryAuthReqSuccess: onTryAuthReqSuccess);
  }

  testNextButton() {
    _fUserInfoJoinReqDto.countryCode = "KR";
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return L007MainPage();
    }));
  }

  onPhoneAuthCheckSuccess(PhoneAuthNumberResDto phoneAuthNumberResDto) {
    _fUserInfoJoinReqDto.phoneAuthToken = phoneAuthNumberResDto.phoneAuthToken;
    _fUserInfoJoinReqDto.internationalizedPhoneNumber =
        phoneAuthNumberResDto.internationalizedDialCode +
            " " +
            phoneAuthNumberResDto.phoneNumber;
    CodeCountry codeCountry = CodeCountry();
    var selectedCountryItem = codeCountry.countryList().firstWhere((element) =>
        element.dialCode == phoneAuthNumberResDto.internationalizedDialCode);

    _fUserInfoJoinReqDto.countryCode = selectedCountryItem.code;

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return L007MainPage();
    }));
  }

  onTryAuthReqSuccess() {
    enableTailButton = true;
    notifyListeners();
  }

  onCurrentCountryItem(CountryItem countryItem) {
    notifyListeners();
  }

  void checkPhoneAuth() {
    _phoneAuthComponentController.checkAuthCheckNumber();
  }
}
