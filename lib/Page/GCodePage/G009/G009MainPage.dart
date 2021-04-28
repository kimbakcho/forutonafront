import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:forutonafront/Page/GCodePage/Component/GCodeLineButtonComponent.dart';

import 'package:forutonafront/Page/GCodePage/G010/G010MainPage.dart';
import 'package:forutonafront/Page/GCodePage/G011/G011MainPage.dart';
import 'package:forutonafront/Page/GCodePage/G015/G015MainPage.dart';
import 'package:forutonafront/Page/GCodePage/G016/G016MainPage.dart';
import 'package:forutonafront/Page/GCodePage/G019/G019MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G009MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G009MainPageViewModel(sl(), sl(), sl(),sl()),
        child: Consumer<G009MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                      title: "설정",
                      progressValue: 0,
                      visibleTailButton: false,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                      GCodeLineButtonComponent(
                        icon: Icon(
                          ForutonaIcon.user,
                          color: Colors.black,
                          size: 30,
                        ),
                        text: "계정",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return G010MainPage();
                          }));
                        },
                      ),
                      GCodeLineButtonComponent(
                        icon: Icon(
                          ForutonaIcon.lock,
                          color: Colors.black,
                          size: 30,
                        ),
                        text: "보안",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return G011MainPage();
                          }));
                        },
                      ),
                      GCodeLineButtonComponent(
                        icon: Icon(
                          ForutonaIcon.door_open,
                          color: Colors.black,
                          size: 30,
                        ),
                        text: "공개범위",
                        onTap: () {
                          Fluttertoast.showToast(msg: "준비중입니다");
                        },
                      ),
                      GCodeLineButtonComponent(
                        icon: Icon(
                          ForutonaIcon.bell_g009,
                          color: Colors.black,
                          size: 30,
                        ),
                        text: "알림",
                        onTap: () {
                          Fluttertoast.showToast(msg: "준비중입니다");
                          // Navigator.of(context).push(MaterialPageRoute(builder: (_){
                          //   return G015MainPage();
                          // }));
                        },
                      ),
                      Divider(color: Color(0xffE4E7E8)),
                      Material(
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_){
                                  return G016MainPage();
                                }
                              ));
                            },
                            child: Container(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(ForutonaIcon.info_circle,
                                          color: Colors.black, size: 30),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "공지 사항",
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          color: const Color(0xff3a3e3f),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ]))),
                        color: Colors.transparent,
                      ),
                      GCodeLineButtonComponent(
                        icon: Icon(
                          ForutonaIcon.help_circle,
                          color: Colors.black,
                          size: 30,
                        ),
                        text: "고객센터",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return G019MainPage();
                          }));
                        },
                      ),
                      Material(
                        child: InkWell(
                            onTap: () {
                              Fluttertoast.showToast(msg: "준비중입니다");
                            },
                            child: Container(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Column(children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.save_outlined,
                                            color: Colors.black, size: 30),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "버전 정보",
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: const Color(0xff3a3e3f),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ]),
                                  Row(children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 42),
                                        child: Text(
                                          '현재 최신 버전입니다.',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 12,
                                            color: const Color(0xff3497fd),
                                            letterSpacing: -0.24,
                                          ),
                                          textAlign: TextAlign.left,
                                        ))
                                  ])
                                ]))),
                        color: Colors.transparent,
                      )
                    ]))),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 16, 25),
                                height: 52,
                                child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(26)),
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(26)),
                                        onTap: () {
                                          model._logout(context);
                                        },
                                        child: Center(
                                            child: Text(
                                          '로그아웃',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                            color: const Color(0xff000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        )))),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26.0),
                                    color: const Color(0xfff6f6f6),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xff454f63)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      )
                                    ])))
                      ],
                    )
                  ])));
        }));
  }
}

class G009MainPageViewModel extends ChangeNotifier {
  final LogoutUseCaseInputPort _logoutUseCaseInputPort;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  final MainPageViewModelController _mainPageViewModelController;

  G009MainPageViewModel(
      this._logoutUseCaseInputPort,
      this._signInUserInfoUseCaseInputPort,
      this._fireBaseAuthAdapterForUseCase,
      this._mainPageViewModelController);

  _logout(BuildContext context) async {

    var reqSignInUserInfoFromMemory =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();

    if (reqSignInUserInfoFromMemory!.snsService != SnsSupportService.Forutona) {
      await this._logoutUseCaseInputPort.tryLogout();
    }

    await this._fireBaseAuthAdapterForUseCase.logout();

    _mainPageViewModelController.moveToMainPage(BottomNavigationNavType.HOME);

    Navigator.of(context).pop();


  }
}
