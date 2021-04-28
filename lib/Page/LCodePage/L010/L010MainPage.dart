import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/FUserUseCaseInputPort/FUserUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Components/DottedLine/DottedLine.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L010MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L010MainPageViewModel(sl(),sl()),
        child: Consumer<L010MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            '경고 레벨 : ${model._fUserInfoResDto!.maliciousCount}',
                            style: GoogleFonts.notoSans(
                              fontSize: 20,
                              color: const Color(0xff000000),
                              letterSpacing: -0.4,
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
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
                                      '악성 컨텐츠 게시로 경고를 받았습니다.\n추가 경고를 받으면 사용이 제한됩니다.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: DottedLine(
                            dashColor: Color(0xffDADBDD),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            '제한 사유 : ${model._fUserInfoResDto!.maliciousCause != null ? model._fUserInfoResDto!.maliciousCause : '-'}',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xff000000),
                              letterSpacing: 0.28,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            '해제 일시 : ${model._fUserInfoResDto!.stopPeriod != null ? model._fUserInfoResDto!.stopPeriod : '-'}',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xff000000),
                              letterSpacing: 0.28,
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 16, left: 16, bottom: 26),
                                    height: 52,
                                    child: FlatButton(
                                      color: Color(0xff3497FD),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(23)),
                                          side: BorderSide(
                                              color: Color(0xff4F72FF))),
                                      child: Text("확인",
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                            color: const Color(0xfff9f9f9),
                                            fontWeight: FontWeight.w500,
                                          )),
                                      onPressed: () {
                                        model.onMessageCheck(context);
                                      },
                                    )))
                          ],
                        )
                      ])));
        }));
  }
}

class L010MainPageViewModel extends ChangeNotifier {
  final SignInUserInfoUseCaseInputPort? _signInUserInfoUseCaseInputPort;

  FUserInfoResDto? _fUserInfoResDto;

  FUserUseCaseInputPort? _fUserUseCaseInputPort;

  L010MainPageViewModel(this._signInUserInfoUseCaseInputPort,this._fUserUseCaseInputPort) {
    this._fUserInfoResDto =
        this._signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory();
  }

  onMessageCheck(BuildContext context) async {
    await _fUserUseCaseInputPort!.updateMaliciousMessageCheck();
    Navigator.of(context).pop();
  }
}
