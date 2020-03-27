import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/MakePage/GoogleMapsMakeView.dart';
import 'package:forutonafront/MakePage/SelectSwipeCubeView.dart';
import 'package:forutonafront/Splash/SplashPage.dart';
import 'package:provider/provider.dart';
import 'globals.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalModel(),
      child: MyApp()),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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
          primaryColor: Color(0xFF39F999),
          unselectedWidgetColor: Colors.grey),

      // home: MainPage()
      home: SplashPage(),
    );
  }
}
