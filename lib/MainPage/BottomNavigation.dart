import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/GCodePage/G001/G001MainPageTemp.dart';
import 'package:forutonafront/Page/GCodePage/GCodeMainPage.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'KPageNavBtn.dart';
import 'MainPageView.dart';

enum BottomNavigationNavType { HOME, SEARCH, MakeBall, SNS, Profile }

class BottomNavigation extends StatefulWidget {
  final BottomNavigationListener? bottomNavigationListener;

  const BottomNavigation({Key? key, this.bottomNavigationListener})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            BottomNavigationViewModel(
                context: context, signInUserInfoUseCaseInputPort: sl(),mainPageViewModelController: sl()),
        child: Consumer<BottomNavigationViewModel>(builder: (_, model, __) {
          return Consumer<BottomNavigationViewModel>(
              builder: (_, model, child) {
                return Container(
                    height: 52,
                    child: Row(children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                            onPressed: () {
                              model.gotoHomePage(widget.bottomNavigationListener);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                model.getMainCurrentPage() == BottomNavigationNavType.HOME ?
                                Icon(ForutonaIcon.home_b__circle,size: 22,) : Icon(ForutonaIcon.home_circle,size: 22),
                                SizedBox(height: 6,),
                                Text(
                                  '리스트',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 9,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )),
                      Expanded(flex: 1, child: KPageNavBtn()),
                      Expanded(
                          flex: 1,
                          child:
                          FlatButton(onPressed: () {
                            if (model.isLogin) {
                              widget.bottomNavigationListener!
                                  .onBottomNavClick(
                                  BottomNavigationNavType.MakeBall);
                            }else {
                              model.showL001BottomSheet();
                            }
                          } , child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(ForutonaIcon.makecircle2,size: 20),
                              SizedBox(height: 6,),
                              Text(
                                '만들기',
                                style: GoogleFonts.notoSans(
                                  fontSize: 9,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ))),
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                              onPressed: () {
                                if (widget.bottomNavigationListener != null) {
                                  widget.bottomNavigationListener!
                                      .onBottomNavClick(
                                      BottomNavigationNavType.SNS);
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  model.getMainCurrentPage() == BottomNavigationNavType.SNS ?
                                  Container(
                                    height: 22,
                                      child:Icon(ForutonaIcon.chat2,size: 19)
                                  )  :
                                  Container(
                                      height: 22,
                                      child:Icon(ForutonaIcon.chat,size: 22)
                                  )  ,
                                  SizedBox(height: 6,),
                                  Text(
                                    '피드백',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 9,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ))),
                      Expanded(
                        flex: 1,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (model.isLogin) {
                                if (widget.bottomNavigationListener != null) {
                                  widget.bottomNavigationListener!
                                      .onBottomNavClick(
                                      BottomNavigationNavType.Profile);
                                }
                              } else {
                                model.showL001BottomSheet();
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                model._getProfilePictureWidget(),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text('프로필',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 9,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w300,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                    decoration: BoxDecoration(
                        color: Color(0xffffffff), boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff2F3035),
                        blurRadius: 6,
                      )
                    ]));
              });
        }));
  }
}

class BottomNavigationViewModel extends ChangeNotifier {
  final SignInUserInfoUseCaseInputPort? signInUserInfoUseCaseInputPort;
  final BuildContext? context;
  final MainPageViewModelController? mainPageViewModelController;

  BottomNavigationViewModel(
      {this.context, this.signInUserInfoUseCaseInputPort,required this.mainPageViewModelController}) {
    signInUserInfoUseCaseInputPort!.fUserInfoStream!.listen((event) {
      notifyListeners();
    });
  }

  bool get isLogin {
    return this.signInUserInfoUseCaseInputPort!.isLogin!;
  }

  String get profileImageUrl {
    return this
        .signInUserInfoUseCaseInputPort!
        .reqSignInUserInfoFromMemory()!
        .profilePictureUrl!;
  }

  BottomNavigationNavType getMainCurrentPage(){
    var mainPageCurrentPage = mainPageViewModelController!.getMainPageCurrentPage();
    return mainPageCurrentPage;
  }

  Widget _getEmptyProfileImage() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset("assets/IconImage/user-circle.svg"),
    );
  }

  Widget _getProfilePictureWidget() {
    if (isLogin) {
      if (profileImageUrl == null) {
        return _getEmptyProfileImage();
      } else {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(profileImageUrl))),
        );
      }
    } else {
      return _getEmptyProfileImage();
    }
  }

  showL001BottomSheet() {
    showMaterialModalBottomSheet(
        context: context!,
        expand: false,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (context) {
          return L001BottomSheet();
        });
  }

  jumpToPersona() {
    Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
      return GCodeMainPage();
    }));
  }

  void gotoHomePage(BottomNavigationListener? bottomNavigationListener) {
    if (bottomNavigationListener != null) {
      bottomNavigationListener
          .onBottomNavClick(
          BottomNavigationNavType.HOME);
    }
    notifyListeners();
  }

}

abstract class BottomNavigationListener {
  void onBottomNavClick(BottomNavigationNavType bottomNavigationNavType);
}
