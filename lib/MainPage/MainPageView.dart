import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Page/GCodePage/GCodeMainPage.dart';
import 'package:forutonafront/Page/HCodePage/H002/BottomMakeComponent/BottomMakeComponent.dart';
import 'package:forutonafront/Page/HomePage/HomeMainPage.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Mode.dart';
import 'package:forutonafront/Page/LCodePage/L010/L010MainPage.dart';
import 'package:forutonafront/Page/LCodePage/L011/L011MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'BottomNavigation.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainPageViewModel(sl(), context, sl()),
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
                            HomeMainPage(
                              key: model.homepageWidgetKey,
                            ),
                            GCodeMainPage(
                              key: model.gCodeMainKey
                            ),
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

  Key homepageWidgetKey;

  PageController _pageController = PageController();

  MainPageViewModelController _mainPageViewModelController;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  Key gCodeMainKey = UniqueKey();

  MainPageViewModel(this._signInUserInfoUseCaseInputPort, this.context,
      this._mainPageViewModelController) {
    homepageWidgetKey = Key(Uuid().v4());
    _signInUserInfoUseCaseInputPort.fUserInfoStream.listen(onLoginStateChange);

    this._mainPageViewModelController._mainPageViewModel = this;

    if (_signInUserInfoUseCaseInputPort.isLogin) {
      var fUserInfoResDto =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      Future.delayed(Duration.zero, () {
        onLoginStateChange(fUserInfoResDto);
      });
    }

    _signInUserInfoUseCaseInputPort.fUserInfoStream.listen((event) {
      gCodeMainKey = UniqueKey();
    });
  }

  Future<void> onLoginStateChange(FUserInfoResDto fUserInfoResDto) async {
    if (_signInUserInfoUseCaseInputPort.checkMaliciousPopup()) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
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
      case BottomNavigationNavType.MakeBall:
        _actionMakeBall();
        break;
      case BottomNavigationNavType.SEARCH:
        break;
      case BottomNavigationNavType.Profile:
        _pageController.jumpToPage(1);
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

  _actionMakeBall() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return BottomMakeComponent(
            makeBallPop: () {
              homepageWidgetKey = Key(Uuid().v4());
              notifyListeners();
            },
          );
        });
    if(result is FBallResDto){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return ID01MainPage(
          id01Mode: ID01Mode.publish,
          fBallResDto: result,
          ballUuid: result.ballUuid
        );
      }));
    }
  }
}

@lazySingleton
class MainPageViewModelController {
  MainPageViewModel _mainPageViewModel;

  moveToMainPage(BottomNavigationNavType bottomNavigationNavType) {
    _mainPageViewModel.onBottomNavClick(bottomNavigationNavType);
  }
}
