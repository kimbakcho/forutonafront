import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthComponent.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeUseCase.dart';
import 'package:forutonafront/Page/LCodePage/L015/L015MainPage.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L014MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L014MainPageViewModel(sl(), context),
        child: Consumer<L014MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                      title: "휴대폰 인증하기",
                      progressValue: 0.6,
                      visibleTailButton: true,
                      onTailButtonClick: () {
                        model._checkAuth();
                      },
                      tailButtonLabel: "다음",
                      enableTailButton: model._isCanNext,
                    ),
                    Expanded(
                        child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  SizedBox(
                                    height: 21,
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
                                              text:
                                                  '아이디에 저장된 휴대폰번호와 일치하지 않습니다. \n',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '번호변경 시, 이메일 인증으로 패스워드를 변경해주세요.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      )),
                                  SizedBox(
                                    height: 28,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: PhoneAuthComponent(
                                      phoneAuthMode: PhoneAuthMode.PhonePwFind,
                                      email: model
                                          ._pwChangeFromPhoneAuthReqDto!.email,
                                      phoneAuthComponentController:
                                          model._phoneAuthComponentController,
                                    ),
                                  )
                                ]))))
                  ])));
        }));
  }
}

class L014MainPageViewModel extends ChangeNotifier {
  PhoneAuthComponentController? _phoneAuthComponentController;

  bool _hasTryReqAuth = false;

  BuildContext? context;

  final PwChangeFromPhoneAuthReqDto? _pwChangeFromPhoneAuthReqDto;

  L014MainPageViewModel(this._pwChangeFromPhoneAuthReqDto, this.context) {
    _phoneAuthComponentController = PhoneAuthComponentController(
        onTryAuthReqSuccess: _onTryAuthReqSuccess,
        onPhoneAuthCheckSuccess: (PhoneAuthNumberResDto phoneAuthNumberResDto) {
          _onPhoneAuthCheckSuccess(
              phoneAuthNumberResDto as PwFindPhoneAuthNumberResDto);
        });
  }

  _onTryAuthReqSuccess() {
    _hasTryReqAuth = true;
    notifyListeners();
  }

  bool get _isCanNext {
    return _hasTryReqAuth;
  }

  _onPhoneAuthCheckSuccess(
      PwFindPhoneAuthNumberResDto pwFindPhoneAuthNumberResDto) {
    _pwChangeFromPhoneAuthReqDto!.email = pwFindPhoneAuthNumberResDto.email;
    _pwChangeFromPhoneAuthReqDto!.emailPhoneAuthToken =
        pwFindPhoneAuthNumberResDto.emailPhoneAuthToken;
    _pwChangeFromPhoneAuthReqDto!.internationalizedPhoneNumber =
        pwFindPhoneAuthNumberResDto.internationalizedDialCode! +
            " " +
            pwFindPhoneAuthNumberResDto.phoneNumber!;

    Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
      return L015MainPage();
    }));
  }

  void _checkAuth() async {
    _phoneAuthComponentController!.checkAuthCheckNumber();
  }
}
