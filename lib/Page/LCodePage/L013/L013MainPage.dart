import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/EmailValidImpl.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DontHaveIdError.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/IdDuplicationValidImpl.dart';
import 'package:forutonafront/Components/EmailCheckComponent/EmailCheckComponent.dart';
import 'package:forutonafront/Page/LCodePage/L014/L014MainPage.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L013MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L013MainPageViewModel(sl()),
        child: Consumer<L013MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                      title: "휴대폰 인증하기",
                      visibleTailButton: true,
                      progressValue: 0.3,
                      tailButtonLabel: "다음",
                      onTailButtonClick: () {
                        if (model._isCanNext) {
                          model._nextPage(context);
                        }
                      },
                      enableTailButton: model._isCanNext,
                    ),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  SizedBox(
                                    height: 21,
                                  ),
                                  Container(
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
                                                    '찾으시는 패스워드의 아이디를 입력하세요.\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            TextSpan(
                                                text:
                                                    '휴대폰 인증을 위해서는 등록된 아이디가 필요합니다.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                ))
                                          ]),
                                      textAlign: TextAlign.left,
                                    ),
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                  ),
                                  SizedBox(
                                    height: 34,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: EmailCheckComponent(
                                      emailCheckComponentController:
                                          model._emailCheckComponentController,
                                      emailValid: IdDuplicationValidImpl(
                                          emailValid: EmailValidImpl(),
                                          fireBaseAuthAdapterForUseCase: sl(),
                                          duplicationErrorLogin:
                                              DontHaveIdError()),
                                    ),
                                  )
                                ]))))
                  ])));
        }));
  }
}

class L013MainPageViewModel extends ChangeNotifier {
  EmailCheckComponentController? _emailCheckComponentController;

  String _currentEmailId = "";

  final PwChangeFromPhoneAuthReqDto? _pwChangeFromPhoneAuthReqDto;

  L013MainPageViewModel(this._pwChangeFromPhoneAuthReqDto) {
    _emailCheckComponentController =
        EmailCheckComponentController(onChangeEditText: (value) {
      _currentEmailId = value;
      notifyListeners();
    });
  }

  bool get _isCanNext {
    return _currentEmailId.isNotEmpty;
  }

  _nextPage(BuildContext context) async {
    bool result = await _emailCheckComponentController!.valid();
    if (result) {
      _pwChangeFromPhoneAuthReqDto!.email = _emailCheckComponentController!.emailValue;
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return L014MainPage();
      }));
    }else {
      notifyListeners();
    }
  }
}
