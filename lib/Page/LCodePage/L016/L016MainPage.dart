import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/EmailValidImpl.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DontHaveIdError.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/IdDuplicationValidImpl.dart';
import 'package:forutonafront/Components/EmailCheckComponent/EmailCheckComponent.dart';
import 'package:forutonafront/Page/LCodePage/L017/L017MainPage.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L016MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L016MainPageViewModel(sl()),
        child: Consumer<L016MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
            body: Container(
                padding: MediaQuery.of(context).padding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LCodeAppBar(
                          title: "이메일 인증하기",
                          visibleTailButton: true,
                          enableTailButton: model.isCanNext,
                          onTailButtonClick: () {
                            model._nextPage(context);
                          },
                          tailButtonLabel: "다음",
                          progressValue: 0.5),

                      Expanded(
                          child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.white,
                                margin: EdgeInsets.only(right: 16, left: 16),
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
                                          text: '사용중이신 계정의 이메일 주소를 입력하세요.\n',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                '패스워드 변경을 위해서는 이메일 주소가 필요합니다.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ))
                                      ]),
                                )),
                            SizedBox(
                              height: 33,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16,right: 16),
                              child: EmailCheckComponent(
                                emailCheckComponentController:
                                model._emailCheckComponentController,
                                emailValid: IdDuplicationValidImpl(
                                    emailValid: EmailValidImpl(),
                                    fireBaseAuthAdapterForUseCase: sl(),
                                    duplicationErrorLogin: DontHaveIdError()),
                              ),
                            )

                          ],
                        ),
                      ))
                    ])),
          );
        }));
  }
}

class L016MainPageViewModel extends ChangeNotifier {
  EmailCheckComponentController _emailCheckComponentController;

  String currentEmail = "";

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  L016MainPageViewModel(this._fireBaseAuthAdapterForUseCase) {
    _emailCheckComponentController =
        EmailCheckComponentController(onChangeEditText: (value) {
      currentEmail = value;
      notifyListeners();
    });
  }

  bool get isCanNext {
    return currentEmail.isNotEmpty;
  }

  _nextPage(BuildContext context) async {
    var result = await _emailCheckComponentController.valid();
    if (result) {
      await this._fireBaseAuthAdapterForUseCase.sendPasswordResetEmail(currentEmail);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return L017MainPage(email: currentEmail);
      }));
    }
  }
}
