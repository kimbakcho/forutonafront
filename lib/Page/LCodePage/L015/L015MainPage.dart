import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/Components/PwInputAndCheckComponent/PwInputAndCheckComponent.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L015MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L015MainPageViewModel(sl(), sl()),
        child: Consumer<L015MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                      title: "신규 패스워드 만들기",
                      progressValue: 1,
                      tailButtonLabel: "완료",
                      onTailButtonClick: () {
                        if (model.isCanComplete) {
                          model._tryPwChange(context);
                        }
                      },
                      enableTailButton: model.isCanComplete,
                      visibleTailButton: true,
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
                                                text: '새로운 패스워드를 등록해주세요. \n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: '패스워드는 8자리 이상이어야 합니다.',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                  ))
                                            ]),
                                        textAlign: TextAlign.left,
                                      )),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: PwInputAndCheckComponent(
                                      pwInputAndCheckComponentController: model
                                          ._pwInputAndCheckComponentController,
                                    ),
                                  )
                                ]))))
                  ])));
        }));
  }
}

class L015MainPageViewModel extends ChangeNotifier {
  PwInputAndCheckComponentController? _pwInputAndCheckComponentController;

  String currentPw = "";

  String currentPwCheck = "";

  final PwFindPhoneUseCaseInputPort? _pwFindPhoneUseCaseInputPort;

  final PwChangeFromPhoneAuthReqDto? _pwChangeFromPhoneAuthReqDto;

  L015MainPageViewModel(
      this._pwFindPhoneUseCaseInputPort, this._pwChangeFromPhoneAuthReqDto) {
    _pwInputAndCheckComponentController =
        PwInputAndCheckComponentController(onChangeEditValue: (pw, pwCheck) {
      currentPw = pw;
      currentPwCheck = pwCheck;
      notifyListeners();
    });
  }

  bool get isCanComplete {
    return currentPw.isNotEmpty && currentPwCheck.isNotEmpty;
  }

  void _tryPwChange(BuildContext context) async {
    bool result = await _pwInputAndCheckComponentController!.valid();
    if (result) {
      _pwChangeFromPhoneAuthReqDto!.password =
          _pwInputAndCheckComponentController!.getPwValue();
      var pwChangeFromPhoneAuthResDto = await _pwFindPhoneUseCaseInputPort!
          .phonePwChange(_pwChangeFromPhoneAuthReqDto!);
      if (!pwChangeFromPhoneAuthResDto.errorFlag!) {
        showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return AlertDialog(
                  actionsPadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.only(left: 16, right: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  titlePadding: EdgeInsets.only(left: 16),
                  title: Text("패스워드 변경 확인"),
                  titleTextStyle: GoogleFonts.notoSans(
                    fontSize: 20,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    height: 2.25,
                  ),
                  content: Container(
                      height: 110,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '패스워드를 변경하였습니다.',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff3a3e3f),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color(0xff454F63)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        onPressed: () {
                                          Navigator.of(context).popUntil((route) => route.settings.name == '/');
                                        },
                                        child: Container(
                                          child: Text(
                                            "확인",
                                            style: GoogleFonts.notoSans(
                                              fontSize: 14,
                                              color: const Color(0xff3a3e3f),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        )))
                              ],
                            )
                          ])));
            });
      }
    }
  }
}
