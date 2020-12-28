import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Page/HomePage/HomeMainPage.dart';
import 'package:forutonafront/Page/LCodePage/L010/L010MainPage.dart';
import 'package:forutonafront/Page/LCodePage/L011/L011MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

import 'BottomNavigation.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainPageViewModel(sl(),context),
        child: Consumer<MainPageViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: model.isNotLockMaliciousUser
                  ? Container(
                      child: Column(children: [
                      Expanded(
                          child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: model._pageController,
                              children: [
                            HomeMainPage(),
                            Container(
                              child: Text("tet"),
                            )
                          ])),
                      BottomNavigation(
                        bottomNavigationListener: model,
                      )
                    ]))
                  : L011MainPage());
        }));
  }
}

class MainPageViewModel extends ChangeNotifier
    implements BottomNavigationListener {

  final BuildContext context;

  PageController _pageController = PageController();


  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;


  MainPageViewModel(this._signInUserInfoUseCaseInputPort,this.context){
    _signInUserInfoUseCaseInputPort.fUserInfoStream.listen(onLoginStateChange);

    if(_signInUserInfoUseCaseInputPort.isLogin){
      var fUserInfoResDto = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      Future.delayed(Duration.zero,(){
        onLoginStateChange(fUserInfoResDto);
      });
    }
  }

  Future<void> onLoginStateChange(FUserInfoResDto fUserInfoResDto) async {
    if(_signInUserInfoUseCaseInputPort.checkMaliciousPopup()){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return L010MainPage();
      }));
    }
  }


  @override
  void onBottomNavClick(BottomNavigationNavType bottomNavigationNavType) {
    switch (bottomNavigationNavType) {
      case BottomNavigationNavType.HOME:
        _pageController.jumpToPage(0);
        break;
      case BottomNavigationNavType.SNS:
        _pageController.jumpToPage(1);
        break;
      case BottomNavigationNavType.SEARCH:
        break;
    }
  }

  get isNotLockMaliciousUser {
    if (_signInUserInfoUseCaseInputPort.isLogin) {
      var reqSignInUserInfoFromMemory =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      if (reqSignInUserInfoFromMemory.stopPeriod != null &&
          reqSignInUserInfoFromMemory.stopPeriod.isAfter(DateTime.now())) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
