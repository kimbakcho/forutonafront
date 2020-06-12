import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/BCodePage/BCodeMainPage.dart';
import 'package:forutonafront/GCodePage/GCodeMainPage.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/HCodeMainPage.dart';
import 'package:forutonafront/ICodePage/ICodeMainPage.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:provider/provider.dart';

class CodeMainpage extends StatefulWidget {
  CodeMainpage({Key key}) : super(key: key);

  @override
  _CodeMainpageState createState() => _CodeMainpageState();
}

class _CodeMainpageState extends State<CodeMainpage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CodeMainViewModel>(
            create: (_) => CodeMainViewModel(context)),
        ChangeNotifierProvider<H001ViewModel>(
            create: (_) => H001ViewModel(context: context))
      ],
      child: Consumer<CodeMainViewModel>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Color(0xffF2F0F1),
          body: Stack(children: <Widget>[
            Container(
                child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: model.pageController,
                    children: <Widget>[
                  HCodeMainPage(),
                  ICodeMainPage(),
                  BCodeMainPage(),
                  Container(
                    child: Text("4"),
                  ),
                  GCodeMainPage()
                ]))
          ]),
        );
      }),
    );
  }
}
