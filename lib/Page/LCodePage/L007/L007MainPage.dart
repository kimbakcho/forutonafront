import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/EmailValidImpl.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/HasIdError.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/IdDuplicationValidImpl.dart';
import 'package:forutonafront/Components/EmailCheckComponent/EmailCheckComponent.dart';
import 'package:forutonafront/Components/PwInputAndCheckComponent/PwInputAndCheckComponent.dart';
import 'package:forutonafront/Page/LCodePage/L008/L008MainPage.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L007MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L007MainPageViewModel(sl()),
        child: Consumer<L007MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
            padding: MediaQuery.of(context).padding,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              LCodeAppBar(
                title: "아이디 등록",
                tailButtonLabel: "다음",
                visibleTailButton: true,
                progressValue: 0.8,
                enableTailButton: model._nextButtonSatisfied,
                onTailButtonClick: () {
                  if (model._nextButtonSatisfied) {
                    model.onCheckWithNextPage(context);
                  }
                },
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                text: '아이디는 실제 사용하시는 이메일로 작성해주세요. \n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '패스워드 분실시 복구에 사용됩니다.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        )),
                    SizedBox(
                      height: 29,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: EmailCheckComponent(
                          emailValid: IdDuplicationValidImpl(
                              emailValid: EmailValidImpl(),
                              fireBaseAuthAdapterForUseCase: sl(),
                              duplicationErrorLogin: HasIdError()),
                          emailCheckComponentController:
                              model._emailCheckComponentController,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: PwInputAndCheckComponent(
                        pwInputAndCheckComponentController:
                            model._pwInputAndCheckComponentController,
                      ),
                    )
                  ],
                ),
              )),
            ]),
          ));
        }));
  }
}

class L007MainPageViewModel extends ChangeNotifier {
  EmailCheckComponentController _emailCheckComponentController;

  String currentEmailValue = "";

  String currentPwValue = "";

  String currentPwCheckValue = "";

  PwInputAndCheckComponentController _pwInputAndCheckComponentController;

  final FUserInfoJoinReqDto _fUserInfoJoinReqDto;

  L007MainPageViewModel(this._fUserInfoJoinReqDto) {
    _emailCheckComponentController =
        EmailCheckComponentController(onChangeEditText: onEmailEditChangeText);
    _pwInputAndCheckComponentController = PwInputAndCheckComponentController(
        onChangeEditValue: onPwPwCheckChangeText);
  }

  onPwPwCheckChangeText(String pw, String pwCheck) {
    currentPwValue = pw;
    currentPwCheckValue = pwCheck;
    notifyListeners();
  }

  onEmailEditChangeText(String value) {
    currentEmailValue = value;
    notifyListeners();
  }

  onCheckWithNextPage(BuildContext context) async {
    var emailCheck = await _emailCheckComponentController.valid();
    var pwCheck = await _pwInputAndCheckComponentController.valid();
    if (emailCheck && pwCheck) {
      _fUserInfoJoinReqDto.email = _emailCheckComponentController.emailValue;
      _fUserInfoJoinReqDto.password =
          _pwInputAndCheckComponentController.getPwValue();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return L008MainPage();
      }));
    }
  }

  get _nextButtonSatisfied {
    return currentEmailValue.isNotEmpty &&
        currentPwValue.isNotEmpty &&
        currentPwCheckValue.isNotEmpty;
  }
}
