import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Value/FUserInfoJoinReq.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Common/Country/CountrySelectButton.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthComponent.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L005MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L005MainPageViewModel(sl()),
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
                            enableTailButton: model.enableTailButton,
                            title: "휴대폰 인증",
                            onTailButtonClick: () {
                              model.nextPage(context);
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
                          child: PhoneAuthComponent(),
                        )

                        //TODO 휴대폰 인증 구현 필요
                      ])));
        }));
  }
}

class L005MainPageViewModel extends ChangeNotifier {
  bool enableTailButton = false;
  final FUserInfoJoinReq _fUserInfoJoinReq;

  PhoneAuthComponentController _phoneAuthComponentController;

  L005MainPageViewModel(this._fUserInfoJoinReq) {
    this._phoneAuthComponentController = PhoneAuthComponentController();
  }

  onCurrentCountryItem(CountryItem countryItem) {
    notifyListeners();
  }

  void nextPage(BuildContext context) {}
}
