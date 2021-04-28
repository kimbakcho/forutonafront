import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/NotJoinException.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/Page/LCodePage/L009/L009BottomSheet.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'LoginButton/LoginButton.dart';
import 'LoginButton/LoginButtonOutputPort.dart';
import 'LoginSheetOutputPort.dart';

class LoginSheet extends StatelessWidget {
  final LoginSheetOutputPort? loginSheetOutputPort;

  LoginSheet({this.loginSheetOutputPort});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginSheetViewModel(sl(), sl(), sl()),
      child: Consumer<LoginSheetViewModel>(
        builder: (_, model, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16),
                  child: Text(
                    '로그인',
                    style: GoogleFonts.notoSans(
                      fontSize: 24,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16),
                  child: Text(
                    '볼 만들기, 페르소나, 소셜, 댓글을 이용하실 수 있어요!',
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff3a3e3f),
                      letterSpacing: -0.24,
                      height: 2.0833333333333335,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                LoginButton(
                    snsSupportService: SnsSupportService.Naver,
                    loginButtonOutputPort: model,
                    label: "Naver ID로 진행",
                    imagePath: "assets/LoginIcon/NaverLogo.png"),
                SizedBox(
                  height: 12,
                ),
                // LoginButton(
                //     snsSupportService: SnsSupportService.FaceBook,
                //     loginButtonOutputPort: model,
                //     label: "FaceBook ID로 진행",
                //     imagePath: "assets/LoginIcon/FacebookLogo.png"),
                // SizedBox(
                //   height: 12,
                // ),
                LoginButton(
                    snsSupportService: SnsSupportService.Kakao,
                    loginButtonOutputPort: model,
                    label: "KakaoTalk Id으로 진행",
                    imagePath: "assets/LoginIcon/KakaoTalkLogo.png"),
                SizedBox(
                  height: 12,
                ),
                LoginButton(
                    snsSupportService: SnsSupportService.Forutona,
                    loginButtonOutputPort: model,
                    label: "등록된 이메일주소 사용",
                    imagePath: "assets/LoginIcon/EmailLogo.png"),
                Spacer(),
                Container(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "아직 회원이 아니신가요?",
                        style: GoogleFonts.notoSans(
                            fontSize: 15,
                            color: const Color(0xff000000),
                            letterSpacing: -0.3,
                            height: 1.4666666666666666,
                            fontWeight: FontWeight.w500),
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                loginSheetOutputPort!.moveToSignPage();
                              },
                              child: Text(
                                "가입하기",
                                style: GoogleFonts.notoSans(
                                    fontSize: 15,
                                    color: const Color(0xff3497fd),
                                    letterSpacing: -0.3,
                                    height: 1.4666666666666666,
                                    fontWeight: FontWeight.w500),
                              )))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffe4e7e8),
                  ),
                )
              ]);
        },
      ),
    );
  }
}

class LoginSheetViewModel extends ChangeNotifier
    implements LoginButtonOutputPort {
  final SingUpUseCaseInputPort _singUpUseCaseInputPort;
  final SnsLoginModuleAdapterFactory _snsLoginModuleAdapterFactory;
  final LoginSheetOutputPort? loginSheetOutputPort;

  final FUserInfoJoinReqDto fUserInfoJoinReqDto;

  LoginSheetViewModel(this._singUpUseCaseInputPort,
      this._snsLoginModuleAdapterFactory, this.fUserInfoJoinReqDto,
      {this.loginSheetOutputPort});

  @override
  tryLogin(SnsSupportService snsSupportService, BuildContext context) async {
    if (snsSupportService == SnsSupportService.Naver ||
        snsSupportService == SnsSupportService.FaceBook ||
        snsSupportService == SnsSupportService.Kakao) {
      LoginUseCaseInputPort loginUseCaseInputPort = LoginUseCase(
          singUpUseCaseInputPort: this._singUpUseCaseInputPort,
          snsLoginModuleAdapter:
              _snsLoginModuleAdapterFactory.getInstance(snsSupportService));

      var loginResult = await showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            _tryLoginFunc(loginUseCaseInputPort, context);
            return CommonLoadingComponent();
          });
      if (loginResult is NotJoinException) {
        await showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              trySignSns(context, loginResult.fUserSnSLoginReqDto.snsService!);
              return CommonLoadingComponent();
            });
      }
      Navigator.of(context).popUntil((route) => route.settings.name=="/");

      notifyListeners();
    } else {
      showMaterialModalBottomSheet(
          backgroundColor: Colors.white,
          enableDrag: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0)),
          ),
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  16,
              child: L009BottomSheet(),
            );
          });
    }
  }

  Future<void> _tryLoginFunc(
      LoginUseCaseInputPort loginUseCaseInputPort, BuildContext context) async {
    try {
      await loginUseCaseInputPort.tryLogin();
      Navigator.of(context).pop();
    } on NotJoinException catch (ex) {
      Navigator.of(context).pop(ex);
    }
  }

  trySignSns(BuildContext context, SnsSupportService snsSupportService) async {
    await _singUpUseCaseInputPort.trySignSns(snsSupportService, context);
  }
}
