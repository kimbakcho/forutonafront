import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Components/PwInputAndCheckComponent/PwInputAndCheckComponent.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G012MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G012MainPageViewModel(sl(), sl(), sl(), sl()),
        child: Consumer<G012MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                      title: "패스워드 재설정",
                      visibleTailButton: true,
                      enableTailButton: model._isCanComplete,
                      onTailButtonClick: () {
                        model._changePw(context);
                      },
                      tailButtonLabel: "완료",
                      progressValue: 0,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          constraints: BoxConstraints.tightForFinite(),

                          decoration: BoxDecoration(
                              color: Color(0xffF2F3F5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Color(0xffE4E7E8))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('권장사항',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '* 패스워드는 주기적으로 바꾸어 사용하는 것이 안전합니다.\n'
                                  '* 패스워드는 8-16자리 영문 대소문자, 숫자, 특수문자를 조합하여 사용하면 도용의 위험이 줄어듭니다.\n',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color: const Color(0xff3a3e3f),
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ])),
                      SizedBox(height: 36),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '패스워드 변경',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff000000),
                                letterSpacing: -0.28,
                                fontWeight: FontWeight.w700,
                                height: 1.2142857142857142,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Stack(
                                  children: [
                                    TextField(
                                      obscureText: true,
                                      controller:
                                          model._currentPwFieldController,
                                      decoration: InputDecoration(
                                          errorText: model.currentPwErrorFlag
                                              ? model.currentPwErrorText
                                              : null,
                                          hintText: "현재 패스워드 입력",
                                          hintStyle: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: const Color(0xffb1b1b1),
                                            letterSpacing: -0.28,
                                            fontWeight: FontWeight.w300,
                                            height: 1.2142857142857142,
                                          )),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 13,
                                        child: model.currentPwCheckComplete
                                            ? Icon(Icons.check_circle,
                                                color: Colors.blue)
                                            : Container())
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(height: 30),
                            PwInputAndCheckComponent(
                                pwInputAndCheckComponentController:
                                    model._pwInputAndCheckComponentController,
                                passwordHintLabel: "새 패스워드 입력",
                                passwordCheckHintLabel: "새 패스워드 확인",
                                visibleTitleLabel: false)
                          ],
                        ),
                      )
                    ])))
                  ])));
        }));
  }
}

class G012MainPageViewModel extends ChangeNotifier {
  PwInputAndCheckComponentController _pwInputAndCheckComponentController;

  TextEditingController _currentPwFieldController;

  String currentPw = "";

  String newPassword = "";

  String newPasswordCheck = "";

  String currentPwErrorText = "";

  bool currentPwErrorFlag = false;

  bool currentPwCheckComplete = false;

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  FUserPwChangeUseCaseInputPort _fUserPwChangeUseCaseInputPort;

  MainPageViewModelController _mainPageViewModelController;

  G012MainPageViewModel(
      this._fireBaseAuthAdapterForUseCase,
      this._signInUserInfoUseCaseInputPort,
      this._fUserPwChangeUseCaseInputPort,
      this._mainPageViewModelController) {
    _pwInputAndCheckComponentController =
        PwInputAndCheckComponentController(onChangeEditValue: (pw, pwCheck) {
      newPassword = pw;
      newPasswordCheck = pwCheck;
      notifyListeners();
    });

    _currentPwFieldController = TextEditingController();
    _currentPwFieldController.addListener(() {
      currentPwCheckComplete = false;
      currentPw = _currentPwFieldController.text;
      notifyListeners();
    });
  }

  bool get _isCanComplete {
    return currentPw.isNotEmpty &&
        newPassword.isNotEmpty &&
        newPasswordCheck.isNotEmpty;
  }

  _changePw(BuildContext context) async {
    var reqSignInUserInfoFromMemory =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    try {
      await this._fireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(
          reqSignInUserInfoFromMemory.email, currentPw);
    } catch (ex) {
      currentPwErrorFlag = true;
      currentPwErrorText = "*현재 패스워드와 일치하지 않습니다.";
      notifyListeners();
      return;
    }
    currentPwCheckComplete = true;
    notifyListeners();
    var result = await _pwInputAndCheckComponentController.valid();

    if (result) {
      Fluttertoast.showToast(msg: "패스워드를 변경하였습니다.");
      await _fUserPwChangeUseCaseInputPort.pwChange(newPassword);
      _fireBaseAuthAdapterForUseCase.logout();
      _mainPageViewModelController.moveToMainPage(BottomNavigationNavType.HOME);
      Navigator.of(context).popUntil((route) => route.settings.name == 'MAIN');
    }
  }
}
