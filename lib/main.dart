import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forutonafront/MainModel.dart';
import 'package:forutonafront/MainPage/InitPage.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Splash/SplashPage.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:provider/provider.dart';

import 'MainPage/MainPageView.dart';
//flutter pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs

void main() {
  configureDependencies();
  // di.init();
  runApp(
    MyApp(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = Preference.kaKaoNativeApiKey;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarBrightness: Brightness.light,
    //   systemNavigationBarColor: Colors.black,));
    return ChangeNotifierProvider(
        create: (_) => MainModel(
            fireBaseAuthAdapterForUseCase: sl(),
            fireBaseMessageController: sl(),
            flutterLocalNotificationsPluginAdapter: sl(),
            mapMakerDescriptorContainer: sl()),
        child: Consumer<MainModel>(builder: (_, model, child) {
          return MaterialApp(
              title: 'Kuv',
              localizationsDelegates: [
                // ... app-specific localization delegate[s] here
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              initialRoute: '/',
              routes: {
                // When navigating to the "/" route, build the FirstScreen widget.
                // When navigating to the "/second" route, build the SecondScreen widget.
              },
              supportedLocales: [const Locale('en'), const Locale('ko')],
              theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // Try running your application with "flutter run". You'll see the
                  // application has a blue toolbar. Then, without quitting the app, try
                  // changing the primarySwatch below to Colors.green and then invoke
                  // "hot reload" (press "r" in the console where you ran "flutter run",
                  // or simply save your changes to "hot reload" in a Flutter IDE).
                  // Notice that the counter didn't reset back to zero; the application
                  // is not restarted.
                  bottomSheetTheme: BottomSheetThemeData(
                      backgroundColor: Colors.black.withOpacity(0)),
                  primaryColor: Color(0xff3497FD),
                  unselectedWidgetColor: Colors.grey),
              home: InitPage());
        }));
  }
}
