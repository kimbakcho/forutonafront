import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/Notification/Domain/NotificationUseCase/NotificationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Notification/Domain/NotificationUseCaseFactory.dart';
import 'package:forutonafront/AppBis/Notification/Value/NotificationServiceType.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/KeyHash/KeyHash.dart';
import 'package:forutonafront/Page/GCodePage/GCodeMainPage.dart';
import 'package:forutonafront/Page/HCodePage/H002/BottomMakeComponent/BottomMakeComponent.dart';
import 'package:forutonafront/Page/HomePage/HomeMainPage.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Mode.dart';
import 'package:forutonafront/Page/KTCodePage/KT001/KT001Page.dart';
import 'package:forutonafront/Page/LCodePage/L010/L010MainPage.dart';
import 'package:forutonafront/Page/LCodePage/L011/L011MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';
import 'package:otp_autofill/otp_autofill.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'BottomNavigation.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainPageViewModel(sl(), context, sl(), sl(),sl()),
        child: Consumer<MainPageViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: model.isNotLockMaliciousUser
                  ? Container(
                      child: Column(children: [
                      Expanded(
                          child: model.isCheckPositionPermission
                              ? Container(
                                  color: Colors.white,
                                )
                              : PageView(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: model._pageController,
                                  children: [
                                      HomeMainPage(
                                        key: model.homepageWidgetKey,
                                      ),
                                      KT001Page(),
                                      GCodeMainPage(key: model.gCodeMainKey),
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
  final BuildContext? context;

  Key? homepageWidgetKey;

  PageController _pageController = PageController();

  MainPageViewModelController? _mainPageViewModelController;

  final SignInUserInfoUseCaseInputPort? _signInUserInfoUseCaseInputPort;

  final GeoLocationUtilForeGroundUseCaseInputPort?
      _geoLocationUtilForeGroundUseCaseInputPort;

  Key gCodeMainKey = UniqueKey();

  bool isCheckPositionPermission = true;

  final UserPositionForegroundMonitoringUseCaseInputPort? userPositionForegroundMonitoringUseCaseInputPort;

  MainPageViewModel(
      this._signInUserInfoUseCaseInputPort,
      this.context,
      this._mainPageViewModelController,
      this._geoLocationUtilForeGroundUseCaseInputPort,
      this.userPositionForegroundMonitoringUseCaseInputPort) {

    initSignKey();

    homepageWidgetKey = Key(Uuid().v4());
    _signInUserInfoUseCaseInputPort!.fUserInfoStream!.listen(onLoginStateChange);

    this._mainPageViewModelController!._mainPageViewModel = this;

    checkPositionPermission();

    if (_signInUserInfoUseCaseInputPort!.isLogin!) {
      var fUserInfoResDto =
          _signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory();
      Future.delayed(Duration.zero, () {
        onLoginStateChange(fUserInfoResDto!);
      });
    }

    userPositionForegroundMonitoringUseCaseInputPort!
        .startUserPositionMonitoringAndUpdateToServer();

    _signInUserInfoUseCaseInputPort!.fUserInfoStream!.listen((event) {
      gCodeMainKey = UniqueKey();
    });
    initStatueBar();
    _configureSelectNotificationSubject();
  }
  void _configureSelectNotificationSubject() async {

      selectNotificationSubject.listen((String payload) async {
        Map<String, dynamic> message = json.decoder.convert(payload);
        NotificationServiceType notificationServiceType = EnumToString.fromString(NotificationServiceType.values, message["serviceKey"])!;
        NotificationUseCaseInputPort notificationUseCaseInputPort = NotificationUseCaseFactory.create(notificationServiceType);
        notificationUseCaseInputPort.selectAction(context!, message['payload']);
      });

  }


  checkPositionPermission() async {
    await Future.delayed(Duration(milliseconds: 500));
    var isCanUseGps =
        await _geoLocationUtilForeGroundUseCaseInputPort!.useGpsReq();
    if (!isCanUseGps) {
      SystemNavigator.pop();
    }
    isCheckPositionPermission = false;
    notifyListeners();
  }

  Future<void> onLoginStateChange(FUserInfoResDto fUserInfoResDto) async {
    if (_signInUserInfoUseCaseInputPort!.checkMaliciousPopup()) {
      Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
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
        _pageController.jumpToPage(2);
        break;
    }
    notifyListeners();
  }

  get isNotLockMaliciousUser {
    if (_signInUserInfoUseCaseInputPort!.isLogin!) {
      var reqSignInUserInfoFromMemory =
          _signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory();
      if (reqSignInUserInfoFromMemory!.stopPeriod != null &&
          reqSignInUserInfoFromMemory.stopPeriod!.isAfter(DateTime.now())) {
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
        context: context!,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return BottomMakeComponent(
            makeBallPop: () {
              homepageWidgetKey = Key(Uuid().v4());
              notifyListeners();
            },
          );
        });
    if (result is FBallResDto) {
      Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
        return ID01MainPage(
            id01Mode: ID01Mode.publish,
            fBallResDto: result,
            ballUuid: result.ballUuid);
      }));
    }
  }

  void initStatueBar() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        // Color for Android
        statusBarBrightness: Brightness.dark,
        // Dark ,== white status bar -- for IOS.
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white));
  }

  void initSignKey() async {
    String? yourKeyHash;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      yourKeyHash = await KeyHash.getKeyHash();
      print("yourKeyHash = $yourKeyHash");
    } on PlatformException {
      yourKeyHash = 'Failed to get platform version.';
    }

    String? signature = await OTPInteractor.getAppSignature();
    print("sms KeyHash = $signature");
  }
}

@lazySingleton
class MainPageViewModelController {
  MainPageViewModel? _mainPageViewModel;

  moveToMainPage(BottomNavigationNavType bottomNavigationNavType) {
    _mainPageViewModel!.onBottomNavClick(bottomNavigationNavType);
  }

  BottomNavigationNavType getMainPageCurrentPage() {
    if (_mainPageViewModel == null || _mainPageViewModel!._pageController.positions.isEmpty) {
      return BottomNavigationNavType.HOME;
    }
    double current = _mainPageViewModel!._pageController.page!;
    if (current == 0) {
      return BottomNavigationNavType.HOME;
    } else if (current == 1) {
      return  BottomNavigationNavType.SNS;
    } else if (current == 2) {
      return BottomNavigationNavType.MakeBall;
    } else if (current == 3) {
      return BottomNavigationNavType.SEARCH;
    } else if (current == 4) {
      return BottomNavigationNavType.Profile;
    } else {
      return BottomNavigationNavType.HOME;
    }
  }
}
