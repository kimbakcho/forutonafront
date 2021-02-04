import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/SignSheet/SiginButton/SignButton.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/SignSheet/SignSheetOutputPort.dart';
import 'package:forutonafront/Page/LCodePage/L002/L002MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'SiginButton/SignButtonOutputPort.dart';

class SignSheet extends StatelessWidget {
  final SignSheetOutputPort signSheetOutputPort;


  const SignSheet({Key key, this.signSheetOutputPort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SignSheetViewModel(context, sl(), sl(),sl()),
        child: Consumer<SignSheetViewModel>(builder: (_, model, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16),
                  child: Text(
                    '가입하기',
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
                    '포루투나에 가입하고 모든 기능을 이용해 보세요!',
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
                SignButton(
                    snsSupportService: SnsSupportService.Naver,
                    signButtonOutputPort: model,
                    label: "Naver ID로 진행",
                    imagePath: "assets/LoginIcon/NaverLogo.png"),
                SizedBox(
                  height: 12,
                ),
                SignButton(
                    snsSupportService: SnsSupportService.FaceBook,
                    signButtonOutputPort: model,
                    label: "FaceBook ID로 진행",
                    imagePath: "assets/LoginIcon/FacebookLogo.png"),
                SizedBox(
                  height: 12,
                ),
                SignButton(
                    snsSupportService: SnsSupportService.Kakao,
                    signButtonOutputPort: model,
                    label: "KakaoTalk Id으로 진행",
                    imagePath: "assets/LoginIcon/KakaoTalkLogo.png"),
                SizedBox(
                  height: 12,
                ),
                SignButton(
                    snsSupportService: SnsSupportService.Forutona,
                    signButtonOutputPort: model,
                    label: "등록된 이메일주소 사용",
                    imagePath: "assets/LoginIcon/EmailLogo.png"),
                Spacer(),
                Container(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "이미 계정이 있으신가요?",
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
                                signSheetOutputPort.moveToLoginPage();
                              },
                              child: Text(
                                "로그인하기",
                                style: GoogleFonts.notoSans(
                                    fontSize: 15,
                                    color: const Color(0xffff4f9a),
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
        }));
  }
}

class SignSheetViewModel extends ChangeNotifier
    implements SignButtonOutputPort {
  final BuildContext context;

  final FUserInfoJoinReqDto fUserInfoJoinReqDto;

  final SnsLoginModuleAdapterFactory snsLoginModuleAdapterFactory;

  final SingUpUseCaseInputPort singUpUseCaseInputPort;


  SignSheetViewModel(this.context, this.fUserInfoJoinReqDto,
      this.snsLoginModuleAdapterFactory, this.singUpUseCaseInputPort);



  @override
  trySign(SnsSupportService snsSupportService) async {
    fUserInfoJoinReqDto.snsSupportService = snsSupportService;
    if (snsSupportService == SnsSupportService.Forutona) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) {
            return L002MainPage();
          }));
    } else {
      Provider.of<L001BottomSheetViewModel>(context,listen: false).setLoading(true);
      await singUpUseCaseInputPort.trySignSns(snsSupportService, context);

      Provider.of<L001BottomSheetViewModel>(context,listen: false).setLoading(false);
    }
  }
}


